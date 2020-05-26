part of bluetooth_communication_service;

class Serializer {
  static List<int> intToBytes(int int, int numOfBytes) =>
      Uint8List.view(Uint32List.fromList([int]).buffer, 0, numOfBytes).toList();

  static List<int> stringToBytes(String str) =>
      str.codeUnits;

  static List<int> boolToBytes(bool boolean, [int numOfBytes = 1]) =>
      intToBytes(boolean ? 1 : 0, numOfBytes);

  static List<int> enumToBytes<T>(T enumValue, List<T> enumValues, [int numOfBytes = 1]) =>
      intToBytes(enumValues.indexOf(enumValue), numOfBytes);



}