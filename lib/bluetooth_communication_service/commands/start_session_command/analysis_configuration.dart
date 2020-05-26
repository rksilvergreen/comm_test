part of bluetooth_commands;

class AnalysisConfiguration {
  static const int NUMBER_OF_ACTIVE_MODULES_LENGTH = 2;
  static const int ACTIVE_MODULES_LENGTH = 1;
  static const int ANALYSIS_INTERVAL_LENGTH = 4;
  static const int ANALYSIS_BUFFER_LENGTH = 4;

  int numberOfActiveModules;
  List<bool> activeModules;
  int analysisInterval;
  int analysisBuffer;

  AnalysisConfiguration({
    @required this.activeModules,
    @required this.analysisInterval,
    @required this.analysisBuffer,
  })  : numberOfActiveModules = activeModules.length;

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(numberOfActiveModules, NUMBER_OF_ACTIVE_MODULES_LENGTH));
    bytes.addAll(activeModules.expand((e) => Serializer.boolToBytes(e, ACTIVE_MODULES_LENGTH)).toList());
    bytes.addAll(Serializer.intToBytes(analysisInterval, ANALYSIS_INTERVAL_LENGTH));
    bytes.addAll(Serializer.intToBytes(analysisBuffer, ANALYSIS_BUFFER_LENGTH));
    return bytes;
  }
}
