class TempoUtil {
  static String format(int tempo) {
    var minuto = "${(tempo / 60).floor()}";
    var segundos = "${tempo % 60}";

    return "$minuto:${segundos.padLeft(2, "0")}";
  }

  static int parse(String tempo) {
    if (tempo == "" || !tempo.contains(":")) {
      return 0;
    }
    var minuto = int.parse(tempo.split(":")[0]);
    var segundos = int.parse(tempo.split(":")[1]);

    return ((minuto * 60) + segundos);
  }
}
