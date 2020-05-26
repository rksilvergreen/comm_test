part of bluetooth_commands;

enum SessionFileType {
  METADATA,
  SENSOR,
  ANALYSIS,
  STIMULATION
}

class GetSessionFileCommand extends Command {
  static const int SESSION_ID_LENGTH = 4;
  static const int FILE_TYPE_LENGTH = 1;

  UserName user;
  int sessionID;
  SessionFileType fileType;

  GetSessionFileCommand({
    int transactionID = 0,
    @required this.user,
    @required this.sessionID,
    @required this.fileType,
  }) : super(transactionID, CommandType.GET_SESSION_FILE);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(user.getBytes());
    bytes.addAll(Serializer.intToBytes(sessionID, SESSION_ID_LENGTH));
    bytes.addAll(Serializer.enumToBytes(fileType, SessionFileType.values, FILE_TYPE_LENGTH));
    return bytes;
  }
}
