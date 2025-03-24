import 'dart:convert';
import 'package:http/http.dart' as http;
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
  bool ocultado = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_pin,
              size: 100,
              color: Colors.deepPurpleAccent,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_rounded),
                prefixIconColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: senhaControle,
              obscureText: ocultado,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_rounded),
                prefixIconColor: Colors.grey,
                suffixIcon: IconButton(
                  icon:
                      Icon(ocultado ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      ocultado = !ocultado;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            estaCarregado
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: null, child: Text('Entrar')),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cadastro()));
              },
              child: Text('Não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}

class Cadastro extends StatefulWidget {
  @override
  CadastroEstado createState() => CadastroEstado();
}

class CadastroEstado extends State<Cadastro> {
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final senhaControle = TextEditingController();
  bool estaCarregando = false;
  bool ocultado = true;

  Future<void> cadastrar() async {
    setState(() {
      estaCarregando = true;
    });

    final nome = nomeControle.text;
    final email = emailControle.text;
    final senha = senhaControle.text;

    final url = Uri.parse(
        'https://finan-4854e-default-rtdb.firebaseio.com/usuario.json');
    final resposta = await http.post(
      url,
      body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
      headers: {'Content-Type': 'aplication/json'},
    );
    if (resposta.statusCode == 200) {
      Navigator.pop(context);
    } else {
      erro = "Erro ao cadastrar usuário";
    }
    setState(() {
      estaCarregando = false;
    });
  }

  String erro = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de novo usuário'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.perm_contact_calendar,
              size: 100,
              color: Colors.deepPurpleAccent,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nomeControle,
              decoration: InputDecoration(
                labelText: 'Seu nome',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_2_rounded),
                prefixIconColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailControle,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_rounded),
                prefixIconColor: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: senhaControle,
              obscureText: ocultado,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_rounded),
                prefixIconColor: Colors.grey,
                suffixIcon: IconButton(
                  icon:
                      Icon(ocultado ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      ocultado = !ocultado;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            estaCarregando
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: cadastrar,
                    child: Text('Cadastrar'),
                  ),
            erro.isNotEmpty
                ? Text(erro, style: TextStyle(color: Colors.red))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
