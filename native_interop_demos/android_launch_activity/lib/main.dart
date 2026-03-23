import 'package:flutter/material.dart';
// uses added namespace because some bindings conflict with Dart classes
import 'package:android_launch_activity/gen/android.g.dart' as native;
import 'package:jni/jni.dart';

// Context.fromReference ensures we get Android Context object
// rather than the default `JObject`
var context = native.Context.fromReference(Jni.androidApplicationContext.reference);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // SECTION 2: START COPYING HERE
  void _launchAndroidActivity() {

    var intent = native.Intent.new$1(context, native.SecondActivity.type.jClass);
    intent.addFlags(native.Intent.FLAG_ACTIVITY_NEW_TASK);
    intent.putExtra$18('message'.toJString(), 'Hello from Flutter'.toJString());
    context.startActivity(intent);

    intent.release();

}
  // SECTION 2: END COPYING HERE

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(child: Text('Hello World!')),
        floatingActionButton: FloatingActionButton(
          // SECTION 3: Call `_launchAndroidActivity` somewhere.
          onPressed: _launchAndroidActivity,

          // SECTION 3: End
          tooltip: 'Launch Android activity',
          child: const Icon(Icons.launch),
        ),
      ),
    );
  }
}
