import 'package:flutter/material.dart';
import 'package:web_api_vacinacao/component/cria_dropdown.dart';
import 'package:web_api_vacinacao/component/cria_textfield.dart';
import 'package:web_api_vacinacao/http/webclient/vacinacao_webclient.dart';
import 'package:web_api_vacinacao/model/vacinacao.dart';
import 'package:web_api_vacinacao/view/lista_vacinacao.dart';

class CadastroVacinacao extends StatefulWidget {
  final Vacinacao vacinacao;
  CadastroVacinacao({this.vacinacao});

  @override
  _CadastroVacinacaoState createState() => _CadastroVacinacaoState();
}

class _CadastroVacinacaoState extends State<CadastroVacinacao> {
  int _id;
  TextEditingController _nomeDoVacinadoController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _ufController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _dataDeAplicacaoController = TextEditingController();
  TextEditingController _vacinaController = TextEditingController();
  TextEditingController _nomeDoResponsavelDeAplicacaoController =
      TextEditingController();
  TextEditingController _dataProvavelSegundaDoseController =
      TextEditingController();
  VacinacaoWebClient _vacinacaoWebClient = VacinacaoWebClient();
  var _uf = [
    "ACRE",
    "ALAGOAS",
    "AMAPA",
    "AMAZONAS",
    "BAHIA",
    "CEARA",
    "DISTRITO_FEDERAL",
    "ESPIRITO_SANTO",
    "GOIAS",
    "MARANHAO",
    "MATO_GROSSO",
    "MATO_GROSSO_DO_SUL",
    "MINAS_GERAIS",
    "PARA",
    "PARAIBA",
    "PARANA",
    "PERNAMBUCO",
    "PIAUI",
    "RIO_DE_JANEIRO",
    "RIO_GRANDE_DO_NORTE",
    "RIO_GRANDE_DO_SUL",
    "RONDONIA",
    "RORAIMA",
    "SANTA_CATARINA",
    "SAO_PAULO",
    "SERGIPE",
    "TOCANTINS"
  ];
  var _ufSelecionada = "ACRE";
  var _vacina = ["ATRAZENECA", "CORONAVAC", "PFIZER"];
  var _vacinaSelecionada = "ATRAZENECA";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _alterarUf(String novaUfSelecionada) {
    _dropDownUfSelected(novaUfSelecionada);
    setState(() {
      this._ufSelecionada = novaUfSelecionada;
      _ufController.text = this._ufSelecionada;
    });
  }

  _dropDownUfSelected(String novaUf) {
    setState(() {
      this._ufSelecionada = novaUf;
    });
  }

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _alterarVacina(String novaVacinaSelecionada) {
    _dropDownVacinaSelected(novaVacinaSelecionada);
    setState(() {
      this._vacinaSelecionada = novaVacinaSelecionada;
      _vacinaController.text = this._vacinaSelecionada;
    });
  }

  _dropDownVacinaSelected(String novaVacina) {
    setState(() {
      this._vacinaSelecionada = novaVacina;
    });
  }

  _salvar(BuildContext context) {
    Vacinacao vacinacao = Vacinacao(
        _nomeDoVacinadoController.text,
        int.parse(_cpfController.text),
        _ufSelecionada,
        _cidadeController.text,
        _dataDeAplicacaoController.text,
        _vacinaSelecionada,
        _nomeDoResponsavelDeAplicacaoController.text,
        _dataProvavelSegundaDoseController.text,
        id: _id);
    setState(() {
      _vacinacaoWebClient.salvar(vacinacao).then((res) {
        setState(() {
          _displaySnackBar(context, res.toString());
/*Navigator.push(
context,
MaterialPageRoute(builder: (context) => ListaVacinacao()),
);*/
        });
      });
    });
  }

  @override
  void initState() {
    if (widget.vacinacao != null) {
      _id = widget.vacinacao.id;
      _nomeDoVacinadoController.text = widget.vacinacao.nomeDoVacinado;
      _cpfController.text = widget.vacinacao.cpf.toString();
      _ufSelecionada = widget.vacinacao.uf;
      _cidadeController.text = widget.vacinacao.cidade;
      _dataDeAplicacaoController.text = widget.vacinacao.dataDeAplicacao;
      _vacinaSelecionada = widget.vacinacao.vacina;
      _nomeDoResponsavelDeAplicacaoController.text =
          widget.vacinacao.nomeDoResponsavelDeAplicacao;
      _dataProvavelSegundaDoseController.text =
          widget.vacinacao.dataProvavelSegundaDose;
    } else {
      _id = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro de vacinação"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListaVacinacao()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("Nome do Vacinado",
                  _nomeDoVacinadoController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("CPF", _cpfController, TextInputType.number),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Uf:",
                    style: TextStyle(color: Colors.orange[800]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: criaDropDownButton(_uf, _alterarUf, _ufSelecionada),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField(
                  "Cidade", _cidadeController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("Data de Aplicação",
                  _dataDeAplicacaoController, TextInputType.text),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Vacina:",
                    style: TextStyle(color: Colors.orange[800]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: criaDropDownButton(
                        _vacina, _alterarVacina, _vacinaSelecionada),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("Nome do Responsável de Aplicação da Vacina",
                  _nomeDoResponsavelDeAplicacaoController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: criaTextField("Data Provável da Segunda Dose",
                  _dataProvavelSegundaDoseController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _salvar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    onPrimary: Colors.green,
                  ),
                  label: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
