import 'dart:convert';
import 'package:firebase_functions/firebase_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';
import 'dart:io';

final apiKey = Platform.environment['WEATHER_API_KEY'];

void main() {
  runFunctions((firebase) {
    // https://firebase.google.com/docs/functions/http-events
    firebase.https.onRequest(
      name: 'helloWorld',
      options: const HttpsOptions(
        cors: Cors(['*']),
        // Set maxInstances to control costs during unexpected traffic spikes.
        // https://firebase.google.com/docs/functions/manage-functions#min-max-instances
        maxInstances: Instances(10),
      ),
      (request) async => Response(200, body: 'Hello from Dart Functions!'),
    );

    firebase.https.onRequest(
      name: 'getSimpleForecast',
      options: const HttpsOptions(
        cors: Cors(['*']),
        maxInstances: Instances(10),
      ),
      (request) async {
        try {
          // 1. Get the location name from query parameters, default to Detroit
          final locationName =
              request.url.queryParameters['location'] ?? 'Detroit';

          // 2. Format the location name (turn spaces into '+')
          final formattedLocation = locationName.replaceAll(' ', '+');

          // 3. Construct the URL and fetch the data
          final url = Uri.parse('https://wttr.in/$formattedLocation?format=j1');
          final response = await http.get(url);

          if (response.statusCode != 200) {
            return Response(
              response.statusCode,
              body: 'Failed to fetch weather data.',
            );
          }

          // 4. Decode the JSON response
          final jsonMap = jsonDecode(response.body);

          // 5. Serialize into the Forecast object
          final forecast = Forecast.fromJson(jsonMap);

          // 6. Return the serialized object as JSON string
          return Response(
            200,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(forecast.toJson()),
          );
        } catch (e) {
          return Response(500, body: 'Internal Server Error: $e');
        }
      },
    );

    firebase.https.onRequest(
      name: 'getExtendedForecast',
      options: const HttpsOptions(
        cors: Cors(['*']),
        maxInstances: Instances(10),
      ),
      (request) async {
        try {
          // 1. Get the API key
          final apiKey = Platform.environment['WEATHER_API_KEY'];
          if (apiKey == null || apiKey.isEmpty) {
            return Response(
              500,
              body: 'Missing WEATHER_API_KEY in environment.',
            );
          }
          // 2. Get coordinates from query parameters, default to Detroit
          final lat = request.url.queryParameters['lat'] ?? '42.331';
          final lon = request.url.queryParameters['lon'] ?? '-83.046';
          // 3. Construct the PirateWeather URL
          final url = Uri.parse(
            'https://api.pirateweather.net/forecast/$apiKey/$lat,$lon?exclude=minutely%2Chourly%2Calerts&version=2',
          );
          // 4. Fetch the data
          final response = await http.get(url);
          if (response.statusCode != 200) {
            return Response(
              response.statusCode,
              body: 'Failed to fetch Pirate Weather data.',
            );
          }
          // 5. Decode the JSON response
          final jsonMap = jsonDecode(response.body);
          // 6. Serialize into the PirateForecast object
          final pirateForecast = PirateForecast.fromJson(jsonMap);
          // 7. Return the serialized object as JSON string
          return Response(
            200,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(pirateForecast.toJson()),
          );
        } catch (e) {
          return Response(500, body: 'Internal Server Error: $e');
        }
      },
    );

    firebase.https.onRequest(
      name: 'getFullForecast',
      options: const HttpsOptions(
        cors: Cors(['*']),
        maxInstances: Instances(10),
      ),
      (request) async {
        try {
          final locationName = request.url.queryParameters['location'] ?? 'Detroit';
          final formattedLocation = locationName.replaceAll(' ', '+');

          // 1. Get geocoded location from wttr.in
          final wttrUrl = Uri.parse('https://wttr.in/$formattedLocation?format=j1');
          final wttrResponse = await http.get(wttrUrl);
          
          if (wttrResponse.statusCode != 200) {
             return Response(500, body: 'Failed to geocode via wttr.in');
          }
          final wttrJson = jsonDecode(wttrResponse.body);
          final simpleForecast = Forecast.fromJson(wttrJson);
          
          final lat = simpleForecast.nearestArea.latitude;
          final lon = simpleForecast.nearestArea.longitude;

          // 2. Fetch extended forecast from PirateWeather
          final apiKey = Platform.environment['WEATHER_API_KEY'];
          if (apiKey == null || apiKey.isEmpty) {
            return Response(500, body: 'Missing WEATHER_API_KEY in environment.');
          }

          final pirateUrl = Uri.parse(
            'https://api.pirateweather.net/forecast/$apiKey/$lat,$lon?exclude=minutely%2Chourly%2Calerts&version=2',
          );
          
          final pirateResponse = await http.get(pirateUrl);
          if (pirateResponse.statusCode != 200) {
            return Response(500, body: 'Failed to fetch extended Pirate Weather data.');
          }
          
          final pirateJson = jsonDecode(pirateResponse.body);
          final extendedForecast = PirateForecast.fromJson(pirateJson);

          // 3. Return the combined result
          final fullForecast = {
            'location': simpleForecast.nearestArea.toJson(),
            'currentCondition': simpleForecast.currentCondition.toJson(),
            'extendedForecast': extendedForecast.toJson(),
          };

          return Response(
            200,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(fullForecast),
          );
        } catch (e) {
          return Response(500, body: 'Internal Server Error: $e');
        }
      },
    );
  });
}
