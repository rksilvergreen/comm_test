part of bluetooth_responses;

class VersionResponse extends Response {
  static const int VERSION_LENGTH = 4;

  int version;

  VersionResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    version = Parser.getAsInt(bytes, VERSION_LENGTH);

    displayMap = {'version': version};
  }
}
