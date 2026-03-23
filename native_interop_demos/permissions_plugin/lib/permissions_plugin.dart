import 'package:flutter/foundation.dart';

import 'permissions_plugin_platform_interface.dart';
import 'gen/android.g.dart';
import 'package:jni/jni.dart';

class PermissionsPlugin {
  Future<String?> getPlatformVersion() {
    return PermissionsPluginPlatform.instance.getPlatformVersion();
  }

  //
  bool checkPermission(JObject context, String permission) {
    // Returns a simple true or false if the permission has been granted
    var result = ContextCompat.checkSelfPermission(
      context,
      permission.toJString(),
    );
    return result == PackageManager.PERMISSION_GRANTED ? true : false;
  }

  int checkAndRequestPermission(
    JObject context,
    String permission,
    Function callback,
  ) {
    // Do I have permission?
    if (ContextCompat.checkSelfPermission(context, permission.toJString()) ==
        PackageManager.PERMISSION_GRANTED) {
      callback();
    } else if (ActivityCompat.shouldShowRequestPermissionRationale(
          Jni.androidActivity(PlatformDispatcher.instance.engineId!),
          permission.toJString(),
        ) ==
        true) {
      // Has the user denied the permission before?
      // Give a reason why I need the permission
      print("I should ask for permission");
      // TODO Flow to show UI to reshow perms dialog
      return -2;
    } else {
      // Ask for permission
      ActivityCompat.requestPermissions(
        Jni.androidActivity(PlatformDispatcher.instance.engineId!),
        JArray.of(JString.type, [permission.toJString()]),
        0,
      );
    }
    return 0;
  }
}
