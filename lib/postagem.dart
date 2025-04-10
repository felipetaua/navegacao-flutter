import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Publicacao {
  String id;
  String titulo;
  String descricao;
  String conteudo;

  Publicacao(this.id, this.titulo, this.descricao, this.conteudo);
}

class CadastrarPublicacao extends StatefulWidget {
  final String username;

  CadastrarPublicacao({required this.username});

  @override
  CadastrarPublicacaoState createState() => CadastrarPublicacaoState();
}

class CadastrarPublicacaoState extends State<CadastrarPublicacao> {
  final tituloControle = TextEditingController();
  final descricaoControle = TextEditingController();
  final conteudoControle = TextEditingController();
  String mensagem = '';

  Future<void> cadastrarPublicacao(Publicacao publicacao) async {
    if (publicacao.titulo.isNotEmpty && publicacao.descricao.isNotEmpty) {
      final url = Uri.parse(
          "https://finan-4854e-default-rtdb.firebaseio.com/publicacao.json");
      final resposta = await http.post(url,
          body: jsonEncode({
            "titulo": publicacao.titulo,
            "descricao": publicacao.descricao,
            "conteudo": publicacao.conteudo,
            "autor": widget.username
          }));

      setState(() {
        if (resposta.statusCode == 200) {
          mensagem = 'Publicação cadastrada com sucesso!';
        } else {
          mensagem = 'Erro ao cadastrar publicação.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicação'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Faça sua Publicação",
              style: TextStyle(fontSize: 24),
            ),
            TextField(
              controller: tituloControle,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descricaoControle,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 4,
            ),
            TextField(
              controller: conteudoControle,
              decoration: InputDecoration(labelText: 'Imagem url'),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Publicacao publicacaoNova = Publicacao(
                  "",
                  tituloControle.text,
                  descricaoControle.text,
                  conteudoControle.text,
                );
                cadastrarPublicacao(publicacaoNova);
                tituloControle.clear();
                descricaoControle.clear();
                conteudoControle.clear();
              },
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                shadowColor: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            mensagem.isNotEmpty
                ? Text(
                    mensagem,
                    style: TextStyle(
                        color: mensagem.contains('sucesso')
                            ? Colors.green
                            : Colors.red),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class VerPublicacao extends StatelessWidget {
  Future<List<Map<String, dynamic>>> buscarPublicacoes() async {
    final url = Uri.parse(
        'https://finan-4854e-default-rtdb.firebaseio.com/publicacao.json');
    final resposta = await http.get(url);
    final Map<String, dynamic> dados = jsonDecode(resposta.body);
    //criando lista de objetos posts
    final List<Map<String, dynamic>> posts = [];
    dados.forEach((key, valor) {
      posts.add({
        'titulo': valor['titulo'],
        'descricao': valor['descricao'],
        'conteudo': valor['conteudo'],
        'autor': valor['autor']
      });
    });
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver Postagens"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: buscarPublicacoes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar postagens!"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Sem postagens para exibir"),
            );
          }

          // Lista de posts
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        post['conteudo'] == null || post['conteudo'].isEmpty
                            ? SizedBox()
                            : Image.network(
                                post['conteudo'],
                                height: 400,
                              ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 60),
                          child: Column(
                            children: [
                              Text(post['titulo'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 8,
                              ),
                              Text(post['descricao']),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_4_sharp,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  Text(
                                    "Autor: ${post['autor'] ?? 'Autor Desconhecido'}",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[700]),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
