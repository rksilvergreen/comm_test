part of bluetooth_commands;

class TransmitNextChunkCommand extends Command {
  TransmitNextChunkCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.TRANSMIT_NEXT_CHUNK);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
