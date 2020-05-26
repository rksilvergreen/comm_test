part of bluetooth_commands;

class DeleteSessionCommand extends Command {
  static const int SESSION_ID_LENGTH = 4;

  UserName user;
  int sessionID;

  DeleteSessionCommand({
    @required this.user,
    @required this.sessionID,
    int transactionID = 0,
  }) : super(transactionID, CommandType.DELETE_SESSION);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(user.getBytes());
    bytes.addAll(Serializer.intToBytes(sessionID, SESSION_ID_LENGTH));
    return bytes;
  }
}
