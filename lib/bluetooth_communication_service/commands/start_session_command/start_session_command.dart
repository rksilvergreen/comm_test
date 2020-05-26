part of bluetooth_commands;

enum SampleRate {
  SAMPLE_RATE_250,
  SAMPLE_RATE_500,
}

class StartSessionCommand extends Command {
  static const int USER_ID_LEN_LENGTH = 2;
  static const int TIMESTAMP_LENGTH = 4;
  static const int NUMBER_OF_INPUT_CHANNELS_LENGTH = 2;
  static const int SAMPLE_RATE_LENGTH = 1;
  static const int NUMBER_OF_SIMULATIONS_LENGTH = 2;
  static const int SESSION_DURATION_LENGTH = 4;
  static const int LIVE_DATA_ONLY_LENGTH = 1;
  static const int IS_SENSOR_DATA_STORED_LENGTH = 1;

  int userIDLen;
  String userID;
  int timestamp;
  int numberOfInputChannels;
  List<InputChannel> inputChannels;
  AnalysisConfiguration analysisConfiguration;
  SampleRate sampleRate;
  int numberOfStimulations;
  List<TriggeredStimulation> triggeredStimulations;
  Duration sessionDuration;
  bool liveDataOnly;
  LiveDataConfiguration liveDataConfiguration;
  bool isSensorDataStored;
  StorageConfiguration storageConfiguration;

  StartSessionCommand({
    int transactionID = 0,
    @required this.userID,
    @required this.inputChannels,
    @required this.analysisConfiguration,
    @required this.sampleRate,
    @required this.triggeredStimulations,
    @required this.sessionDuration,
    @required this.liveDataOnly,
    @required this.liveDataConfiguration,
    @required this.isSensorDataStored,
    this.storageConfiguration,
  })  : userIDLen = userID.length,
        timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        numberOfInputChannels = inputChannels.length,
        numberOfStimulations = triggeredStimulations.length,
        super(transactionID, CommandType.START_SESSION);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(userIDLen, USER_ID_LEN_LENGTH));
    bytes.addAll(Serializer.stringToBytes(userID));
    bytes.addAll(Serializer.intToBytes(timestamp, TIMESTAMP_LENGTH));
    bytes.addAll(Serializer.intToBytes(numberOfInputChannels, NUMBER_OF_INPUT_CHANNELS_LENGTH));
    bytes.addAll(inputChannels.expand((e) => e.getBytes()));
    bytes.addAll(analysisConfiguration.getBytes());
    bytes.addAll(Serializer.enumToBytes<SampleRate>(sampleRate, SampleRate.values, SAMPLE_RATE_LENGTH));
    bytes.addAll(Serializer.intToBytes(numberOfStimulations, NUMBER_OF_SIMULATIONS_LENGTH));
    bytes.addAll(triggeredStimulations.expand((e) => e.getBytes()));
    bytes.addAll(Serializer.intToBytes(sessionDuration.inSeconds, SESSION_DURATION_LENGTH));
    bytes.addAll(Serializer.boolToBytes(liveDataOnly, LIVE_DATA_ONLY_LENGTH));
    bytes.addAll(liveDataConfiguration.getBytes());
    bytes.addAll(Serializer.boolToBytes(isSensorDataStored, IS_SENSOR_DATA_STORED_LENGTH));
    if (storageConfiguration != null)
      bytes.addAll(storageConfiguration.getBytes());
    return bytes;
  }
}
