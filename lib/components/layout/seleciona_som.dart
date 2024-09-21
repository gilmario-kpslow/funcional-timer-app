import 'package:cristimer/core/util/musicas_resources.dart';
import 'package:cristimer/core/util/somutil.dart';
import 'package:flutter/material.dart';

class SelecionaSom extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const SelecionaSom(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.text,
      controller: controller,
      onTap: () {
        _mostraLista(context);
      },
    );
  }

  _mostraLista(context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            scrollable: true,
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"))
            ],
            title: Container(
              width: 350,
              alignment: Alignment.topCenter,
              child: const Text(
                "Selecione uma Música",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            content: Column(
              children: musicas.map((musica) {
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.text = musica.source;
                    },
                    icon: const Icon(Icons.check),
                  ),
                  title: Text(musica.nome),
                  trailing: IconButton(
                    onPressed: () {
                      SomUtil().play(musica.source);
                    },
                    icon: const Icon(Icons.queue_music_sharp),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
