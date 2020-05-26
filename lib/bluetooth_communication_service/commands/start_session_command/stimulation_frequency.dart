part of bluetooth_commands;

enum StimulationFrequencyType {
  STIMULATION_FREQUENCY_TYPE_PARAMETER,
  STIMULATION_FREQUENCY_TYPE_NUMBER,
}

abstract class StimulationFrequency {
  List<int> getBytes();
}

enum AnalysisParameter {
  ANALYSIS_PARAMETER_DOMINANT_DELTA,
  ANALYSIS_PARAMETER_DOMINANT_THETA,
  ANALYSIS_PARAMETER_DOMINANT_ALPHA,
  ANALYSIS_PARAMETER_DOMINANT_SIGMA,
  ANALYSIS_PARAMETER_DOMINANT_BETA,
}

class AnalysisParameterFrequency extends StimulationFrequency {
  static const int PARAMETER_LENGTH = 1;

  AnalysisParameter parameter;

  AnalysisParameterFrequency({
    @required this.parameter,
  });

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.enumToBytes<AnalysisParameter>(parameter, AnalysisParameter.values, PARAMETER_LENGTH));
    return bytes;
  }
}

class NumberFrequency extends StimulationFrequency {
  static const int FREQUENCY_LENGTH = 2;

  int frequency;

  NumberFrequency({
    @required this.frequency,
  });

  @override
  List<int> getBytes() {
    List<int> bytes = [];
    bytes.addAll(Serializer.intToBytes(frequency, FREQUENCY_LENGTH));
    return bytes;
  }
}
