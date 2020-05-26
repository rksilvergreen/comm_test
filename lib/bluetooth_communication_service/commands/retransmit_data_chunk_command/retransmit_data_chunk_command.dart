part of bluetooth_commands;

class RetransmitDataChunkCommand extends Command {
  RetransmitDataChunkCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.RETRANSMIT_DATA_CHUNK);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
