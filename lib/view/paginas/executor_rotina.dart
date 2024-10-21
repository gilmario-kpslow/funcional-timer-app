import 'dart:async';

import 'package:cristimer/core/util/color_consts.dart';
import 'package:cristimer/core/util/tempoutil.dart';
import 'package:cristimer/view/paginas/rotina_main.dart';
import 'package:cristimer/view/widgets/contador.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/widgets/contador_tempo.dart';
import 'package:cristimer/core/modelos/rotina.dart';
import 'package:cristimer/core/modelos/exercicio.dart';
import 'package:cristimer/core/service/exercicio_service.dart';
import 'package:cristimer/core/util/somutil.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class ExecutorRotina extends StatefulWidget {
  final Rotina rotina;
  const ExecutorRotina(this.rotina, {super.key});

  @override
  State<ExecutorRotina> createState() => _ExecutorRotinaState();
}

class _ExecutorRotinaState extends State<ExecutorRotina> {
  final ExercicioService _exercicioService = ExercicioService();
  List<Exercicio> _exercicios = [];
  Exercicio? _selecionado;
  int _index = 0;
  int _tempo = 0;
  bool _ativo = false;
  Timer? timer;
  SomUtil? _player;
  GlobalKey listaKey = GlobalKey();
  GlobalKey statusKey = GlobalKey();
  final ScrollController _scroll = ScrollController();

  // Widget? _listaComponent;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _exercicioService.getLista(widget.rotina.id).then((lista) {
      setState(() {
        _exercicios = lista;
        if (_exercicios.isNotEmpty) {
          _selecionado = lista[0];
        }
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

    if (_index < _exercicios.length - 1) {
      _avancar();
      return;
    }

    setState(() {
      timer.cancel();
      _ativo = false;
    });
  }

  _reposicionar(int next, BuildContext context) {
    setState(() {
      _index = _index + next;
      _selecionado = _exercicios[_index];
      _tempo = _selecionado?.tempo ?? 0;
      if (_index == 0) {
        _scroll.jumpTo(0);
        return;
      }

      listaKey.currentContext;

      final box = listaKey.currentContext?.findRenderObject() as RenderBox;
      final status = statusKey.currentContext?.findRenderObject() as RenderBox;
      final item =
          listaKey.currentContext?.findAncestorRenderObjectOfType() as ListView;

      // final pos = item.itemExtent * _index;

      final a = MediaQuery.of(context).size;
      // print(itemKey.size.height);
      // print(box.size.height);

      // if (pos + box.localToGlobal(Offset.zero).dy > a.height) {
      //   print("Maioop");
      // }
      // print(pos);
      // _scroll.jumpTo(pos.dy);
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
      _reposicionar(-1, context);
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
      _reposicionar(0, context);
    });
  }

  _avancar() {
    if (_index < _exercicios.length - 1) {
      _reposicionar(1, context);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
    // _scroll.attach();

    var round = Container(
      key: statusKey,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              style: const TextStyle(
                  fontSize: 35, color: Colors.red, fontWeight: FontWeight.bold),
              _selecionado?.nome ?? "Nome do exercicio"),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              _selecionado?.descricao ?? "Descricao do exercicio",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ContadorTempo(tempo: _tempo),
          )
        ],
      ),
    );

    player(context) {
      return _exercicios.isEmpty
          ? null
          : Row(
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

    var listaComponent = Flexible(
      key: listaKey,
      child: _exercicios.isEmpty
          ? const ListTile(
              title: Text("Nenhum exercicio cadastrado"),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListView.builder(
                  controller: _scroll,
                  scrollDirection: Axis.vertical,
                  itemCount: _exercicios.length,
                  itemBuilder: (context, index) {
                    var r = _exercicios[index];
                    return ListTile(
                      key: Key("ITEM_${_index}"),
                      onTap: () {
                        _index = index;
                        _reposicionar(0, context);
                      },
                      selectedTileColor: itemSelecionadoColor,
                      // selectedColor: Colors.amber,
                      selected: (_index + 1) == r.ordem,
                      dense: false,
                      title: Text(
                        r.nome,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      // subtitle: Text(
                      //   r.descricao ?? "",
                      // ),
                      trailing: Text(
                        TempoUtil.format(r.tempo),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      leading: Text(
                        "${index + 1}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }),
            ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.rotina.nome,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RotinaMain(widget.rotina)))
                    .then((resp) {
                  _init();
                });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [round, listaComponent],
      ),
      bottomNavigationBar: BottomAppBar(
        color: itemSelecionadoColor,
        child: player(context),
      ),
    );
  }

  // Widget stickyBuilder(BuildContext context) {
  //   return AnimatedBuilder(
  //     animation: _scroll,
  //     builder: (context, child) {
  //       final keyContext = stickyKey.currentContext;
  //       if (keyContext != null) {
  //         // widget is visible
  //         final box = keyContext.findRenderObject() as RenderBox;
  //         final pos = box.localToGlobal(Offset.zero);
  //         return Positioned(
  //           top: pos.dy + box.size.height,
  //           left: 50.0,
  //           right: 50.0,
  //           height: box.size.height,
  //           child: Material(
  //             child: Container(
  //               alignment: Alignment.center,
  //               color: Colors.purple,
  //               child: const Text("^ Nah I think you're okay"),
  //             ),
  //           ),
  //         );
  //       }
  //       return Container();
  //     },
  //   );
  // }
}