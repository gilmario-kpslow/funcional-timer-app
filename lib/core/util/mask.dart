void main(List<String> args) {
  var texto = "0000";

  print("HI");
  // var res = maskTime("6:46");
  // print(res);

  var numbers = RegExp(r'\D');

  print("B123456A".replaceAll(numbers, ""));
}

String maskTime(String entrada) {
  String mask = "00:00";
  var numbers = RegExp(r'\D');
  var input = entrada
      .replaceAll(numbers, "0")
      .replaceAll(numbers, "")
      .padLeft(mask.length - 1, '0');
  String maskForm = "";
  int j = 0;
  for (int i = 0; mask.length > i; i++) {
    if (j > entrada.length) {
      maskForm += mask[i];
      continue;
    }
    if (mask[i] == "0") {
      maskForm += input[j];
      j++;
    } else {
      maskForm += mask[i];
    }
  }

  return maskForm;
}
