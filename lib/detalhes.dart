import 'package:flutter/material.dart';
import 'Tela1.dart';

class Detalhes extends StatelessWidget {
  final Pessoa pessoa;

  //passando o parâmetro da pessoa expecifica
  Detalhes({required this.pessoa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do contato"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
