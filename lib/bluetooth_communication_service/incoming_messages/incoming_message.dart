part of bluetooth_incoming_messages;

enum IncomingMessageType {
  /// Responses
  RESULT,
  BATTERY_LEVEL,
  RETRANSMIT,
  USER_LIST,
  SESSION_LIST,
  FILE_DATA,
  CHUNK,
  VERSION,

  /// Notifications
  SENSORS,
  SYSTEM_EVENT,
  STIMULATION_EVENT,
  ANALYZER_RESULT,
}

class IncomingMessage {
  int transactionID;
  IncomingMessageType type;
  Map<String,dynamic> displayMap;

  IncomingMessage();

  factory IncomingMessage.fromBytes(List<int> bytes) {
    IncomingMessageType type = IncomingMessageType.values[bytes[0]];
    IncomingMessage incomingMessage;
    switch(type) {

    /// Responses
      case IncomingMessageType.RESULT:
        incomingMessage = ResultResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.BATTERY_LEVEL:
        incomingMessage = BatteryLevelResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.RETRANSMIT:
        incomingMessage = RetransmitResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.USER_LIST:
        incomingMessage = RetransmitResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.SESSION_LIST:
        incomingMessage = RetransmitResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.FILE_DATA:
        incomingMessage = RetransmitResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.CHUNK:
        incomingMessage = RetransmitResponse.fromBytes(bytes);
        break;
      case IncomingMessageType.VERSION:
        incomingMessage = RetransmitResponse.fromBytes(bytes);
        break;

    /// Notifications
      case IncomingMessageType.SENSORS:
        incomingMessage = SensorsNotification.fromBytes(bytes);
        break;
      case IncomingMessageType.SYSTEM_EVENT:
        incomingMessage = SystemEventNotification.fromBytes(bytes);
        break;
      case IncomingMessageType.STIMULATION_EVENT:
        incomingMessage = StimulationEventNotification.fromBytes(bytes);
        break;
      case IncomingMessageType.ANALYZER_RESULT:
        incomingMessage = AnalysisResultNotification.fromBytes(bytes);
        break;
      default:
        break;
    }
    return incomingMessage;
  }
}