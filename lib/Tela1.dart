import 'package:flutter/material.dart';

// criando a classe Pessoa - fabricar pessoas
class Pessoa {
  String nome;
  String email;
  String telefone;
  String endereco;
  String cidade;

  Pessoa(this.nome, this.email, this.telefone, this.endereco, this.cidade);
}

// criando a tela de cadastro
class Cadastro extends StatefulWidget {
  final List<Pessoa> pessoas;

  // cadastro vai receber uma lista de pessoas
  Cadastro({required this.pessoas});

  @override
  // ignore: library_private_types_in_public_api
  _CadastroState createState() => _CadastroState();
}

// classe que tem quantas alterações forem necessárias
class _CadastroState extends State<Cadastro> {
  // Controle dos inputs do formulário
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final telefoneControle = TextEditingController();
  final enderecoControle = TextEditingController();
  final cidadeControle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Cadastro de Contato",
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: nomeControle,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: telefoneControle,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: enderecoControle,
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: cidadeControle,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
          ],
        ),
      ),
    );
  }
}
