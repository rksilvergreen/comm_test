part of bluetooth_commands;

class LiveSensorConfiguration {
  static const int SENSOR_DATA_AVERAGING_NUM_LENGTH = 2;
  static const int SENSOR_DATA_BLOCK_SIZE_LENGTH = 2;

  int sensorsDataAveragingNum;
  int sensorsDataBlockSize;

  LiveSensorConfiguration({
    @required this.sensorsDataAveragingNum,
    @required this.sensorsDataBlockSize,
  });

  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(sensorsDataAveragingNum, SENSOR_DATA_AVERAGING_NUM_LENGTH));
    bytes.addAll(Serializer.intToBytes(sensorsDataBlockSize, SENSOR_DATA_BLOCK_SIZE_LENGTH));
    return bytes;
  }
}
