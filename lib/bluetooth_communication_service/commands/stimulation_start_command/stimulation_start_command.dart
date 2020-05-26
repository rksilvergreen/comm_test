part of bluetooth_commands;

class StimulationStartCommand extends Command {
  static const int DURATION_LENGTH = 4;

  Stimulation stimulation;
  Duration duration;

  StimulationStartCommand({
    int transactionID = 0,
    @required this.stimulation,
    @required this.duration,
  })  : super(transactionID, CommandType.STIMULATION_START);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(stimulation.getBytes());
    bytes.addAll(Serializer.intToBytes(duration.inSeconds, DURATION_LENGTH));
    return bytes;
  }
}
