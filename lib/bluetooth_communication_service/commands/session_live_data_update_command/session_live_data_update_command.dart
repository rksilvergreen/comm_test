part of bluetooth_commands;

class SessionLiveDataUpdateCommand extends Command {
  static const int ANALYSIS_LENGTH = 1;
  static const int SENSORS_LENGTH = 1;
  static const int STIMULATION_LENGTH = 1;
  static const int SYSTEM_LENGTH = 1;

  bool analysis;
  bool sensors;
  bool stimulation;
  bool system;

  SessionLiveDataUpdateCommand({
    int transactionID = 0,
    @required this.analysis,
    @required this.sensors,
    @required this.stimulation,
    @required this.system,
  })  : super(transactionID, CommandType.SESSION_LIVE_DATA_UPDATE);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.boolToBytes(analysis, ANALYSIS_LENGTH));
    bytes.addAll(Serializer.boolToBytes(sensors, SENSORS_LENGTH));
    bytes.addAll(Serializer.boolToBytes(stimulation, STIMULATION_LENGTH));
    bytes.addAll(Serializer.boolToBytes(system, SYSTEM_LENGTH));
    return bytes;
  }
}
