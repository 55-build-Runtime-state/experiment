# Android Toast Message Example

This example shows how to initiate an Android `Toast` message from Dart directly without using a plugin.

### How to run this example:

- Run `flutter run` to run the app.

- To regenerate bindings after changing Java code, run
  `dart run tool/jnigen.dart`. This requires at least one APK build to have
  been run before, so that  JNIgen can obtain classpaths of Android Gradle
  libraries. Therefore, run `flutter build apk` once before generating bindings
  for the first time, or after a `flutter clean`.

### General steps

These are general steps to integrate Java code into a Flutter project using
JNIgen.

- Create a JNIgen configuration script like `tool/jnigen.dart` in this
  example.
- Generate bindings by running that script with `dart run`.
- To prevent tree shaking of your custom classes (which are always accessed
  reflectively in JNI) use either the `@Keep` annotation 
  (`androidx.annotation.Keep`) for code written in the application itself, or
  a proguard-rules file.
- Build and run the app.
