import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:app_alug_imovel/util/formatacao_data_id.dart';
import 'package:app_alug_imovel/util/formatacao_estrutura_dados.dart';
import 'package:app_alug_imovel/util/manipulacao_img.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ControleAnunciante with ChangeNotifier {
  String urlReq = 'https://appalugvenda-default-rtdb.firebaseio.com';
  FormDataID formatacao = FormDataID();
  FormEstruturaDados formEstruturaDados = FormEstruturaDados();
  ManipulacaoImg manipImg = ManipulacaoImg();
  CidadeBairroModel cidBairros = CidadeBairroModel();
  List<Anuncio> anunciosProprios = [];
  final dio = Dio();
  String? email, senha, idAnunciante;

  ControleAnunciante({this.email, this.senha, this.idAnunciante});

//==================================CRUD ANUNCIOS=======================================================

  Future<void> cadastrarAnuncio(Anuncio anuncioCriado) async {
    String cidadeLocal, bairroLocal;
    String idAnuncio = formatacao.gerarIdAnuncio();
    String urlCadastroAnuncio = '$urlReq/anuncio/$idAnunciante/$idAnuncio.json';

    final List<String> urlsFoto = await manipImg.uploadImgs(
        anuncioCriado.imgsImovel!, idAnunciante!, idAnuncio);

    if (urlsFoto.isNotEmpty) {
      anuncioCriado.urlsImg = urlsFoto;
      Map<String, dynamic> formRequisicao = formEstruturaDados
          .gerarJSONCadastroAnuncio(anuncioCriado, idAnuncio, idAnunciante!);
      final response = await dio.put(urlCadastroAnuncio, data: formRequisicao);
      if (response.statusCode == 200) {
        anuncioCriado.urlsImg = urlsFoto;
        anuncioCriado.urlImgPesquisa = urlsFoto.first;
        print('a requisicao foi bem sucedida');
        anunciosProprios.add(anuncioCriado);
        cidadeLocal = cidBairros.cidades[anunciosProprios.last.indCidade!];
        bairroLocal =
            cidBairros.bairros[cidadeLocal]![anunciosProprios.last.indBairro!];
        anunciosProprios.last.cidade = cidadeLocal;
        anunciosProprios.last.bairro = bairroLocal;
      } else {
        print('requisicao mal sucedida');
      }
    } else {
      print('nao foi possivel salvar a imagem no banco de dados');
    }

    notifyListeners();
  }

  // Future<void> editarAnuncio(Anuncio anuncioAlterado) async {
  //   String cidadeLocal, bairroLocal;

  //   String urlCadastroAnuncio =
  //       '$urlReq/anuncio/$idAnunciante/${anuncioAlterado.idAnuncio}.json';

  //   final List<String> urlsFoto = await manipImg.uploadImgs(
  //       anuncioAlterado.imgsImovel!, idAnunciante!, anuncio);

  //   if (urlsFoto.isNotEmpty) {
  //     anuncioAlterado.urlsImg = urlsFoto;
  //     Map<String, dynamic> formRequisicao =
  //         formEstruturaDados.gerarJSONCadastroAnuncio(
  //             anuncioAlterado, anuncioAlterado.idAnuncio!, idAnunciante!);
  //     final response = await dio.put(urlCadastroAnuncio, data: formRequisicao);
  //     if (response.statusCode == 200) {
  //       anuncioAlterado.urlsImg = urlsFoto;
  //       anuncioAlterado.urlImgPesquisa = urlsFoto.first;
  //       print('a requisicao foi bem sucedida');
  //       anunciosProprios.add(anuncioCriado);
  //       cidadeLocal = cidBairros.cidades[anunciosProprios.last.indCidade!];
  //       bairroLocal =
  //           cidBairros.bairros[cidadeLocal]![anunciosProprios.last.indBairro!];
  //       anunciosProprios.last.cidade = cidadeLocal;
  //       anunciosProprios.last.bairro = bairroLocal;
  //     } else {
  //       print('requisicao mal sucedida');
  //     }
  //   } else {
  //     print('nao foi possivel salvar a imagem no banco de dados');
  //   }

  //   notifyListeners();
  // }

  // Future<void> carregarPropriosAnuncios(String idAnunciante) async {
  //   String cidadeLocal, bairroLocal;
  //   final urlLogin = '$urlReq/anuncio/$idAnunciante/.json';
  //   final response = await dio.get(urlLogin);
  //   if (anunciosProprios.isNotEmpty) {
  //     anunciosProprios.clear();
  //   }
  //   if (response.statusCode == 200 && response.data != null) {
  //     final Map<String, dynamic> dados = response.data as Map<String, dynamic>;

  //     dados.forEach((key, anuncio) {
  //       anunciosProprios.add(formEstruturaDados.montarObjAnuncio(anuncio));
  //       cidadeLocal = cidBairros.cidades[anunciosProprios.last.indCidade!];
  //       bairroLocal =
  //           cidBairros.bairros[cidadeLocal]![anunciosProprios.last.indBairro!];
  //       anunciosProprios.last.cidade = cidadeLocal;
  //       anunciosProprios.last.bairro = bairroLocal;
  //       // anunciosProprios.last.imgsImovel=
  //     });
  //     print('anuncios proprios tamanho : ${anunciosProprios.length}');
  //   } else {
  //     print('requisicao mal sucedida');
  //   }
  //   notifyListeners();
  // }
}
