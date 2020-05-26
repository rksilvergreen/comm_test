part of bluetooth_responses;

class BatteryLevelResponse extends Response {
  static const int LEVEL_LENGTH = 1;

  int level;

  BatteryLevelResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    level = Parser.getAsInt(bytes, LEVEL_LENGTH);

    displayMap = {'level': level};
  }
}
