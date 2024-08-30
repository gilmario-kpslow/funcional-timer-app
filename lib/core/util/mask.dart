void main(List<String> args) {
  var texto = "0000";

  print("HI");
  var res = maskTime("646");
  print(res);
}

String maskTime(String entrada) {
  String mask = "00:00";
  var input = entrada.padLeft(mask.length - 1, '0');
  print("Input $input");
  String maskForm = "";
  int j = input.length - 1;
  print("${mask.length} $j");
  for (int i = 0; mask.length > i; i++) {
    print("$i $j ");
    if (j < 0) {
      print("passo01");
      print(mask[i]);
      maskForm += mask[i];
      continue;
    }

    if (mask[i] == "0") {
      print("passo2 $i $j");
      maskForm += input[j];
      j--;
    } else {
      print("passo 3 $i $j");
      maskForm += mask[i];
    }
    print("mascara $maskForm");
  }

  return maskForm;
}
