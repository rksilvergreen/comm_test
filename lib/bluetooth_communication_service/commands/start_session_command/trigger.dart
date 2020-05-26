part of bluetooth_commands;

enum TriggerType {
  TRIGGER_TYPE_NONE,
  TRIGGER_TYPE_TIME,
  TRIGGER_TYPE_EVENT,
}

abstract class Trigger {
  List<int> getBytes();
}

enum AnalyzerEvent {
  ANALYSIS_EVENT_TEST,
}

class EventTrigger extends Trigger {
  static const int EVENT_LENGTH = 1;

  AnalyzerEvent event;

  EventTrigger({
    @required this.event,
  });

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.enumToBytes<AnalyzerEvent>(event, AnalyzerEvent.values, EVENT_LENGTH));
    return bytes;
  }
}

class TimeTrigger extends Trigger {
  static const int DELAY_LENGTH = 4;

  Duration delay;

  TimeTrigger({
    @required this.delay,
  });

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(delay.inSeconds, DELAY_LENGTH));
    return bytes;
  }
}