import 'package:flutter/material.dart';

void main() {
  runApp(Preconfiguracao());
}

class Preconfiguracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  LoginEstado createState() => LoginEstado();
}

class LoginEstado extends State<Login> {
  final emailControle = TextEditingController();
  final senhaControle = TextEditingController();
  bool estaCarregado = false;
  String mensagemErro = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Icon(
              Icons.account_circle_sharp,
              size: 100,
              color: Colors.deepPurple,
            )
          ],
        ),
      ),
    );
  }
}
