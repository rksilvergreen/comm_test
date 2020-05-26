part of bluetooth_commands;

class StorageConfiguration {
  static const int SAVE_AVERAGING_LENGTH = 2;
  static const int SAVE_START_TRIGGER_TYPE_LENGTH = 1;
  static const int SAVE_STOP_TRIGGER_TYPE_LENGTH = 1;

  int saveAveraging;
  TriggerType saveStartTriggerType;
  Trigger saveStartTrigger;
  TriggerType saveStopTriggerType;
  Trigger saveStopTrigger;

  StorageConfiguration({
    @required this.saveAveraging,
    @required this.saveStartTriggerType,
    @required this.saveStartTrigger,
    @required this.saveStopTriggerType,
    @required this.saveStopTrigger,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(saveAveraging, SAVE_AVERAGING_LENGTH));
    bytes.addAll(Serializer.enumToBytes<TriggerType>(saveStartTriggerType, TriggerType.values, SAVE_START_TRIGGER_TYPE_LENGTH));
    bytes.addAll(saveStartTrigger.getBytes());
    bytes.addAll(Serializer.enumToBytes<TriggerType>(saveStopTriggerType, TriggerType.values, SAVE_STOP_TRIGGER_TYPE_LENGTH));
    bytes.addAll(saveStopTrigger.getBytes());
    return bytes;
  }
}
