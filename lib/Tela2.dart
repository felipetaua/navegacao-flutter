import 'package:flutter/material.dart';
import 'package:navegacao/Tela1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TabelaPai extends StatefulWidget {
  @override
  Tabela createState() => Tabela();
}

class Tabela extends State<TabelaPai> {
  final List<Pessoa> pessoas = [];

  @override
  void initState() {
    super.initState();
    buscarPessoas();
  }

  Future<void> buscarPessoas() async {
    final url = Uri.parse(
        "https://finan-4854e-default-rtdb.firebaseio.com/pessoa.json");
    final resposta = await http.get(url);
    final Map<String, dynamic>? dados = jsonDecode(resposta.body);
    print(dados);
  }

  Future<void> abrirWhats(String telefone) async {
    final url = Uri.parse("https://wa.me/$telefone");
    if (!await launchUrl(url)) {
      throw Exception('Não pode iniciar $url');
    }
  }

  //Tabela({required this.pessoas});

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
                trailing: IconButton(
                  onPressed: () => abrirWhats(pessoas[index].telefone),
                  icon: Icon(Icons.message),
                ),
              );
            }),
      ),
    );
  }
}
