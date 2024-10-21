import 'package:flutter/material.dart';
import 'package:cristimer/view/paginas/rotinas.dart';
import 'package:cristimer/view/paginas/configuracao.dart';

class DefaultDrawer extends StatelessWidget {
  final index = 0;
  final void Function(int index) tap;

  const DefaultDrawer(this.tap, {super.key, required int index});

  _tap(int index) {
    tap(index);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigoAccent),
            child: Text(
              "Funcional Timer",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            selected: index == 0,
            onTap: () {
              _tap(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Programas'),
            selected: index == 1,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Rotinas()),
              );
            },
          ),
          ListTile(
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Configuracao()),
              );
            },
          ),
        ],
      ),
    );
  }
}
