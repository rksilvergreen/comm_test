part of bluetooth_responses;

class UserListResponse extends Response {
  static const int NUM_OF_USERS_LENGTH = 2;

  List<UserName> users;

  UserListResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    int numOfUsers = Parser.getAsInt(bytes, NUM_OF_USERS_LENGTH);
    for (int i = 0; i < numOfUsers; i++) {
      users.add(UserName.fromBytes(bytes));
    }

    displayMap = {'users': users.map((e) => e.displayMap).toList()};
  }
}
