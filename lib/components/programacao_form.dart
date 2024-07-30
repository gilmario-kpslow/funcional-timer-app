import 'package:flutter/material.dart';
import 'package:funcional_timer_app/components/adaptative_input.dart';

class ProgramacaoForm extends StatefulWidget {
  const ProgramacaoForm(this.onSubmit, {super.key});

  final void Function(String, int) onSubmit;

  @override
  State<ProgramacaoForm> createState() => _ProgramacaoForm();
}

class _ProgramacaoForm extends State<ProgramacaoForm> {
  final _nomeController = TextEditingController();
  final _tempoController = TextEditingController();

  _submitForm() {
    final title = _nomeController.text;
    final value = int.tryParse(_tempoController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    final form = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              "Criar novo Round",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text("Nome"),
          TextFormField(),
          AdaptativeInputText(label: "", controller: _nomeController),
          Text("Tempo"),
          TextFormField(),
          Text("som"),
          Checkbox(
            value: false,
            onChanged: (a) {},
          )
        ],
      ),
    );

    return SizedBox(child: form);
  }
}
