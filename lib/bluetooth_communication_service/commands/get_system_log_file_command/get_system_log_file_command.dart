part of bluetooth_commands;

class GetSystemLogFileCommand extends Command {

  GetSystemLogFileCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.GET_SYSTEM_LOG_FILE);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
