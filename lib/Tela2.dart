import 'package:flutter/material.dart';
import 'package:navegacao/Tela1.dart';

class Tabela extends StatelessWidget {
  final List<Pessoa> pessoas;

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
        child: Text("Lista aqui"),
      ),
    );
  }
}
