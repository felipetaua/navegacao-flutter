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
            children: [
              Icon(
                Icons.person_2_rounded,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                pessoa.nome,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email: ${pessoa.email}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Telefone: ${pessoa.telefone}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "endereço: ${pessoa.endereco}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Cidade: ${pessoa.cidade}",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
