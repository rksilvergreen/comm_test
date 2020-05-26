part of bluetooth_responses;

enum ResponseResult {
  SUCCESS,
  UNSUPPORTED_COMMAND,
  INVALID_STATE,
  INVALID_PARAMETER,
  OTHER_ERROR
}

class ResultResponse extends Response {

  static const int RESULT_TYPE_LENGTH = 1;

  ResponseResult responseResult;

  ResultResponse.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    responseResult = Parser.getAsEnum<ResponseResult>(bytes, RESULT_TYPE_LENGTH, ResponseResult.values);

    displayMap = {
      'responseType': responseResult,
    };

  }

}