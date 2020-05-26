part of bluetooth_notifications;

class AnalysisResult {
  Map<String,dynamic> displayMap;

  static const int NUM_OF_PARAMETERS_LENGTH = 2;
  static const int PARAMETER_LENGTH = 4;

  List<int> parameters = [];

  AnalysisResult.fromBytes(List<int> bytes) {
    int numOfParameters = Parser.getAsInt(bytes, NUM_OF_PARAMETERS_LENGTH);
    for (int i = 0; i < numOfParameters; i++) {
      parameters.add(Parser.getAsInt(bytes, PARAMETER_LENGTH));
    }

    displayMap = {
      'parameters' : parameters
    };
  }
}
