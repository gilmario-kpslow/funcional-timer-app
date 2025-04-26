import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/modelos/serie.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:cristimer/core/util/mask.dart';
import 'package:cristimer/core/util/tempoutil.dart';
import 'package:cristimer/view/components/seleciona_som.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NovoExercicio extends StatefulWidget {
  final Exercicio? exercicio;
  final Serie? serie;
  final bool pausa;
  const NovoExercicio(
      {required this.serie, this.exercicio, this.pausa = false, super.key});

  @override
  State<NovoExercicio> createState() => _NovoExercicioState();
}

class _NovoExercicioState extends State<NovoExercicio> {
  final _nomeController = TextEditingController();
  final _tempoController = TextEditingController();
  final _delayController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _somInicioController = TextEditingController();
  final _somPreTerminoController = TextEditingController();
  final _somTerminoController = TextEditingController();

  final service = ExercicioService();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    if (widget.exercicio != null) {
      _nomeController.text = widget.exercicio?.nome ?? "";
      _tempoController.text = TempoUtil.format(widget.exercicio?.tempo ?? 0);
      _delayController.text =
          TempoUtil.format(widget.exercicio?.delayTermino ?? 0);
      _descricaoController.text = widget.exercicio?.descricao ?? "";
      _somInicioController.text = widget.exercicio?.somInicio ?? "";
      _somPreTerminoController.text = widget.exercicio?.somPreTermino ?? "";
      _somTerminoController.text = widget.exercicio?.somTermino ?? "";

      // id = widget.exercicio?.id ?? 0;
    }
  }

  String? _defaultValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  _submitForm() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final form = Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
              validator: _defaultValidate,
            ),
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: "Descrição"),
              validator: _defaultValidate,
              maxLines: 2,
              maxLength: 40,
            ),
            TextFormField(
              controller: _tempoController,
              decoration: const InputDecoration(labelText: "Tempo"),
              keyboardType: TextInputType.number,
              validator: _defaultValidate,
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) {
                    return TextEditingValue(
                      text: maskTime(newValue.text),
                    );
                  },
                )
              ],
            ),
            TextFormField(
              controller: _delayController,
              decoration: const InputDecoration(labelText: "Delay termino (s)"),
              keyboardType: TextInputType.number,
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) {
                    return TextEditingValue(
                      text: maskTime(newValue.text),
                    );
                  },
                )
              ],
            ),
            SelecionaSom(
              label: "Som inicio",
              controller: _somInicioController,
            ),
            SelecionaSom(
              label: "Som pre termino",
              controller: _somPreTerminoController,
            ),
            SelecionaSom(
              label: "Som termino",
              controller: _somTerminoController,
            ),
          ],
        ),
      ),
    );

    final formBasico = Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _tempoController,
              decoration: const InputDecoration(labelText: "Tempo"),
              keyboardType: TextInputType.number,
              validator: _defaultValidate,
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) {
                    return TextEditingValue(
                      text: maskTime(newValue.text),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pausa ? "Criar Pausa" : "Criar Exercicio",
        ),
      ),
      body: form,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _salvar();
          // notificar(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
