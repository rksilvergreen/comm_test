part of bluetooth_commands;

class SoftwareResetCommand extends Command {
  SoftwareResetCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.SOFTWARE_RESET);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
