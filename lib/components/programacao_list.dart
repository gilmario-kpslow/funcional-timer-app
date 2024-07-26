import 'package:despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transacoes, this.delete, {super.key});

  final List<Transacao> transacoes;
  final Function(String id) delete;

  @override
  Widget build(BuildContext context) {
    final vazio = LayoutBuilder(builder: (xtx, constraints) {
      return Column(children: [
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.20,
          child: Text(
            "Nenhuma transação",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.50,
          child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.fitHeight,
          ),
        ),
      ]);
    });

    final lista = ListView.builder(
        itemCount: transacoes.length,
        itemBuilder: (context, index) {
          final tr = transacoes[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 28,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text(
                      'R\$ ${tr.valor}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              title: Text(
                tr.titulo,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(tr.data),
              ),
              trailing: MediaQuery.of(context).size.width > 400
                  ? ElevatedButton(
                      child: Text(
                        "Excluir",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      onPressed: () {
                        delete(tr.id);
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        delete(tr.id);
                      },
                      color: Theme.of(context).colorScheme.error,
                    ),
            ),
          );
        });

    return SizedBox(child: transacoes.isEmpty ? vazio : lista);
  }
}
