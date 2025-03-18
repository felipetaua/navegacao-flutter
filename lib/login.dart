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
  bool estaCarregando = false;
  String mensagemErro = '';
  bool ocultado = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_sharp,
              size: 100,
              color: Colors.deepPurple,
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: senhaControle,
              obscureText: ocultado,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  prefixIconColor: Colors.grey,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ocultado = !ocultado;
                      });
                    },
                    icon: Icon(
                        ocultado ? Icons.visibility : Icons.visibility_off),
                  )),
            ),
            SizedBox(height: 16,),
            estaCarregando ? CircularProgressIndicator() : ElevatedButton(onPressed: () {
              
            },)
          ],
        ),
      ),
    );
  }
}
