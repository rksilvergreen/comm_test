part of bluetooth_commands;

class AbortCommand extends Command {
  AbortCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.ABORT);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
