part of bluetooth_commands;

class LiveDataControl {
  static const int SENSORS_LENGTH = 1;
  static const int STIMULATION_LENGTH = 1;
  static const int SYSTEM_LENGTH = 1;

  final bool sensors;
  final bool stimulation;
  final bool system;

  LiveDataControl({
    @required this.sensors,
    @required this.stimulation,
    @required this.system,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.boolToBytes(sensors, SENSORS_LENGTH));
    bytes.addAll(Serializer.boolToBytes(stimulation, STIMULATION_LENGTH));
    bytes.addAll(Serializer.boolToBytes(system, SYSTEM_LENGTH));
    return bytes;
  }
}
