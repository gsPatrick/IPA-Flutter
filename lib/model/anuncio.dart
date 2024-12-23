import 'dart:io';

class Anuncio {
  String? nomeAnunciante, contatoAnunciante, idAnunciante, urlImgAnunciante;
  String? titulo, descricao, urlImgPesquisa, idAnuncio, bairro, cidade;
  int? categoria, opcaoValor, indCidade, indBairro, nQuarto;
  List<File>? imgsImovel = [];
  List<String>? urlsImg = [];
  String? mensagemDenuncia = '-';
  double? valor;
  bool ehFavorito = false;
  bool? garagem,
      piscina,
      areaLazer,
      condIncluso,
      iptuIncluso,
      proxPraia,
      portaria;

  Anuncio({
    this.idAnuncio,
    this.idAnunciante,
    this.nomeAnunciante,
    this.contatoAnunciante,
    this.urlImgAnunciante,
    this.titulo,
    this.descricao,
    this.urlImgPesquisa,
    this.categoria,
    this.opcaoValor,
    this.indCidade,
    this.indBairro,
    this.nQuarto,
    this.imgsImovel,
    this.urlsImg,
    this.valor,
    this.garagem,
    this.piscina,
    this.areaLazer,
    this.condIncluso,
    this.iptuIncluso,
    this.proxPraia,
    this.portaria,
    this.mensagemDenuncia,
  });

  factory Anuncio.fromJson(Map<String, dynamic> anuncio) {
    return Anuncio(
      idAnuncio: anuncio['idanuncio'],
      nomeAnunciante: anuncio['nomeanunciante'],
      contatoAnunciante: anuncio['contatoanunciante'],
      titulo: anuncio['titulo'],
      descricao: anuncio['descricao'],
      categoria: anuncio['categoria'],
      opcaoValor: anuncio['opcaovalor'],
      indCidade: anuncio['indcidade'],
      indBairro: anuncio['indbairro'],
      nQuarto: anuncio['nquarto'],
      urlsImg: anuncio['urlsimgs'],
      valor: anuncio['valor'],
      garagem: anuncio['garagem'],
      areaLazer: anuncio['arealazer'],
      condIncluso: anuncio['condincluso'],
      iptuIncluso: anuncio['iptuincluso'],
      proxPraia: anuncio['proxpraia'],
      portaria: anuncio['portaria'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'idanuncio': idAnuncio,
      'nomeanunciante': nomeAnunciante,
      'contatoanunciante': contatoAnunciante,
      'titulo': titulo,
      'descricao': descricao,
      'categoria': categoria,
      'opcaovalor': opcaoValor,
      'indcidade': indCidade,
      'indbairro': indBairro,
      'nquarto': nQuarto,
      'urlsimgs': urlsImg,
      'valor': valor,
      'garagem': garagem,
      'arealazer': areaLazer,
      'condincluso': condIncluso,
      'iptuincluso': iptuIncluso,
      'proxpraia': proxPraia,
      'portaria': portaria,
    };
  }
}
