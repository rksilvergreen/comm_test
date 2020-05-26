part of bluetooth_commands;

class UserName {
  static const int NAME_LEN_LENGTH = 2;

  int nameLen;
  String name;

  UserName({
    int transactionID = 0,
    @required this.name,
  }) : nameLen = name.length;

  Map<String,dynamic> displayMap;

  UserName.fromBytes(List<int> bytes) {
    nameLen = Parser.getAsInt(bytes, NAME_LEN_LENGTH);
    name = Parser.getAsString(bytes, nameLen);
    displayMap = {'name': name};
  }

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(nameLen, NAME_LEN_LENGTH));
    bytes.addAll(Serializer.stringToBytes(name));
    return bytes;
  }
}
