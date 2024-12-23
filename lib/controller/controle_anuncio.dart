import 'dart:convert';
import 'dart:io';

import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_pesquisa.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:app_alug_imovel/util/formatacao_data_id.dart';
import 'package:app_alug_imovel/util/formatacao_estrutura_dados.dart';
import 'package:app_alug_imovel/util/manipulacao_img.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControleAnuncio with ChangeNotifier {
  String urlReq = 'https://appalugvenda-default-rtdb.firebaseio.com';
  FormDataID formatacao = FormDataID();
  FormEstruturaDados formEstruturaDados = FormEstruturaDados();
  ManipulacaoImg manipImg = ManipulacaoImg();
  ControlePesquisa contrPesq = ControlePesquisa();
  CidadeBairroModel cidBairros = CidadeBairroModel();
  final dio = Dio();
  List<Anuncio> todosAnuncios = [];
  List<Anuncio> anunciosProprios = [];
  List<Anuncio> anuncios = [];
  List<Anuncio> anunciosPesq = [];
  List<Anuncio> anuncFavoritos = [];
  List<String> idAnunciosFavoritos = [];
  Anuncio? anuncioSelecionado;
  bool clienteLogado = false;

  //==============================

  List<String> tiposValores = [
    'Valor Mensal',
    'Valor por Dia',
    'Valor Único',
  ];
  List<String> categorias = [
    'Casa',
    'Apartamento',
    'Flat',
    'Quarto',
    'Kitnet',
  ];
  //==================================CRUD ANUNCIOS=======================================================
// alterarDepois
  Future<void> cadastrarAnuncio(
      Anuncio anuncioCriado, String idAnunciante) async {
    String cidadeLocal, bairroLocal;
    String idAnuncio = formatacao.gerarIdAnuncio();
    String urlCadastroAnuncio = '$urlReq/anuncio/$idAnunciante/$idAnuncio.json';

    final List<String> urlsFoto = await manipImg.uploadImgs(
        anuncioCriado.imgsImovel!, idAnunciante, idAnuncio);

    if (urlsFoto.isNotEmpty) {
      anuncioCriado.urlsImg = urlsFoto;
      Map<String, dynamic> formRequisicao = formEstruturaDados
          .gerarJSONCadastroAnuncio(anuncioCriado, idAnuncio, idAnunciante);
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

  Future<void> carregarPropriosAnuncios(String idAnunciante) async {
    String cidadeLocal, bairroLocal;
    final urlLogin = '$urlReq/anuncio/$idAnunciante/.json';
    final response = await dio.get(urlLogin);
    if (anunciosProprios.isNotEmpty) {
      anunciosProprios.clear();
    }
    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;

      dados.forEach((key, anuncio) {
        // print('anuncio do anunciante : $anuncio');
        anunciosProprios.add(formEstruturaDados.montarObjAnuncio(anuncio));
        cidadeLocal = cidBairros.cidades[anunciosProprios.last.indCidade!];
        // print('cidade $cidadeLocal');
        cidadeLocal =
            cidadeLocal == 'Joao Pessoa' ? 'João Pessoa' : cidadeLocal;
        bairroLocal =
            cidBairros.bairros[cidadeLocal]![anunciosProprios.last.indBairro!];
        anunciosProprios.last.cidade = cidadeLocal;
        anunciosProprios.last.bairro = bairroLocal;
        // anunciosProprios.last.imgsImovel=
      });
      print('anuncios proprios tamanho : ${anunciosProprios.length}');
    } else {
      print('requisicao mal sucedida');
    }
    notifyListeners();
  }

  Future<void> editarAnuncio(Anuncio anuncioAlterado, String idAnunciante,
      List<String> urlImgExcludia, List<File> novasImgs) async {
    String cidadeLocal, bairroLocal;

    String urlCadastroAnuncio =
        '$urlReq/anuncio/$idAnunciante/${anuncioAlterado.idAnuncio}.json';

    final List<String> urlsFoto = await manipImg.substituirTodasFotosAnuncio(
        anuncioAlterado.urlsImg!,
        urlImgExcludia,
        novasImgs,
        idAnunciante,
        anuncioAlterado.idAnuncio!);

    if (urlsFoto.isNotEmpty) {
      anuncioAlterado.urlsImg = urlsFoto;
      Map<String, dynamic> formRequisicao =
          formEstruturaDados.gerarJSONCadastroAnuncio(
              anuncioAlterado, anuncioAlterado.idAnuncio!, idAnunciante!);
      final response =
          await dio.patch(urlCadastroAnuncio, data: formRequisicao);
      if (response.statusCode == 200) {
        anuncioAlterado.urlsImg = urlsFoto;
        anuncioAlterado.urlImgPesquisa = urlsFoto.first;
        print('a requisicao foi bem sucedida');

        int indice = anunciosProprios.indexWhere(
            (anuncio) => anuncio.idAnuncio == anuncioAlterado.idAnuncio);

        if (indice != -1) {
          anunciosProprios[indice] = anuncioAlterado;
        }

        // anunciosProprios.add(anuncioAlterado);

        cidadeLocal = cidBairros.cidades[anunciosProprios.last.indCidade!];
        cidadeLocal =
            cidadeLocal == 'Joao Pessoa' ? 'João Pessoa' : cidadeLocal;
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

  //   String urlAlteracaoAnuncio =
  //       '$urlReq/anuncio/${anuncioAlterado.idAnunciante}/${anuncioAlterado.idAnuncio}.json';
  // }

  Future<void> carregarAnunciosTelaInicial() async {
    String cidadeLocal, bairroLocal;
    final urlLogin = '$urlReq/anuncio/.json';
    final response = await dio.get(urlLogin);
    if (anuncios.isNotEmpty) {
      anuncios.clear();
      todosAnuncios.clear();
    }
    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;

      dados.forEach((key, anunciantes) {
        Map<String, dynamic> anunciosJson = anunciantes as Map<String, dynamic>;
        anunciosJson.forEach((key, anuncio) {
          // if (anuncio['opcaovalor']) {}
          anuncios.add(formEstruturaDados.montarObjAnuncio(anuncio));
          cidadeLocal = cidBairros.cidades[anuncios.last.indCidade!];
          cidadeLocal =
              cidadeLocal == 'Joao Pessoa' ? 'João Pessoa' : cidadeLocal;
          bairroLocal =
              cidBairros.bairros[cidadeLocal]![anuncios.last.indBairro!];
          anuncios.last.cidade = cidadeLocal;
          anuncios.last.bairro = bairroLocal;
        });

        // anunciosProprios.last.imgsImovel=
      });
    } else {}
    // todosAnuncios = anuncios;
    print('===========carregando tela inicial ============');
    for (var element in anuncios) {
      print('  ${element.titulo}');
    }
    print('===========carregando tela inicial ============');
    todosAnuncios.addAll(anuncios);
    notifyListeners();
  }

  Future<void> funcaoInfoFotosTeste() async {
    Anuncio anuncioTeste = anuncios.last;
    print('teste : ${anuncioTeste.urlsImg}');
    // await manipImg.substituirTodasFotosAnuncio(anuncioTeste.urlsImg!,
    //     anuncioTeste.idAnunciante!, anuncioTeste.idAnuncio!);
  }

  Future<void> registrarDenuncia(
      Anuncio anuncioDenunciado, String mensagem) async {
    String idAnuncio = anuncioDenunciado.idAnuncio!;
    String urlCadastroAnuncio = '$urlReq/denuncia/$idAnuncio.json';
    Map<String, dynamic> formRequisicao =
        formEstruturaDados.gerarJSONCadastroAnuncio(
            anuncioDenunciado, idAnuncio, anuncioDenunciado.idAnunciante!);
    formRequisicao['mensagem'] = mensagem;
    final response = await dio.put(urlCadastroAnuncio, data: formRequisicao);
    if (response.statusCode == 200) {
      print('a requisicao foi bem sucedida');
    } else {
      print('requisicao mal sucedida');
    }
  }

  //=========================== **FAVORITOS**===========================

  Future<void> carregarFavoritos(String idCliente) async {
    String urlReqFavoritos = '$urlReq/cliente/$idCliente.json';

    final response = await dio.get(urlReqFavoritos);

    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;

      if (dados['temfavorito']) {
        List<dynamic> listaJson = jsonDecode(dados['favoritos']);
        idAnunciosFavoritos =
            listaJson.map((idAnuncio) => idAnuncio.toString()).toList();
        for (var id in idAnunciosFavoritos) {
          for (var anuncio in todosAnuncios) {
            if (anuncio.idAnuncio == id) {
              anuncio.ehFavorito = true;
            }
          }
        }
        if (anuncios.isNotEmpty) {
          anuncios.clear();
        }
        anuncios.addAll(todosAnuncios);
      }
    } else {
      print('nao foi possivel fazer a requisicao');
    }

    notifyListeners();
  }

  atualizarFavoritoNaListaPrincipal(String idAnuncio) {
    int indiceDoAnuncio = 0;
    bool idEncontrado = false;

    for (int i = 0; i < todosAnuncios.length; i++) {
      var anuncio = todosAnuncios[i];

      if (anuncio.idAnuncio == idAnuncio) {
        anuncio.ehFavorito = !anuncio.ehFavorito;

        if (anuncio.ehFavorito) {
          idAnunciosFavoritos.add(anuncio.idAnuncio!);
        } else {
          idAnunciosFavoritos.remove(anuncio.idAnuncio);
        }

        // Armazena o índice do anúncio que teve o atributo alterado
        indiceDoAnuncio = i;
        idEncontrado = true;
      }
    }

    if (idEncontrado) {
      // Substitui apenas a parte da lista onde o anúncio foi alterado
      anuncios[indiceDoAnuncio] = todosAnuncios[indiceDoAnuncio];
    }

    notifyListeners();
  }

  Future<void> salvarAnuncioFavorito(String idCliente) async {
    String urlReqFavorito = '$urlReq/cliente/$idCliente.json';
    // String lista = jsonEncode(idAnunciosFavoritos);
    final Map<String, dynamic> formRequisicao = {
      'temfavorito': true,
      'favoritos': jsonEncode(idAnunciosFavoritos),
    };
    final response = await dio.patch(urlReqFavorito, data: formRequisicao);

    if (response.statusCode == 200 && response.data != null) {
      print('lista salva');
    } else {
      print('ocorreu um problema');
    }
  }

//=================================PESQUISAS E FILTRAGENS======================================================

  retornarPesquisa(ControleFormAnuncio controleForm) {
    String cidade = cidBairros.cidades[controleForm.anuncio.indCidade];
    String bairro = cidBairros.bairros[cidade]![controleForm.anuncio.indBairro];

    bool ehCompra = controleForm.anuncio.indOpcValor == 1;
    int indOpcValor = ehCompra ? 2 : 1;

    anunciosPesq = contrPesq.filtrarPorTipoProcura(anuncios, indOpcValor);

    anunciosPesq = contrPesq.filtrarCidade(anunciosPesq, cidade);

    anunciosPesq = contrPesq.filtrarBairro(anunciosPesq, cidade, bairro);

    anunciosPesq = contrPesq.filtrarCategoria(
        anunciosPesq, controleForm.anuncio.indCategoria);

    anunciosPesq =
        contrPesq.filtrarValor(anunciosPesq, controleForm.anuncio.valorReal);

    anunciosPesq =
        contrPesq.filtrarNQuarto(anunciosPesq, controleForm.anuncio.nQuarto);

    anunciosPesq = contrPesq.filtrarCheckBox(controleForm, anunciosPesq);

    anunciosPesq.forEach((element) {
      print('titulo : ${element.titulo}');
    });

    anuncios.clear();
    anuncios.addAll(anunciosPesq);

    notifyListeners();
  }

  pesquisaIndexAnuncio(String termo) {
    List<Anuncio> resultados = [];
    for (var element in todosAnuncios) {
      print('${element.titulo}');
    }
    for (Anuncio anuncio in todosAnuncios) {
      if (anuncio.titulo!.isNotEmpty &&
          anuncio.titulo!.toLowerCase().contains(termo.toLowerCase())) {
        resultados.add(anuncio);
      }
    }
    anuncios.clear();

    for (var element in resultados) {
      print('${element.titulo}');
    }
    anuncios.addAll(resultados);

    notifyListeners();
  }

  pesquisaRapida(int indProcura, int indCidade, int indBairro,
      int indTipoImovel, double valor) {
    String cidade = cidBairros.cidades[indCidade];
    String bairro = cidBairros.bairros[cidade]![indBairro];

    anunciosPesq = contrPesq.filtrarPorTipoProcura(
      anuncios,
      indProcura,
    );

    anunciosPesq = contrPesq.filtrarCategoria(anunciosPesq, indTipoImovel);

    anunciosPesq = contrPesq.filtrarValor(anunciosPesq, valor);

    anunciosPesq = contrPesq.filtrarCidade(anunciosPesq, cidade);

    anunciosPesq = contrPesq.filtrarBairro(anunciosPesq, cidade, bairro);

    anuncios.clear();
    anuncios.addAll(anunciosPesq);

    notifyListeners();
  }

  limparPesquisa() {
    anuncios.clear();
    anuncios.addAll(todosAnuncios);
    notifyListeners();
  }

  sairSessao() {
    anuncios.clear();
    todosAnuncios.clear();
    anunciosPesq.clear();
    notifyListeners();
  }

// =============================*******=============================
  Future<void> excluirAnuncio(String idAnunciante, String idAnuncio,
      int indAnuncio, bool ehAdmMaster) async {
    final urlLogin = '$urlReq/anuncio/$idAnunciante/$idAnuncio.json';
    final response = await dio.delete(urlLogin);
    print('teste 2');

    if (response.statusCode == 200) {
      if (ehAdmMaster) {
        anuncios.removeAt(indAnuncio);
      } else {
        anunciosProprios.removeAt(indAnuncio);
      }

      print('requisicao bem sucedida');
    } else {
      print('requisicao mal sucedida');
    }
    notifyListeners();
  }

  // =============================*******=============================

// =============================*******=============================
}
