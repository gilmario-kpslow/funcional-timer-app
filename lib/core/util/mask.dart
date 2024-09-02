import 'dart:ffi';

void main(List<String> args) {
  var texto = "09:70";

  print("HI");
  var res = maskTime(texto);
  print(res);
}

maskTime(String entrada) {
  var numbers = RegExp(r'\D');
  var input = entrada.replaceAll(numbers, "").padLeft(5, '0');
  if (input.length > 4) {
    input = input.substring(1, 5);
  }
  var min = int.parse(input.substring(0, 2));
  var sec = int.parse(input.substring(2, 4));

  if (sec <= 59 && min <= 59) {
    return "${input.substring(0, 2)}:${input.substring(2, 4)}";
  }

  if (sec > 59) {
    sec = 59;
  }

  if (min > 59) {
    min = 59;
  }

  return "$min:$sec";
}

String _maskTime(String entrada) {
  String mask = "00:00";
  var numbers = RegExp(r'\D');
  var input = entrada.replaceAll(numbers, "").padLeft(mask.length - 1, '0');
  if (input.length > 4) {
    input = input.substring(1, 5);
  }
  print("Input =========> $input");
  String maskForm = "";
  int j = 0;
  for (int i = 0; mask.length > i; i++) {
    if (j > input.length) {
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

  var partes = maskForm.split(":");
  var sec = int.parse(partes[0]);
  var min = int.parse(partes[1]);

  return maskForm;
}
