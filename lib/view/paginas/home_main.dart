import 'package:cristimer/view/widgets/sobre.dart';
import 'package:flutter/material.dart';
import 'package:cristimer/view/widgets/dashboard.dart';

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
        // backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Funcional Timer",
          // style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAboutDialog(
                  context: context,
                  applicationVersion: "v1.0.0",
                  children: [const SobreWidget()]);
            },
            icon: const Icon(
              Icons.info,
            ),
            tooltip: "Sobre",
          )
        ],
      ),
      body: const Dashboard(),
    );
  }
}
