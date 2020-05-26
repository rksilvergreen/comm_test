part of bluetooth_communication_service;

class BluetoothCommunicationService {

  /// SEND

  static _createPackets(int transactionID, List<int> intList,) {
    if (intList.length > Packet.PAYLOAD_MAX_LENGTH) {
      List<int> subList = intList.sublist(0, Packet.PAYLOAD_MAX_LENGTH);
      return [Packet.withSerializer(transactionID, subList.length, subList), ..._createPackets(transactionID, intList.sublist(Packet.PAYLOAD_MAX_LENGTH))];
    } else {
      return [Packet.withSerializer(transactionID, intList.length, intList)];
    }
  }

  static List<Packet> _packCommand(Command command) {
    List<int> bytes = Serializer.enumToBytes<CommandType>(command.type, CommandType.values);
    bytes.addAll(command.getBytes());
    return _createPackets(command.transactionID, bytes);
  }

  static sendCommand(Command command, BLTConnection bltConnection) {
    List<Packet> packets = _packCommand(command);
    packets.forEach((packet) {
      bltConnection.write(packet.bytes);
    });
  }

  /// RECEIVE

  static Packet bytesToPacket(Uint8List _bytes) {
    List<int> bytes = List.from(_bytes);
    PacketParsingStage currStage = PacketParsingStage.STP;
    int currStageLength = Packet.STP_LENGTH;
    List<int> currStageBytes = [];

    List<int> transactionIDBytes;
    List<int> lenBytes;
    List<int> payloadBytes;
    List<int> crcBytes;
    Packet packet;

    bytes.forEach((byte) {
      currStageBytes.add(byte);
      if (currStageBytes.length == currStageLength) {
        switch(currStage) {
          case PacketParsingStage.STP:
            if(byte != Packet.stp){}
            currStageLength = Packet.TRANSACTION_ID_LENGTH;
            break;
          case PacketParsingStage.TRANSACTION_ID:
            transactionIDBytes = currStageBytes;
            currStageLength = Packet.LEN_LENGTH;
            break;
          case PacketParsingStage.LEN:
            lenBytes = currStageBytes;
            currStageLength = Parser.bytesToInt(lenBytes);
            break;
          case PacketParsingStage.PAYLOAD:
            payloadBytes = currStageBytes;
            currStageLength = Packet.CRC_LENGTH;
            break;
          case PacketParsingStage.CRC:
            crcBytes = currStageBytes;
            currStageLength = Packet.ETP_LENGTH;
            break;
          case PacketParsingStage.ETP:
            if(byte == Packet.etp){
              packet = Packet.withParser(transactionIDBytes, lenBytes, payloadBytes, crcBytes);
            }
            break;
          default:
            break;
        }

        currStageBytes = [];
        int currStageIndex = PacketParsingStage.values.indexOf(currStage);

        currStage = currStageIndex != PacketParsingStage.values.length - 1
            ? PacketParsingStage.values[currStageIndex + 1]
            : PacketParsingStage.values[0];
      }
    });
    return packet;
  }

  static IncomingMessage getIncomingMessage(Uint8List bytes) {
    Packet packet = bytesToPacket(bytes);
//    print('packet.payloadBytes: ${packet.payloadBytes}');
    return packet != null ? IncomingMessage.fromBytes(packet.payloadBytes) : null;
  }
}
