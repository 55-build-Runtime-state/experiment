import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/gen/android.g.dart'),
          structure: OutputStructure.singleFile,
        ),
      ),
      androidSdkConfig: AndroidSdkConfig(addGradleDeps: true),
      sourcePath: [packageRoot.resolve('android/src/main/kotlin/com/example/android_launch_activity')],
      classes: [
        // provided by Android OS
        'android.os.Bundle',
        'android.content.Intent',
        'android.content.Context',
        // Needed so it can be referenced from Dart
        'com.example.android_launch_activity.SecondActivity'
      ],
    ),
  );
}
