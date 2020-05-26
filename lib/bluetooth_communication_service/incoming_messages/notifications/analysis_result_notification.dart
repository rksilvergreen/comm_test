part of bluetooth_notifications;

class AnalysisResultNotification extends Notification {
  AnalysisResult analysisResult;

  AnalysisResultNotification.fromBytes(List<int> bytes) {
    type = Parser.getAsEnum<IncomingMessageType>(bytes, 1, IncomingMessageType.values);
    analysisResult = AnalysisResult.fromBytes(bytes);

    displayMap = {'analysisResult': analysisResult.displayMap};
  }
}
