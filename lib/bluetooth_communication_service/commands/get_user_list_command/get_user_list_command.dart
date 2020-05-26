part of bluetooth_commands;

class GetUserListCommand extends Command {
  GetUserListCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.GET_USER_LIST);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
