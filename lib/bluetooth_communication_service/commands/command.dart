part of bluetooth_commands;

enum CommandType {
  GET_BATTERY_LEVEL,
  START_SESSION ,
  SESSION_LIVE_DATA_UPDATE,
  STOP_SESSION ,
  STIMULATION_START,
  STIMULATION_STOP,
  LIVE_DATA_START,
  LIVE_DATA_UPDATE,
  LIVE_DATA_STOP,
  GET_USER_SESSION_LIST,
  DELETE_SESSION,
  GET_SESSION_FILE,
  GET_SYSTEM_LOG_FILE,
  UPDATE_IMAGE,
  ABORT,
  DATA_CHUNK,
  TRANSMIT_NEXT_CHUNK,
  RETRANSMIT_DATA_CHUNK,
  GET_USER_LIST,
  DELETE_USER,
  GET_VERSION,
  SOFTWARE_RESET
}

abstract class Command {
  int transactionID;
  CommandType type;

  Command(this.transactionID, this.type);

  List<int> getBytes() {}
}

