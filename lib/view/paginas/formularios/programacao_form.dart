import 'package:flutter/material.dart';
import 'package:cristimer/core/modelos/programacao.dart';

class ProgramacaoForm extends StatefulWidget {
  final Programacao? programa;
  const ProgramacaoForm(this.onSubmit, this.programa, {super.key});

  final void Function(Programacao p) onSubmit;

  @override
  State<ProgramacaoForm> createState() => _ProgramacaoForm();
}

class _ProgramacaoForm extends State<ProgramacaoForm> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  int id = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.programa?.nome ?? "";
    _descricaoController.text = widget.programa?.descricao ?? "";
    id = widget.programa?.id ?? 0;
  }

  String? _defaultValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;

    var entity = Programacao(null, nome, descricao, statusAtivo);

    if (id != 0) {
      entity.id = id;
    }
    widget.onSubmit(entity);
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Nome"),
            controller: _nomeController,
            validator: _defaultValidate,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Descrição"),
            controller: _descricaoController,
            minLines: 2,
            maxLines: 4,
            // validator: _defaultValidate,
          ),
        ],
      ),
    );

    return AlertDialog(
      scrollable: true,
      title: Container(
        alignment: Alignment.center,
        child: const Text(
          "Criar Rotina",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      content: form,
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => _submitForm(),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
