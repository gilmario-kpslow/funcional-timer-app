import 'package:flutter/material.dart';
import 'package:cristimer/components/listas/dashboard.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Funcional Timer"),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: "v1.0.0",
                  children: [
                    const Text("Falta Fazer"),
                    const ListTile(
                      dense: true,
                      title: Text("Colocar a acplicaçao como player de musica"),
                      subtitle: Text("Pesquisar"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text("Dar play pelo relogio"),
                      subtitle: Text("Pesquisar"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text("Fazer backup dos dados"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text("Fazer restore dos dados"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text("Falar a descrição das atividades"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text(
                          "Criar animação de contagem quando o botao play for pressionado"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text("Criar a opção sobre pra falar do APP"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text("Criar um site de ajuda"),
                      trailing: Icon(Icons.warning_amber_outlined),
                    ),
                  ]);
            },
            icon: Icon(Icons.info),
            tooltip: "Sobre",
          )
        ],
      ),
      body: const Dashboard(),
    );
  }
}
