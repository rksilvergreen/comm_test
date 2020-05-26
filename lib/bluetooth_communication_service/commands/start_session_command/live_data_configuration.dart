part of bluetooth_commands;

class LiveDataConfiguration {
  static const int SYSTEM_LOGS_ENABLED_LENGTH = 1;
  static const int STIMULATION_LOGS_ENABLED_LENGTH = 1;
  static const int ANALYZER_DATA_ENABLED_LENGTH = 1;
  static const int LIVE_SENSOR_DATA_ENABLED_LENGTH = 1;

  bool systemLogsEnabled;
  bool stimulationLogsEnabled;
  bool analyzerDataEnabled;
  bool liveSensorDataEnabled;
  LiveSensorConfiguration liveSensorConfiguration;

  LiveDataConfiguration({
    @required this.systemLogsEnabled,
    @required this.stimulationLogsEnabled,
    @required this.analyzerDataEnabled,
    @required this.liveSensorDataEnabled,
    @required this.liveSensorConfiguration,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.boolToBytes(systemLogsEnabled, SYSTEM_LOGS_ENABLED_LENGTH));
    bytes.addAll(Serializer.boolToBytes(stimulationLogsEnabled, STIMULATION_LOGS_ENABLED_LENGTH));
    bytes.addAll(Serializer.boolToBytes(analyzerDataEnabled, ANALYZER_DATA_ENABLED_LENGTH));
    bytes.addAll(Serializer.boolToBytes(liveSensorDataEnabled, LIVE_SENSOR_DATA_ENABLED_LENGTH));
    bytes.addAll(liveSensorConfiguration.getBytes());
    return bytes;
  }
}