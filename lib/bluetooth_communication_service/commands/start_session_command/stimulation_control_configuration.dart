part of bluetooth_commands;

class StimulationControlConfiguration {
  static const int MAX_CURRENT_LENGTH = 4;
  static const int CONTACT_THRESHOLD_LENGTH = 1;
  static const int CONTROL_CALC_INTERVAL_LENGTH = 4;

  int maxCurrent;
  int contactThreshold;
  int controlCalcInterval;

  StimulationControlConfiguration({
    @required this.maxCurrent,
    @required this.contactThreshold,
    @required this.controlCalcInterval,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(maxCurrent, MAX_CURRENT_LENGTH));
    bytes.addAll(Serializer.intToBytes(contactThreshold, CONTACT_THRESHOLD_LENGTH));
    bytes.addAll(Serializer.intToBytes(controlCalcInterval, CONTROL_CALC_INTERVAL_LENGTH));
    return bytes;
  }
}
