part of bluetooth_commands;

class GetBatteryCommand extends Command {
  GetBatteryCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.GET_BATTERY_LEVEL);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
