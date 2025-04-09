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
            ),
            TextField(
              controller: conteudoControle,
              decoration: InputDecoration(labelText: 'Conteúdo'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver postagens! "),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: null,
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
            //lista de post
            final posts = snapshot.data!;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(children: [
                      post['imageUrl'] == null
                          ? SizedBox()
                          : Image.network(post['imagem']),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post['titulo']),
                            SizedBox(
                              height: 8,
                            ),
                            Text(post['autor']),
                          ],
                        ),
                      ),
                    ]),
                  );
                });
          }),
    );
  }
}
