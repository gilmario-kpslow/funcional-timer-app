import 'package:flutter/material.dart';

class ProgramacaoForm extends StatefulWidget {
  const ProgramacaoForm(this.onSubmit, {super.key});

  final void Function(String, String) onSubmit;

  @override
  State<ProgramacaoForm> createState() => _ProgramacaoForm();
}

class _ProgramacaoForm extends State<ProgramacaoForm> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  _submitForm() {
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;

    if (nome.isEmpty || descricao.isEmpty) {
      return;
    }

    widget.onSubmit(nome, descricao);
  }

  @override
  Widget build(BuildContext context) {
    final form = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: const Text(
            "Criar Programação",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Nome"),
          controller: _nomeController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: "Descrição"),
          controller: _descricaoController,
        ),
        ElevatedButton(onPressed: _submitForm, child: const Text("Salvar"))
      ],
    );

    return SizedBox(child: form);
  }
}
