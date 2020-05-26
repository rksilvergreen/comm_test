part of bluetooth_commands;

class GetUserSessionListCommand extends Command {

  UserName user;

  GetUserSessionListCommand({
    int transactionID = 0,
    @required this.user,
  }) : super(transactionID, CommandType.GET_USER_SESSION_LIST);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(user.getBytes());
    return bytes;
  }
}
