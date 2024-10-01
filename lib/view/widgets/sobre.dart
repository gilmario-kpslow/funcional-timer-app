import 'package:flutter/material.dart';

class SobreWidget extends StatelessWidget {
  const SobreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Falta Fazer"),
        ListTile(
          dense: true,
          title: Text("Colocar a acplicaçao como player de musica"),
          subtitle: Text("Pesquisar"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text("Dar play pelo relogio"),
          subtitle: Text("Pesquisar"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text("Fazer backup dos dados"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text("Fazer restore dos dados"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text("Falar a descrição das atividades"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text(
              "Criar animação de contagem quando o botao play for pressionado"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text("Criar a opção sobre pra falar do APP"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
        ListTile(
          dense: true,
          title: Text("Criar um site de ajuda"),
          trailing: Icon(Icons.warning_amber_outlined),
        ),
      ],
    );
  }
}
