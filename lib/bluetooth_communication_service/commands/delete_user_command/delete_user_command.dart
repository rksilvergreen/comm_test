part of bluetooth_commands;

class DeleteUserCommand extends Command {

  UserName user;

  DeleteUserCommand({
    int transactionID = 0,
    @required this.user,
  }) : super(transactionID, CommandType.DELETE_USER);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(user.getBytes());
    return bytes;
  }
}
