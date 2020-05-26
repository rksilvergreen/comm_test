part of bluetooth_commands;

class InputChannel {
  static const int CHANNEL_NUM_LENGTH = 1;
  static const int CHANNEL_NAME_LEN_LENGTH = 2;
  static const int GAIN_LENGTH = 1;
  static const int SRB2_LENGTH = 1;
  static const int MUX_LENGTH = 1;
  static const int LIVE_DATA_LENGTH = 1;

  int channelNum;
  int channelNameLen;
  String channelName;
  bool gain;
  bool srb2;
  int mux;
  bool liveData;

  InputChannel({
    @required this.channelNum,
    @required this.channelName,
    @required this.gain,
    @required this.srb2,
    @required this.mux,
    @required this.liveData,
  }) : channelNameLen = channelName.length;

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(channelNum, CHANNEL_NUM_LENGTH));
    bytes.addAll(Serializer.intToBytes(channelNameLen, CHANNEL_NAME_LEN_LENGTH));
    bytes.addAll(Serializer.stringToBytes(channelName));
    bytes.addAll(Serializer.boolToBytes(gain, GAIN_LENGTH));
    bytes.addAll(Serializer.boolToBytes(srb2, SRB2_LENGTH));
    bytes.addAll(Serializer.intToBytes(mux, MUX_LENGTH));
    bytes.addAll(Serializer.boolToBytes(liveData, LIVE_DATA_LENGTH));
    return bytes;
  }
}
