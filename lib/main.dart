import 'package:flutter/material.dart';

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
    );
  }
}
