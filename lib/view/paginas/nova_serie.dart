import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/modelos/serie.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:cristimer/core/service/serie_service.dart';
import 'package:cristimer/core/util/mensagem_util.dart';
import 'package:cristimer/view/components/text_input.dart';
import 'package:cristimer/view/paginas/novo_exercicio.dart';
import 'package:flutter/material.dart';

class NovaSerie extends StatefulWidget {
  final Serie? serie;
  final int? rotinaID;
  const NovaSerie({required this.rotinaID, this.serie, super.key});

  @override
  State<NovaSerie> createState() => _NovaSerieState();
}

class _NovaSerieState extends State<NovaSerie> {
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final service = SerieService();
  List<Exercicio> lista = List.empty();

  final exericioService = ExercicioService();

  // Serie? _serie;?

  _init() {
    _getLista();
  }

  _getLista() async {
    var list = await exericioService.getLista(widget.serie?.id);

    setState(() {
      lista = list;
    });
  }

  _salvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final nome = _nomeController.text;
    final descricao = _descricaoController.text;

    var entity = Serie(widget.serie?.id, widget.rotinaID, nome, descricao, 1);

    var id = await service.salvar(entity);
    setState(() {
      widget.serie?.id = id;
    });
  }

  _addExercicio(Exercicio? exercicio) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NovoExercicio(
          serie: widget.serie,
          exercicio: exercicio,
        ),
      ),
    ).then((resp) {
      _init();
    });
  }

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.serie?.nome ?? "";
    _descricaoController.text = widget.serie?.descricao ?? "";

    // Listar exercicios
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Dados da Serie",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TextInput(label: "Nome", controller: _nomeController),
            TextInput(label: "Descrição", controller: _descricaoController),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "Exercícios da Serie",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            widget.serie?.id == null
                ? Text("Salve a serie incuilr os exercicios")
                : Center(
                    child: ElevatedButton(
                        onPressed: () => _addExercicio(null),
                        child: Text("Adicionar Exercício"))),
          ],
        ),
      ),
    );

    final listaExercicios = Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Exercício ${index + 1}"),
            subtitle: Text("Descrição do exercício ${index + 1}"),
          );
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Serie"),
      ),
      body: Column(
        children: [form, listaExercicios],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _salvar();
          notificar(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  notificar(context) {
    MensagemUtil.info(context, "Serie Salva", "Serie salva com sucesso!");
  }
}
