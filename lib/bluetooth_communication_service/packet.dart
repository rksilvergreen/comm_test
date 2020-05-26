part of bluetooth_communication_service;

class Packet {
  static const int stp = 0x12;
  static const int etp = 0x34;

  static const int STP_LENGTH = 1;
  static const int TRANSACTION_ID_LENGTH = 1;
  static const int LEN_LENGTH = 2;
  static const int PAYLOAD_MAX_LENGTH = 450;
  static const int CRC_LENGTH = 2;
  static const int ETP_LENGTH = 1;
  static int get packetMaxLength => STP_LENGTH + TRANSACTION_ID_LENGTH + LEN_LENGTH + PAYLOAD_MAX_LENGTH + CRC_LENGTH + ETP_LENGTH;

  static const int STP_POS = 0;
  static const int TRANSACTION_ID_POS = 1;
  static const int CHUNK_START_POS = 2;
  static const int CHUNK_END_POS = 3;
  static const int LEN_START_POS = 4;
  static const int LEN_END_POS = 5;
  static const int CRC_START_POS = -3;
  static const int CRC_END_POS = -2;
  static const int ETP_POS = -1;

  List<int> transactionIDBytes;
  int transactionID;
  List<int> lenBytes;
  int len;
  List<int> payloadBytes;
  List<int> crcBytes;
  int crc;
  Uint8List bytes;

  Packet.withParser(this.transactionIDBytes, this.lenBytes, this.payloadBytes, this.crcBytes) {
    transactionID = Parser.bytesToInt(transactionIDBytes);
    len = Parser.bytesToInt(lenBytes);
    crc = Parser.bytesToInt(crcBytes);
    bytes = Uint8List.fromList([stp, ...transactionIDBytes, ...lenBytes, ...payloadBytes, ...crcBytes, etp]);
  }

  Packet.withSerializer(this.transactionID, this.len, this.payloadBytes) {
    transactionIDBytes = Serializer.intToBytes(transactionID, TRANSACTION_ID_LENGTH);
    lenBytes = Serializer.intToBytes(len, LEN_LENGTH);
//    int crc = Crc32Zlib().convert([...this.id, ...this.chunk, ...this.len, ...this.payload]);
    crc = 0;
    crcBytes = Serializer.intToBytes(crc, CRC_LENGTH);
    bytes = Uint8List.fromList([stp, ...transactionIDBytes, ...lenBytes, ...payloadBytes, ...crcBytes, etp]);
  }
}
