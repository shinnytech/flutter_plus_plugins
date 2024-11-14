import 'package:flutter_test/flutter_test.dart';
import 'package:network_info_plus_ohos/network_info_plus_ohos.dart';
import 'package:network_info_plus_platform_interface/network_info_plus_platform_interface.dart';

class MockNetworkInfoPlatform extends NetworkInfoPlatform {
  @override
  Future<String?> getWifiName() async => 'Test-SSID';

  @override
  Future<String?> getWifiBSSID() async => 'AA:BB:CC:DD:EE:FF';

  @override
  Future<String?> getWifiIP() async => '192.168.1.100';

  @override
  Future<String?> getWifiIPv6() async => 'fe80::1';

  @override
  Future<String?> getWifiSubmask() async => '255.255.255.0';

  @override
  Future<String?> getWifiGatewayIP() async => '192.168.1.1';

  @override
  Future<String?> getWifiBroadcast() async => '192.168.1.255';

  @override
  Future<LocationAuthorizationStatus> requestLocationServiceAuthorization(
      {bool requestAlwaysLocationUsage = false}) async {
    return LocationAuthorizationStatus.authorizedAlways;
  }

  @override
  Future<LocationAuthorizationStatus> getLocationServiceAuthorization() async {
    return LocationAuthorizationStatus.authorizedAlways;
  }
}

void main() {
  group('NetworkInfo', () {
    late NetworkInfo networkInfo;

    setUp(() {
      NetworkInfoPlatform.instance = MockNetworkInfoPlatform();
      networkInfo = NetworkInfo();
    });

    test('getWifiName should return a String', () async {
      final wifiName = await networkInfo.getWifiName();
      expect(wifiName, 'Test-SSID');
    });

    test('getWifiBSSID should return a String', () async {
      final wifiBSSID = await networkInfo.getWifiBSSID();
      expect(wifiBSSID, 'AA:BB:CC:DD:EE:FF');
    });

    test('getWifiIP should return a String', () async {
      final wifiIP = await networkInfo.getWifiIP();
      expect(wifiIP, '192.168.1.100');
    });

    test('getWifiIPv6 should return a String', () async {
      final wifiIPv6 = await networkInfo.getWifiIPv6();
      expect(wifiIPv6, 'fe80::1');
    });

    test('getWifiSubmask should return a String', () async {
      final wifiSubmask = await networkInfo.getWifiSubmask();
      expect(wifiSubmask, '255.255.255.0');
    });

    test('getWifiGatewayIP should return a String', () async {
      final wifiGatewayIP = await networkInfo.getWifiGatewayIP();
      expect(wifiGatewayIP, '192.168.1.1');
    });

    test('getWifiBroadcast should return a String', () async {
      final wifiBroadcast = await networkInfo.getWifiBroadcast();
      expect(wifiBroadcast, '192.168.1.255');
    });

    test('requestLocationServiceAuthorization should return LocationAuthorizationStatus', () async {
      final status = await networkInfo.requestLocationServiceAuthorization();
      expect(status, LocationAuthorizationStatus.authorizedAlways);
    });

    test('getLocationServiceAuthorization should return LocationAuthorizationStatus', () async {
      final status = await networkInfo.getLocationServiceAuthorization();
      expect(status, LocationAuthorizationStatus.authorizedAlways);
    });
  });
}