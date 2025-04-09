import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:navegacao/main.dart';

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

  Future<void> logar() async {
    // inicia animação de carregamento
    setState(() {
      estaCarregado = true;
      mensagemErro = '';
    });

    final url = Uri.parse(
        'https://finan-4854e-default-rtdb.firebaseio.com/usuario.json');
    final resposta = await http.get(url);
    // se tudo estiver certo
    if (resposta.statusCode == 200) {
      final Map<String, dynamic>? dados = jsonDecode(resposta.body);

      if (dados != null) {
        bool usuarioValido = false;
        String nomeUsuario = '';

        dados.forEach((key, valor) {
          if (valor['email'] == emailControle.text &&
              valor['senha'] == senhaControle.text) {
            usuarioValido = true;
            nomeUsuario = valor['nome'];
          }
        });
        // se o usuario for válido, ou seja, esta no banco, pode ter acesso.
        if (usuarioValido == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Aplicativo(nomeUsuario: nomeUsuario)));
        } else {
          setState(() {
            mensagemErro = "Email ou senha inválidos";
            estaCarregado = false;
          });
        }
      }
    } else {
      setState(() {
        mensagemErro = 'Erro de conexão';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
          child: AppBar(
            title: Text(
              'Finan',
              style: GoogleFonts.getFont('Aoboshi One'), 
            ),
            backgroundColor: Colors.deepPurpleAccent,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/icone.png',
              width: 250,
              height: 250,
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
                : ElevatedButton(onPressed: logar, child: Text('Entrar')),
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
            mensagemErro.isNotEmpty
                ? Text(
                    mensagemErro,
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox(),
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
        title: Text('Crie sua Conta'),
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
