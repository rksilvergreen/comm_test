part of bluetooth_commands;

class Stimulation {
  static const int FREQUENCY_1_TYPE_LENGTH = 1;
  static const int FREQUENCY_2_TYPE_LENGTH = 1;
  static const int STRENGTH_INCREASE_INTERVAL_LENGTH = 4;
  static const int MAX_STRENGTH_PERCENTAGE_LENGTH = 1;
  static const int CONTROL_LENGTH = 1;

  StimulationFrequencyType frequency1Type;
  StimulationFrequency frequency1;
  StimulationFrequencyType frequency2Type;
  StimulationFrequency frequency2;
  int strengthIncreaseInterval;
  int maxStrengthPercentage;
  bool control;
  StimulationControlConfiguration controlConfiguration;

  Stimulation({
    @required this.frequency1Type,
    @required this.frequency1,
    @required this.frequency2Type,
    @required this.frequency2,
    @required this.strengthIncreaseInterval,
    @required this.maxStrengthPercentage,
    @required this.control,
    this.controlConfiguration,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.enumToBytes<StimulationFrequencyType>(frequency1Type, StimulationFrequencyType.values, FREQUENCY_1_TYPE_LENGTH));
    bytes.addAll(frequency1.getBytes());
    bytes.addAll(Serializer.enumToBytes<StimulationFrequencyType>(frequency2Type, StimulationFrequencyType.values, FREQUENCY_1_TYPE_LENGTH));
    bytes.addAll(frequency2.getBytes());
    bytes.addAll(Serializer.intToBytes(strengthIncreaseInterval, STRENGTH_INCREASE_INTERVAL_LENGTH));
    bytes.addAll(Serializer.intToBytes(maxStrengthPercentage, MAX_STRENGTH_PERCENTAGE_LENGTH));
    bytes.addAll(Serializer.boolToBytes(control, CONTROL_LENGTH));
    if (controlConfiguration != null)
      bytes.addAll(controlConfiguration.getBytes());
    return bytes;
  }
}