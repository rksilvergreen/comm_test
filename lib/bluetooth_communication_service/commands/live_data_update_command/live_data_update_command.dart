part of bluetooth_commands;

class LiveDataUpdateCommand extends Command {

  LiveDataControl config;

  LiveDataUpdateCommand({
    int transactionID = 0,
    @required this.config,
  })
      : super(transactionID, CommandType.LIVE_DATA_UPDATE);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(config.getBytes());
    return bytes;
  }
}
