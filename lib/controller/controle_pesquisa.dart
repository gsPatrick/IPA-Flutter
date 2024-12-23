import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';

class ControlePesquisa {
  // List<Anuncio> anunciosRetornados = [];
  CidadeBairroModel cidBairros = CidadeBairroModel();

  List<Anuncio> filtrarPorTipoProcura(List<Anuncio> anuncios, int indOpcValor) {
    if (indOpcValor == 2) {
      return anuncios
          .where((anuncio) => anuncio.opcaoValor == indOpcValor)
          .toList();
    } else {
      return anuncios.where((anuncio) => anuncio.opcaoValor != 2).toList();
    }
  }

  List<Anuncio> filtrarCategoria(List<Anuncio> anuncios, int indice) {
    return anuncios.where((anuncio) => anuncio.categoria == indice).toList();
  }

  List<Anuncio> filtrarValor(List<Anuncio> anuncios, double valor) {
    return anuncios.where((anuncio) => anuncio.valor! <= valor).toList();
  }

  List<Anuncio> filtrarCidade(List<Anuncio> anuncios, String cidade) {
    return anuncios
        .where((anuncio) => cidBairros.cidades[anuncio.indCidade!] == cidade)
        .toList();
  }

  List<Anuncio> filtrarBairro(
      List<Anuncio> anuncios, String cidSelecionada, String bairro) {
    return anuncios
        .where((anuncio) =>
            cidBairros.bairros[cidSelecionada]?[anuncio.indBairro!] == bairro)
        .toList();
  }

  List<Anuncio> filtrarNQuarto(List<Anuncio> anuncios, int nQuarto) {
    return anuncios.where((anuncio) => anuncio.nQuarto == nQuarto).toList();
  }

  List<Anuncio> filtrarCheckBox(
      ControleFormAnuncio controleForm, List<Anuncio> anuncios) {
    List<Anuncio> anuncioCheck = [];
    anuncioCheck = controleForm.anuncio.temGaragem
        ? filtrarPorGaragem(anuncios)
        : anuncios;
    anuncioCheck = controleForm.anuncio.temPiscina
        ? filtrarPorPiscina(anuncioCheck)
        : anuncioCheck;
    anuncioCheck = controleForm.anuncio.temAreaLazer
        ? filtrarPorAreaLazer(anuncioCheck)
        : anuncioCheck;
    anuncioCheck = controleForm.anuncio.temCondIncluso
        ? filtrarPorCondIncluso(anuncioCheck)
        : anuncioCheck;
    anuncioCheck = controleForm.anuncio.temIptuIncluso
        ? filtrarPorIPTUIncluso(anuncioCheck)
        : anuncioCheck;
    anuncioCheck = controleForm.anuncio.ehProxPraia
        ? filtrarPorProxPraia(anuncioCheck)
        : anuncioCheck;
    anuncioCheck = controleForm.anuncio.temPortaria
        ? filtrarPorPortaria(anuncioCheck)
        : anuncioCheck;

    return anuncioCheck;
  }

  List<Anuncio> filtrarPorGaragem(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.garagem!).toList();
  }

  List<Anuncio> filtrarPorPiscina(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.piscina!).toList();
  }

  List<Anuncio> filtrarPorAreaLazer(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.areaLazer!).toList();
  }

  List<Anuncio> filtrarPorCondIncluso(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.condIncluso!).toList();
  }

  List<Anuncio> filtrarPorIPTUIncluso(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.iptuIncluso!).toList();
  }

  List<Anuncio> filtrarPorProxPraia(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.proxPraia!).toList();
  }

  List<Anuncio> filtrarPorPortaria(List<Anuncio> anuncios) {
    return anuncios.where((anuncio) => anuncio.portaria!).toList();
  }
}
