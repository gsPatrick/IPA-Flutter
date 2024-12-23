import 'package:app_alug_imovel/model/anuncio.dart';

class Anunciante {
  String? status, email, idAnunciante;
  String? nome = '-';
  String? contato = '-';
  String? dataVencimento = '-';
  int? dataInt = 0;
  bool? ativado;
  List<Anuncio>? anuncios = [];

  Anunciante({
    this.status,
    this.ativado,
    this.dataVencimento,
    this.dataInt,
    this.email,
    this.nome,
    this.contato,
    this.idAnunciante,
    this.anuncios,
  });
}
