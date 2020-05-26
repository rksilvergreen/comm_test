part of bluetooth_responses;

class FileDataResponse extends Response {
  static const int FILE_SIZE_LENGTH = 4;

  int fileSize;

  FileDataResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    fileSize = Parser.getAsInt(bytes, FILE_SIZE_LENGTH);

    displayMap = {'fileSize': fileSize};
  }
}
