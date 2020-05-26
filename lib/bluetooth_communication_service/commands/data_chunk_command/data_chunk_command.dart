part of bluetooth_commands;

class DataChunkCommand extends Command {
  static const int CHUNK_ID_LENGTH = 2;
  static const int CHUNK_LEN_LENGTH = 2;

  int chunkID;
  int chunkLen;
  List<int> chunk;

  DataChunkCommand({
    int transactionID = 0,
    @required this.chunkID,
    @required this.chunk,
  }) : chunkLen = chunk.length,
        super(transactionID, CommandType.DATA_CHUNK);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(chunkID, CHUNK_ID_LENGTH));
    bytes.addAll(Serializer.intToBytes(chunkLen, CHUNK_LEN_LENGTH));
    bytes.addAll(chunk);
    return bytes;
  }
}
