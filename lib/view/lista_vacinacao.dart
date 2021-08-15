import 'package:flutter/material.dart';
import 'package:web_api_vacinacao/component/vacinacao_item.dart';
import 'package:web_api_vacinacao/http/web_client.dart';
import 'package:web_api_vacinacao/http/webclient/vacinacao_webclient.dart';
import 'package:web_api_vacinacao/model/vacinacao.dart';

import 'cadastro_vacinacao.dart';

class ListaVacinacao extends StatefulWidget {
  @override
  _ListaVacinacaoState createState() => _ListaVacinacaoState();
}

class _ListaVacinacaoState extends State<ListaVacinacao> {
  List<Vacinacao> _listaVacinacoes = [];
  VacinacaoWebClient _vacinacaoWebClient = VacinacaoWebClient();

  @override
  void initState() {
    super.initState();
    _vacinacaoWebClient.findAll().then((dados) {
      setState(() {
        _listaVacinacoes = dados;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de vacinacao"),
      ),
      body: FutureBuilder<List<Vacinacao>>(
        initialData: _listaVacinacoes,
        future: _vacinacaoWebClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Vacinacao> vacinacoes = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Vacinacao vacinacao = vacinacoes[index];
                  return VacinacaoItem(vacinacao, _listaVacinacoes, index);
                },
                itemCount: vacinacoes.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CadastroVacinacao(),
              ),
            );
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange[800],
      ),
    );
  }
}
