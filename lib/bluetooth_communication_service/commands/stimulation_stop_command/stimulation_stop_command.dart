part of bluetooth_commands;

class StimulationStopCommand extends Command {
  StimulationStopCommand({
    int transactionID = 0,
  }) : super(transactionID, CommandType.STIMULATION_STOP);

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    return bytes;
  }
}
