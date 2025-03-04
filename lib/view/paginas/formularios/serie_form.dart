import 'package:cristimer/core/modelos/serie.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/core/modelos/rotina.dart';

class SerieForm extends StatefulWidget {
  final Serie? serie;
  final int? rotinaID;
  const SerieForm(this.onSubmit, this.serie, this.rotinaID, {super.key});

  final void Function(Serie p) onSubmit;

  @override
  State<SerieForm> createState() => _SerieForm();
}

class _SerieForm extends State<SerieForm> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  int id = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.serie?.nome ?? "";
    _descricaoController.text = widget.serie?.descricao ?? "";
    id = widget.serie?.id ?? 0;
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

    var entity = Serie(null, widget.rotinaID, nome, descricao, 1);

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
