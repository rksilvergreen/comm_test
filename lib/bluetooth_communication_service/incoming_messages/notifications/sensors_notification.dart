part of bluetooth_notifications;

class SensorsNotification extends Notification {
  static const int NUM_OF_BLOCKS_LENGTH = 2;

  List<ReadingBlock> readingBlocks = [];

  SensorsNotification.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    int numOfBlocks = Parser.getAsInt(bytes, NUM_OF_BLOCKS_LENGTH);
    for (int i = 0; i < numOfBlocks; i++) {
      readingBlocks.add(ReadingBlock.fromBytes(bytes));
    }

    displayMap = {'readingBlocks': readingBlocks.map((e) => e.displayMap).toList()};
  }
}
