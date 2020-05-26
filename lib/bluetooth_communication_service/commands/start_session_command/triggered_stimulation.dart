part of bluetooth_commands;

class TriggeredStimulation {
  static const int START_TRIGGER_TYPE_LENGTH = 1;
  static const int STOP_TRIGGER_TYPE_LENGTH = 1;
  static const int MIN_START_TIME_LENGTH = 4;
  static const int MAX_START_TIME_LENGTH = 4;

  TriggerType startTriggerType;
  Trigger startTrigger;
  TriggerType stopTriggerType;
  Trigger stopTrigger;
  Duration minStartTime;
  Duration maxStartTime;
  Stimulation stimulation;

  TriggeredStimulation({
    @required this.startTriggerType,
    @required this.startTrigger,
    @required this.stopTriggerType,
    @required this.stopTrigger,
    @required this.minStartTime,
    @required this.maxStartTime,
    @required this.stimulation,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.enumToBytes<TriggerType>(startTriggerType, TriggerType.values, START_TRIGGER_TYPE_LENGTH));
    bytes.addAll(startTrigger.getBytes());
    bytes.addAll(Serializer.enumToBytes<TriggerType>(stopTriggerType, TriggerType.values, STOP_TRIGGER_TYPE_LENGTH));
    bytes.addAll(stopTrigger.getBytes());
    bytes.addAll(Serializer.intToBytes(minStartTime.inSeconds, MIN_START_TIME_LENGTH));
    bytes.addAll(Serializer.intToBytes(maxStartTime.inSeconds, MAX_START_TIME_LENGTH));
    bytes.addAll(stimulation.getBytes());
    return bytes;
  }
}
