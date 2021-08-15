class Vacinacao {
  int id;
  String nomeDoVacinado;
  int cpf;
  String uf;
  String cidade;
  String dataDeAplicacao;
  String vacina;
  String nomeDoResponsavelDeAplicacao;
  String dataProvavelSegundaDose;
  Vacinacao(
      this.nomeDoVacinado,
      this.cpf,
      this.uf,
      this.cidade,
      this.dataDeAplicacao,
      this.vacina,
      this.nomeDoResponsavelDeAplicacao,
      this.dataProvavelSegundaDose,
      {this.id});
  Map<String, dynamic> toJson() => {
        "nomeDoVacinado": nomeDoVacinado,
        "cpf": cpf,
        "uf": uf,
        "cidade": cidade,
        "dataDeAplicacao": dataDeAplicacao,
        "vacina": vacina,
        "nomeDoResponsavelDeAplicacao": nomeDoResponsavelDeAplicacao,
        "dataProvavelSegundaDose": dataProvavelSegundaDose
      };
  Vacinacao.fromJson(Map<String, dynamic> json)
      : nomeDoVacinado = json["nomeDoVacinado"],
        cpf = json["cpf"],
        uf = json["uf"],
        cidade = json["cidade"],
        dataDeAplicacao = json["dataDeAplicacao"],
        vacina = json["vacina"],
        nomeDoResponsavelDeAplicacao = json["nomeDoResponsavelDeAplicacao"],
        dataProvavelSegundaDose = json["dataProvavelSegundaDose"],
        id = json["id"];
  @override
  String toString() {
    return "Nome do vacinado: $nomeDoVacinado \n CPF: $cpf \n UF: $uf \n Cidade: $cidade \n Data de Aplicação: $dataDeAplicacao \n Vacina: $vacina \n Nome do Responsavel de Aplicação: $nomeDoResponsavelDeAplicacao \n Data de Aplicação: $dataDeAplicacao";
  }
}
