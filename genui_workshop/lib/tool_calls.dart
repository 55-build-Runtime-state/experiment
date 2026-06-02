import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:genui_workshop/catalog/weather_input.dart';

final fetchWeatherGeocodeUrl = 'http://127.0.0.1:5001/callstest-f6c61/us-central1/get-simple-forecast';


final fetchWeatherGeocodeTool = FunctionDeclaration(
  'fetchWeather',
  'Retrieves the weather for the current date and returns geocoded location data',
  parameters: {
    'location': Schema.string(description: 'The location for which to retrieve the weather'),
    'date': Schema.string(description: 'The date for which to retrieve the weather, must be <=7 days in the future')
});
