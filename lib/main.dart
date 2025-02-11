import 'package:flutter/material.dart';
import 'package:navegacao/Tela1.dart';
import 'package:navegacao/Tela2.dart';
import 'package:navegacao/Tela3.dart';
import 'package:navegacao/Tela4.dart';

// classe principal inicia o projeto
void main() => runApp(Aplicativo());

// classe pai que configura todo nosso app herda tipo Stateless

class Aplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu principal',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Menu(),
      routes: {
        '/tela1': (context) => Tela1(),
        '/tela2': (context) => Tela2(),
        '/tela3': (context) => Tela3(),
        '/tela4': (context) => Tela4(),
      },
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu principal', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            botao(
                texto: 'Tela 1',
                rota: '/tela1',
                icone: Icons.ac_unit,
                cor: Colors.red),
          ],
        ),
      ),
    );
  }
}

class botao extends StatelessWidget {
  // variaveis que configuram um botao novo personalizado
  final String texto;
  final String rota;
  final IconData icone;
  final Color cor;

  const botao(
      {Key? key,
      required this.texto,
      required this.rota,
      required this.icone,
      required this.cor}
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // espaçamento interno
      padding: EdgeInsets.all(8.0),
      child: Text(texto),
    );
  }
}
