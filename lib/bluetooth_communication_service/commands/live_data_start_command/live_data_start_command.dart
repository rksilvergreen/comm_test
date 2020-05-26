part of bluetooth_commands;

class LiveDataStartCommand extends Command {
  static const int NUMBER_OF_INPUT_CHANNELS_LENGTH = 2;

  LiveDataConfiguration config;
  int numberOfInputChannels;
  List<InputChannel> inputChannels;

  LiveDataStartCommand({
    int transactionID = 0,
    @required this.config,
    @required this.inputChannels,
  }) : numberOfInputChannels = inputChannels.length,
        super(transactionID, CommandType.LIVE_DATA_START);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(config.getBytes());
    bytes.addAll(Serializer.intToBytes(numberOfInputChannels, NUMBER_OF_INPUT_CHANNELS_LENGTH));
    bytes.addAll(inputChannels.expand((e) => e.getBytes()));
    return bytes;
  }
}
