part of bluetooth_commands;

class StopSessionCommand extends Command {
  StopSessionCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.STOP_SESSION);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
