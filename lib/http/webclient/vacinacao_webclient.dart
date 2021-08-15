import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart';
import 'package:web_api_vacinacao/model/vacinacao.dart';
import '../web_client.dart';

class VacinacaoWebClient {
  Future<List<Vacinacao>> findAll() async {
    final Response response =
        await client.get(Uri.http(baseUrl, api)).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson =
        jsonDecode(utf8.decode(response.bodyBytes));
    return decodedJson.map((dynamic json) => Vacinacao.fromJson(json)).toList();
  }

  Future<Vacinacao> salvar(Vacinacao vacinacao) async {
    Response response;
// ignore: unnecessary_null_comparison
    if (vacinacao.id == null) {
      response = await client.post(Uri.http(baseUrl, api),
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(vacinacao.toJson()));
    } else {
      Uri alterar = Uri.http(baseUrl, api + "/${vacinacao.id}");
      response = await client.put(alterar,
          headers: {
            'Content-type': 'application/json',
          },
          body: jsonEncode(vacinacao.toJson()));
    }
    return Vacinacao.fromJson(jsonDecode(response.body));
  }

  Future<Null> excluir(int id) async {
    // ignore: unused_local_variable
    Response response;
    Uri deletar = Uri.http(baseUrl, api + "/$id");
    response = await client.delete(deletar, headers: {
      'Content-type': 'application/json',
    });
  }
}
