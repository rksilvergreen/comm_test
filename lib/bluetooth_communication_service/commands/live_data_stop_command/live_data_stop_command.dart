part of bluetooth_commands;

class LiveDataStopCommand extends Command {
  LiveDataStopCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.LIVE_DATA_STOP);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
