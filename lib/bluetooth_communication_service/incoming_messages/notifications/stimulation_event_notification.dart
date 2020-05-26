part of bluetooth_notifications;

enum StimulationEvent {
  /// errors
  COGNYX_LOW_BATTERY,
  COGNYX_SD_CARD_FILE_EXISTS,
  COGNYX_SD_CARD_FAILURE,
  COGNYX_SD_CARD_MOUNT_ERROR,
  COGNYX_SD_CARD_OPEN_FAILURE,

  /// session
  COGNYX_SESSION_STARTED,
  COGNYX_SESSION_ENDED,

  /// stimulation
  COGNYX_STIMULATION_STARTED,
  COGNYX_STIMULATION_ENDED,

  /// commands
  COGNYX_RECEIVED_COMMAND_GET_BATTERY_LEVEL,
  COGNYX_RECEIVED_COMMAND_SESSION_START,
  COGNYX_RECEIVED_COMMAND_SESSION_STOP,
  COGNYX_RECEIVED_COMMAND_STIMULATION_START,
  COGNYX_RECEIVED_COMMAND_STIMULATION_STOP,
}

class StimulationEventNotification extends Notification {
  static const int EVENT_LENGTH = 1;

  StimulationEvent event;

  StimulationEventNotification.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    event = Parser.getAsEnum<StimulationEvent>(bytes, EVENT_LENGTH, StimulationEvent.values);

    displayMap = {'event': event};
  }
}
