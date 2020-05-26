part of bluetooth_commands;

class UpdateImageCommand extends Command {
  static const int SIZE_LENGTH = 4;
  static const int CRC_LENGTH = 4;

  int size;
  int crc;

  UpdateImageCommand({
    int transactionID = 0,
    @required this.size,
    @required this.crc,
  }) : super(transactionID, CommandType.UPDATE_IMAGE);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(size, SIZE_LENGTH));
    bytes.addAll(Serializer.intToBytes(crc, CRC_LENGTH));
    return bytes;
  }
}
