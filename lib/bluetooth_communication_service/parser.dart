part of bluetooth_communication_service;

class TestStreamer {
  static StreamController<Uint8List> controller = StreamController<Uint8List>();

  static fire({int chunkSize, Uint8List bytes}) {
    int len = bytes.length;

    for (var i = 0; i < len; i += chunkSize) {
      var end = (i + chunkSize < len) ? i + chunkSize : len;
      List<int> chunk = bytes.sublist(i, end);
      controller.add(Uint8List.fromList(chunk));
    }
  }
}

enum PacketParsingStage {
 STP,
 TRANSACTION_ID,
 LEN,
  PAYLOAD,
  CRC,
  ETP,
}

class Parser {

//  static const int STP = 0x12;
//  static const int ETP = 0x34;
//
//  static const int STP_POS = 0;
//
//  static const int TRANSACTION_ID_POS = 1;
//
//  static const int CHUNK_START_POS = 2;
//  static const int CHUNK_END_POS = 3;
//
//  static const int LEN_START_POS = 4;
//  static const int LEN_END_POS = 5;
//
//  static const int CRC_START_POS = -3;
//  static const int CRC_END_POS = -2;
//
//  static const int ETP_POS = -1;


  static void _completeBytes(List<int> bytes) {
    switch(bytes.length) {
      case 3:
        bytes.add(0); break;
      case 5:
        bytes.addAll([0,0,0]); break;
      case 6:
        bytes.addAll([0,0]); break;
      case 7:
        bytes.add(0); break;
      default:
        break;
    }
  }

  static bytesToInt(List<int> bytes) {
    _completeBytes(bytes);
    bytes = bytes.reversed.toList();
    ByteData byteData =  Uint8List.fromList(bytes.toList()).buffer.asByteData();
    int integer;
    switch (bytes.length) {
      case 1:
        integer = byteData.getUint8(0); break;
      case 2:
        integer = byteData.getUint16(0); break;
      case 4:
        integer = byteData.getUint32(0); break;
      case 8:
        integer = byteData.getUint64(0); break;
      default:
        break;
    }
    return integer;
  }

  static bytesToString(List<int> bytes) =>
     String.fromCharCodes(bytes);


//  static getSTP(Uint8List bytes) => bytes[STP_POS];
//
//  static isPacket(Uint8List bytes) => getSTP(bytes) == STP;
//
//  static getTransactionID(Uint8List bytes) => bytes[TRANSACTION_ID_POS];
//
//  static getChunkNum(Uint8List bytes) => bytesToInt(bytes.sublist(CHUNK_START_POS, CHUNK_END_POS + 1));
//
//  static getPayloadLength(Uint8List bytes) => bytesToInt(bytes.sublist(LEN_START_POS, LEN_END_POS + 1));
//
//  static getCRC(Uint8List bytes) =>
//      bytesToInt(bytes.sublist(bytes.length + CRC_START_POS, bytes.length + CRC_END_POS + 1));
//
//  static getETP(Uint8List bytes) => bytes[bytes.length + ETP_POS];
//
//
//  static getPayload(Uint8List bytes) => bytes.sublist(LEN_END_POS + 1, LEN_END_POS + 1 + getPayloadLength(bytes));


//  static printResponse(Map<String,dynamic> displayMap) {
//    print(displayMap);
//  }

  static List<int> _getRelevantBytes(List<int> bytes, int len) {
    List<int> relevantBytes = bytes.sublist(0, len);
    bytes.removeRange(0, len);
    return relevantBytes;
  }

  static int getAsInt(List<int> bytes, int len) {
    List<int> relevantBytes = _getRelevantBytes(bytes, len);
    return Parser.bytesToInt(relevantBytes);
  }

  static String getAsString(List<int> bytes, int len) {
    List<int> relevantBytes = _getRelevantBytes(bytes, len);
    return Parser.bytesToString(relevantBytes);
  }

  static T getAsEnum<T>(List<int> bytes, int len, List<T> enumValues) {
    List<int> relevantBytes = _getRelevantBytes(bytes, len);
    int i = Parser.bytesToInt(relevantBytes);
    return enumValues[i];
  }

//  static IncomingMessage unpackIncomingMessage(List<Packet> packets) {
//    List<int> contentBytes = [];
//    packets.forEach((packet) {
//      contentBytes.addAll(getPayload(packet.bytes));
//    });
//    return IncomingMessage.fromBytes(contentBytes);
//  }
}
