import 'package:flutter_test/flutter_test.dart';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'package:permissions_plugin/permissions_plugin_platform_interface.dart';
import 'package:permissions_plugin/permissions_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPermissionsPluginPlatform
    with MockPlatformInterfaceMixin
    implements PermissionsPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PermissionsPluginPlatform initialPlatform = PermissionsPluginPlatform.instance;

  test('$MethodChannelPermissionsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPermissionsPlugin>());
  });

  test('getPlatformVersion', () async {
    PermissionsPlugin permissionsPlugin = PermissionsPlugin();
    MockPermissionsPluginPlatform fakePlatform = MockPermissionsPluginPlatform();
    PermissionsPluginPlatform.instance = fakePlatform;

    expect(await permissionsPlugin.getPlatformVersion(), '42');
  });
}
