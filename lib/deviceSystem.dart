
import 'package:flutter_bluetooth/flutter_bluetooth.dart';

enum DeviceSystemStatus {CONNECTING, CONNECTED, DISCONNECTING, DISCONNECTED}

class DeviceSystem {
  String name;
  BLEDevice bleDevice;
  BLTDevice bltDevice;
  DeviceSystemStatus status;
  String statusText;

  DeviceSystem({this.name, this.bleDevice, this.bltDevice, this.status, this.statusText});
}