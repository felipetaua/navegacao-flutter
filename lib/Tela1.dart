import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// criando a classe Empresa - fabricar empresa
class Empresa {
  String id;
  String nome;
  String email;
  String cnpj;
  String telefone;
  String endereco;
  String cidade;
  String qtdFuncionarios;
  String vaga;

  Empresa(this.id, this.nome, this.email, this.cnpj, this.telefone,
      this.endereco, this.cidade, this.qtdFuncionarios, this.vaga);
}

// criando a tela de cadastro
class Cadastro extends StatefulWidget {
  final List<Empresa> Empresas;

  // cadastro vai receber uma lista de Empresas
  Cadastro({required this.Empresas});

  @override
  // ignore: library_private_types_in_public_api
  _CadastroState createState() => _CadastroState();
}

// classe que tem quantas alterações forem necessárias
class _CadastroState extends State<Cadastro> {
  // Controle dos inputs do formulário
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final cnpjControle = TextEditingController();
  final telefoneControle = TextEditingController();
  final enderecoControle = TextEditingController();
  final cidadeControle = TextEditingController();
  final qtdFuncControle = TextEditingController();
  final vagaControle = TextEditingController();

  // Criando método de cadastro
  Future<void> cadastrarEmpresa(Empresa Empresa) async {
    final url = Uri.parse(
        "https://finan-4854e-default-rtdb.firebaseio.com/empresa.json");
    final resposta = await http.post(url,
        body: jsonEncode({
          "nome": Empresa.nome,
          "email": Empresa.email,
          "telefone": Empresa.telefone,
          "endereco": Empresa.endereco,
          "cidade": Empresa.cidade
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Empresas'),
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
              controller: cnpjControle,
              decoration: InputDecoration(labelText: 'CNPJ'),
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
            TextField(
              controller: vagaControle,
              decoration: InputDecoration(labelText: 'Vagas'),
            ),
            TextField(
              controller: qtdFuncControle,
              decoration: InputDecoration(labelText: 'Quantidade Funcionários'),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                // setState atualiza a tela na hora
                setState(() {
                  // criando um novo objeto Empresa "Ex: Seu Arlindo"
                  Empresa EmpresaNova = Empresa(
                    "",
                    nomeControle.text,
                    emailControle.text,
                    telefoneControle.text,
                    cnpjControle.text,
                    enderecoControle.text,
                    cidadeControle.text,
                    qtdFuncControle.text,
                    vagaControle.text,
                  );
                  // widget.Empresas.add(EmpresaNova);
                  cadastrarEmpresa(EmpresaNova);
                  // limpando os campos
                  nomeControle.clear();
                  emailControle.clear();
                  telefoneControle.clear();
                  enderecoControle.clear();
                  cidadeControle.clear();
                  cnpjControle.clear();
                  qtdFuncControle.clear();
                  vagaControle.clear();
                });
              },
              // adicionando Empresa na lista "Ex: Seu Arlindo"
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                shadowColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
