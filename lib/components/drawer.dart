import 'package:flutter/material.dart';

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
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Funcional APP")),
          ListTile(
            title: const Text("Home"),
            selected: index == 0,
            onTap: () {
              _tap(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Programações'),
            selected: index == 1,
            onTap: () {
              // Update the state of the app
              _tap(1);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Configurações'),
            selected: index == 2,
            onTap: () {
              // Update the state of the app
              _tap(2);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
