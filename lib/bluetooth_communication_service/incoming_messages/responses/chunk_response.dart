part of bluetooth_responses;

class ChunkResponse extends Response {
  static const int CHUNK_ID_LENGTH = 2;
  static const int LEN_LENGTH = 2;
  static const int DATA_LENGTH = 2;

  int chunkID;
  List<int> data;

  ChunkResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    chunkID = Parser.getAsInt(bytes, CHUNK_ID_LENGTH);
    int len = Parser.getAsInt(bytes, LEN_LENGTH);
    for (int i = 0; i < len; i++) {
      data.add(Parser.getAsInt(bytes, DATA_LENGTH));
    }

    displayMap = {
      'chunkID': chunkID,
      'data': data,
    };
  }
}
