import 'package:app_alug_imovel/model/anunciante.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/formatacao_estrutura_dados.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControleAdm with ChangeNotifier {
  final dio = Dio();
  FormEstruturaDados formEstruturaDados = FormEstruturaDados();
  String? email, senha;
  String urlReq = 'https://appalugvenda-default-rtdb.firebaseio.com';
  ControleAdm({this.email, this.senha});
  List<Anunciante> anunciantes = [];
  List<Anuncio> anunciosDenunciados = [];
  List<Anunciante> todosAnunciantes = [];

  Future<void> carregarAnunciante() async {
    final urlAcesso = '$urlReq/anunciante/.json';
    final response = await dio.get(urlAcesso);
    if (anunciantes.isNotEmpty) {
      anunciantes.clear();
    }
    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;
      print('requisicao bem sucedida');
      dados.forEach((key, anunciante) {
        Anunciante anuncianteTeste =
            formEstruturaDados.montarObjAnunciante(anunciante);
        anunciantes.add(anuncianteTeste);
      });
    } else {
      print('requisicao mal sucedida');
    }

    todosAnunciantes.addAll(anunciantes);
    notifyListeners();
  }

  Future<void> carregarDenuncias() async {
    final urlLogin = '$urlReq/denuncia/.json';
    Anuncio? denunciaRecebida;
    final response = await dio.get(urlLogin);
    if (anunciosDenunciados.isNotEmpty) {
      anunciosDenunciados.clear();
    }
    print('oi 1 ');
    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;

      dados.forEach((key, denuncia) {
        // print('key : $key  denuncia : $denuncia');
        denunciaRecebida = formEstruturaDados.montarObjAnuncio(denuncia);
        denunciaRecebida?.mensagemDenuncia = denuncia['mensagem'];
        anunciosDenunciados.add(denunciaRecebida!);

        // anunciosProprios.last.imgsImovel=
      });
    } else {
      print('requisicao mal sucedida');
    }

    notifyListeners();
    return Future.value();
  }

//=============================***Funcoes Anunciantes***====================================
  Future<void> renovarPrazo(Anunciante anunciante, int indice) async {
    final urlAcesso = '$urlReq/anunciante/${anunciante.idAnunciante}/.json';
    // String novaData = renovarData(anunciante.dataInt!);
    Anunciante novoAnunciante = renovarData(anunciante);
    Map<String, dynamic> formRequisicao = {
      'ativado': true,
      'vencimento': novoAnunciante.dataVencimento,
      'dataint': novoAnunciante.dataInt,
    };
    final response = await dio.patch(urlAcesso, data: formRequisicao);

    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;
      anunciantes[indice].dataInt = novoAnunciante.dataInt;
      anunciantes[indice].dataVencimento = novoAnunciante.dataVencimento;
      anunciantes[indice].status = 'Ativo';
    } else {
      print('requisicao mal sucedida');
    }
    // todosAnuncios = anuncios;

    notifyListeners();
  }

  Future<void> desativarPerfilAnunciante(
      Anunciante anunciante, int indice) async {
    final urlAcesso = '$urlReq/anunciante/${anunciante.idAnunciante}/.json';
    // String novaData = renovarData(anunciante.dataInt!);
    anunciante.status = 'Desativado';
    Map<String, dynamic> formRequisicao = {
      'ativado': false,
    };
    final response = await dio.patch(urlAcesso, data: formRequisicao);

    if (response.statusCode == 200 && response.data != null) {
      print('requisicao bem sucedida');
      anunciantes[indice].status = 'Desativado';
    } else {
      print('requisicao mal sucedida');
    }
    // todosAnuncios = anuncios;

    notifyListeners();
  }

  Future<void> excluirPerfilAnunciante(
      Anunciante anunciante, int indice) async {
    final urlAcesso = '$urlReq/anunciante/${anunciante.idAnunciante}/.json';
    final response = await dio.delete(urlAcesso);
    if (response.statusCode == 200 && response.data != null) {
      // anunciantes.removeAt(indice);
    } else {}
    notifyListeners();
  }

  pesquisaIndexAnuncio(String termo) {
    List<Anunciante> resultados = [];
    for (Anunciante anunciante in todosAnunciantes) {
      if (anunciante.nome!.isNotEmpty &&
          anunciante.nome!.toLowerCase().contains(termo.toLowerCase())) {
        resultados.add(anunciante);
      }
    }
    anunciantes.clear();
    anunciantes = resultados;
    notifyListeners();
  }

  limparPesquisa() {
    anunciantes.clear();
    anunciantes.addAll(todosAnunciantes);
    notifyListeners();
  }

  // =====================***======================

  Anunciante renovarData(Anunciante anunciante) {
    DateTime dataAtual = DateTime.now();
    int mesAtual = dataAtual.month;
    int anoAtual = dataAtual.year;
    if (mesAtual > 11) {
      anoAtual++;
      mesAtual = 1;
    } else {
      mesAtual++;
    }

    String novaData =
        '${dataAtual.day.toString()}-${mesAtual.toString().padLeft(2, '0')}-${anoAtual.toString()}';
    int dataInt = int.parse('$anoAtual$mesAtual${dataAtual.day}');
    anunciante.dataInt = dataInt;
    anunciante.dataVencimento = novaData;

    return anunciante;
  }

  //==============================***********=======================================
  Future<void> excluirDenuncia(String idAnuncio, int indAnuncio) async {
    final urlLogin = '$urlReq/denuncia/$idAnuncio.json';
    final response = await dio.delete(urlLogin);

    if (response.statusCode == 200) {
      print('requisicao bem sucedida');
      anunciosDenunciados.removeAt(indAnuncio);
    } else {
      print('requisicao mal sucedida');
    }
    notifyListeners();
  }
}
