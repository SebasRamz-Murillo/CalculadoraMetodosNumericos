List<String> dicVariables = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

Map<String, String> dicReglasYp = {
  "X^2": "_x^2 + _x + _",
  "X": "_x + _",
  "e^X": "_e^X",
  "cosX": "_cosX + _sinX",
  "sinX": "_cosX + _sinX",
};

Map<String, Function(String, String)> dicReglasDerivadas = {
  "X^2": (String coef, String x) => "${coef}2*$x",
  "X": (String coef, String _) => coef,
  "e^X": (String coef, String x) => "${coef}e^$x",
  "cos": (String coef, String x) => "-${coef}sin($x)*$x",
  "sin": (String coef, String x) => "${coef}cos($x)*$x",
};
