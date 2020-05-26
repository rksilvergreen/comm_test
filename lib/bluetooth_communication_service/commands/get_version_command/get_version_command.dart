part of bluetooth_commands;

class GetVersionCommand extends Command {
  GetVersionCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.GET_VERSION);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
