import 'package:ttlock_premise_flutter/ttlock.dart';

class TTGateway {
  static const String COMMAND_START_SCAN_GATEWAY = "startScanGateway";
  static const String COMMAND_STOP_SCAN_GATEWAY = "stopScanGateway";
  static const String COMMAND_CONNECT_GATEWAY = "connectGateway";
  static const String COMMAND_DISCONNECT_GATEWAY = "disconnectGateway";
  static const String COMMAND_GET_SURROUND_WIFI = "getSurroundWifi";
  static const String COMMAND_INIT_GATEWAY = "initGateway";

  static void startScan(TTGatewayScanCallback scanCallback) {
    TTLock.invoke(COMMAND_START_SCAN_GATEWAY, null, scanCallback);
  }

  static void stopScan() {
    TTLock.invoke(COMMAND_STOP_SCAN_GATEWAY, null, null);
  }

  static void connect(String mac, TTGatewayConnectCallback callback) {
    Map map = Map();
    map["mac"] = mac;
    TTLock.invoke(COMMAND_CONNECT_GATEWAY, map, callback);
  }

  static void getNearbyWifi(TTGatewayGetAroundWifiCallback callback,
      TTGatewayFailedCallback failedCallback) {
    TTLock.invoke(COMMAND_GET_SURROUND_WIFI, null, callback,
        fail: failedCallback);
  }

  static void init(
    Map map,
    TTGatewayInitCallback callback,
    TTGatewayFailedCallback failedCallback,
  ) {
    TTLock.invoke(COMMAND_INIT_GATEWAY, map, callback, fail: failedCallback);
  }

  // static void disconnect(String mac, TTSuccessCallback callback) {
  //   Map map = Map();
  //   map["mac"] = mac;
  //   TTLock.invoke(COMMAND_DISCONNECT_GATEWAY, map, callback);
  // }
}