part of bluetooth_notifications;

class ReadingBlock {

  Map<String,dynamic> displayMap;

  static const int NUM_OF_CHANNELS_LENGTH = 2;
  static const int READING_LENGTH = 3;

  List<int> readings = [];

  ReadingBlock.fromBytes(List<int> bytes) {
    int numOfChannels = Parser.getAsInt(bytes, NUM_OF_CHANNELS_LENGTH);
    for (int i = 0; i < numOfChannels; i++) {
      readings.add(Parser.getAsInt(bytes, READING_LENGTH));
    }

    displayMap = {
      'readings' : readings
    };
  }
}