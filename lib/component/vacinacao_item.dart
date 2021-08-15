import 'package:flutter/material.dart';
import 'package:web_api_vacinacao/http/webclient/vacinacao_webclient.dart';
import 'package:web_api_vacinacao/model/vacinacao.dart';
import 'package:web_api_vacinacao/view/cadastro_vacinacao.dart';
import 'package:web_api_vacinacao/view/lista_vacinacao.dart';

class VacinacaoItem extends StatefulWidget {
  Vacinacao _vacinacao;
  List<Vacinacao> _listaVacinacoes;
  int _index;
  VacinacaoItem(this._vacinacao, this._listaVacinacoes, this._index);
  @override
  _VacinacaoItemState createState() => _VacinacaoItemState();
}

class _VacinacaoItemState extends State<VacinacaoItem> {
  Vacinacao _ultimoRemovido;
  VacinacaoWebClient _vacinacaoWebClient = VacinacaoWebClient();
  _atualizarLista() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaVacinacao(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
        color: Colors.orange[800],
        child: ListTile(
          title: Text(
            widget._vacinacao.nomeDoVacinado,
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          subtitle: Column(
            children: <Widget>[
              Text(
                "CPF: " + widget._vacinacao.cpf.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              Text(
                "UF: " + widget._vacinacao.uf.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              Text(
                "Cidade: " + widget._vacinacao.cidade.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              Text(
                "Data de Aplicação 1ª Dose: " +
                    widget._vacinacao.dataDeAplicacao.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              Text(
                "Vacina: " + widget._vacinacao.vacina.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              Text(
                "Nome do Responsável de Aplicação: " +
                    widget._vacinacao.nomeDoResponsavelDeAplicacao.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              Text(
                "Data Segunda Dose: " +
                    widget._vacinacao.dataProvavelSegundaDose.toString(),
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastroVacinacao(
                  vacinacao: widget._listaVacinacoes[widget._index],
                ),
              ),
            );
          },
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          mostrarAlerta(context);
        });
      },
    );
  }

  mostrarAlerta(BuildContext context) {
    Widget botaoNao = TextButton(
      child: Text(
        "Não",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _atualizarLista();
      },
    );
    Widget botaoSim = TextButton(
      child: Text(
        "Sim",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        _ultimoRemovido = widget._listaVacinacoes[widget._index];
        widget._listaVacinacoes.removeAt(widget._index);
        _vacinacaoWebClient.excluir(_ultimoRemovido.id);
        _atualizarLista();
      },
    );

    AlertDialog alerta = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.orange[800],
      title: Text(
        "Aviso",
        style: TextStyle(color: Colors.black),
      ),
      content: Text(
        "Deseja apagar o registro?",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        botaoNao,
        botaoSim,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
