import 'dart:async';

import 'package:cristimer/core/controllers/notification_controller.dart';
import 'package:cristimer/view/widgets/contador.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/widgets/contador_tempo.dart';
import 'package:cristimer/core/modelos/programacao.dart';
import 'package:cristimer/core/modelos/round.dart';
import 'package:cristimer/core/service/round_service.dart';
import 'package:cristimer/core/util/somutil.dart';

class ExecutarRound extends StatefulWidget {
  final Programacao programacao;
  const ExecutarRound(this.programacao, {super.key});

  @override
  State<ExecutarRound> createState() => _ExecutarRoundState();
}

class _ExecutarRoundState extends State<ExecutarRound> {
  final RoundService _roundService = RoundService();
  List<Round> _rounds = [];
  Round? _selecionado;
  int _index = 0;
  int _tempo = 0;
  bool _ativo = false;
  Timer? timer;
  SomUtil? _player;

  @override
  void initState() {
    super.initState();
    _roundService.getLista(widget.programacao.id).then((lista) {
      setState(() {
        _rounds = lista;
        _selecionado = lista[0];
        _tempo = _selecionado?.tempo ?? 0;
        _player = SomUtil();
      });
    });
  }

  _relogio(Timer timer) async {
    // print("$_ativo TIMER ${timer.tick}");
    if (!_ativo) {
      // timer = null;
      timer.cancel();
      return;
    }

    if (_tempo == (_selecionado?.tempo ?? 0)) {
      _player?.play(_selecionado?.somInicio);
    }

    if ((_tempo - 1) == (_selecionado?.delayTermino ?? 0)) {
      _player?.play(_selecionado?.somPreTermino);
    }

    if ((_tempo <= 1)) {
      _player?.play(_selecionado?.somTermino);
    }

    if (_tempo > 0) {
      setState(() {
        _tempo--;
      });
      return;
    }

    if (_index < _rounds.length - 1) {
      _avancar();
      return;
    }

    setState(() {
      timer.cancel();
      _ativo = false;
    });
  }

  _reposicionar(int next) {
    setState(() {
      _index = _index + next;
      _selecionado = _rounds[_index];
      _tempo = _selecionado?.tempo ?? 0;
    });
  }

  _contador(context) async {
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Contador(
              tempo: 3,
              call: () {
                Navigator.pop(context);
              });
        });
  }

  _iniciar(context) async {
    // NotificationController.createNewNotification();
    if (_ativo) {
      return;
    }

    await _contador(context);

    if (_tempo <= (_selecionado?.tempo ?? 0)) {
      _player?.play(_selecionado?.somInicio);
    }
    setState(() {
      _ativo = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), _relogio);
  }

  _voltar() {
    if (_index > 0) {
      _reposicionar(-1);
    }
  }

  _pausar() {
    setState(() {
      _ativo = false;
    });
  }

  _parar() {
    setState(() {
      _ativo = false;
      _tempo = _selecionado?.tempo ?? 0;
      _index = 0;
      _reposicionar(0);
    });
  }

  _avancar() {
    if (_index < _rounds.length - 1) {
      _reposicionar(1);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  _buttonPlay(context) {
    return !_ativo
        ? TextButton(
            onPressed: () {
              _iniciar(context);
            },
            child: const Icon(
              Icons.play_arrow,
              size: 40,
            ))
        : TextButton(
            onPressed: _pausar,
            child: const Icon(
              Icons.pause,
              size: 40,
            ));
  }

  @override
  Widget build(BuildContext context) {
    // const botoes = Padding(
    //   padding: EdgeInsets.only(bottom: 10.0),
    //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //     RoundButton(
    //         icon: Icons.published_with_changes_rounded, nome: "Reiniciar"),
    //     RoundButton(icon: Icons.star_outline, nome: "Favoritar"),
    //     RoundButton(icon: Icons.settings_suggest, nome: "Configurar"),
    //   ]),
    // );

    var round = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            style: const TextStyle(
                fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold),
            "${_selecionado?.nome}"),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            "${_selecionado?.descricao}",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ContadorTempo(tempo: _tempo),
        )
      ],
    );

    player(context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: _voltar,
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
              )),
          _buttonPlay(context),
          TextButton(
              onPressed: _parar,
              child: const Icon(
                Icons.stop,
                size: 40,
              )),
          IconButton(
              onPressed: _avancar,
              icon: const Icon(
                Icons.arrow_forward,
                size: 40,
              )),
        ],
      );
    }

    var lista = Flexible(
      child: _rounds.length == 0
          ? Text("data")
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _rounds.length,
              itemBuilder: (context, index) {
                var r = _rounds[index];
                return ListTile(
                  onTap: () {
                    _index = index;
                    _reposicionar(0);
                  },
                  selectedTileColor: Colors.amber,
                  selectedColor: Colors.amber,
                  selected: (_index + 1) == r.ordem,
                  dense: false,
                  title: Text(
                    r.nome,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // subtitle: Text(
                  //   r.descricao ?? "",
                  // ),
                  trailing: const Icon(Icons.play_arrow),
                  leading: Text(
                    "${index + 1}",
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.programacao.nome),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [round, lista],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        child: player(context),
      ),
      // persistentFooterButtons: [Text("data")],
    );
  }
}
