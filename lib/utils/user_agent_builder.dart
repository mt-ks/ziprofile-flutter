import 'package:device_info_plus/device_info_plus.dart';
import 'dart:ui';

class UserAgentBuilder {
  static const version = "212.0.0.38.119";
  static const buildNumber = "329675731";
  // "Instagram 160.1.0.31.120 (\(getIdentifier()); iOS \(getOsVersion()); en_US; en-US; scale=2.00; \(getScreenSize()); 246979827) AppleWebKit/420+";

  Future<String> generate() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var iosInfo = await deviceInfo.iosInfo;
    var machine = iosInfo.utsname.machine;
    var osVersion = iosInfo.systemVersion?.replaceAll('.', '_');
    var screenSize =
        "${window.physicalSize.width.toInt().toString()}x${window.physicalSize.height.toInt().toString()}";
    return "Instagram $version ($machine; iOS $osVersion; tr_TR; tr-TR; scale=2.00; $screenSize; $buildNumber) AppleWebKit/420+";
  }
}
