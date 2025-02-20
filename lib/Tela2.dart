import 'package:flutter/material.dart';
import 'package:navegacao/Tela1.dart';
import 'package:url_launcher/url_launcher.dart';


class Tabela extends StatelessWidget {
  final List<Pessoa> pessoas;

  void abrirWhats(String telefone) async {
    final url = "https://wa.me/$telefone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  Tabela({required this.pessoas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contatos"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: pessoas.length, // Quandidade de itens da lista
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(pessoas[index].nome),
                subtitle: Text(
                  "Email: " +
                      pessoas[index].email +
                      "\nTel: " +
                      pessoas[index].telefone +
                      "\nEndereço: " +
                      pessoas[index].endereco +
                      "\nCidade: " +
                      pessoas[index].cidade,
                ),
                trailing: Icon(Icons.message),
              );
            }),
      ),
    );
  }
}
