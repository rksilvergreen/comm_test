part of bluetooth_responses;

class RetransmitResponse extends Response {
  static const int CHUNK_ID_LENGTH = 2;

  int chunkID;

  RetransmitResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    chunkID = Parser.getAsInt(bytes, CHUNK_ID_LENGTH);

    displayMap = {'chunkID': chunkID};
  }
}
