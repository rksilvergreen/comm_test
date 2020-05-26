part of bluetooth_responses;

class SessionListResponse extends Response {
  static const int NUM_OF_SESSIONS_LENGTH = 2;
  static const int SESSION_LENGTH = 4;

  List<int> sessions;

  SessionListResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    int numOfSessions = Parser.getAsInt(bytes, NUM_OF_SESSIONS_LENGTH);
    for (int i = 0; i < numOfSessions; i++) {
      sessions.add(Parser.getAsInt(bytes, SESSION_LENGTH));
    }

    displayMap = {'sessions': sessions};
  }
}
