import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funcional_timer_app/components/main/programacao_main.dart';
import 'package:path/path.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  _navegarProgramas(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const ProgramacaoMain()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          dense: true,
          title: const Text("Programas"),
          trailing: const Icon(Icons.play_arrow),
          onTap: () {
            _navegarProgramas(context);
          },
        ),
        const ListTile(
          dense: true,
          title: Text("Programas"),
          trailing: Icon(Icons.play_arrow),
        ),
      ],
    );
  }
}
