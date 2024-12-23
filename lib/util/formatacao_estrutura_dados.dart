import 'package:app_alug_imovel/model/anunciante.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';

class FormEstruturaDados {
  CidadeBairroModel cidBairros = CidadeBairroModel();
  Map<String, dynamic> gerarJSONCadastroAnuncio(
      Anuncio anuncioCriado, String idAnuncio, String idAnunciante) {
    Map<String, dynamic> formRequisicao = {
      'idanuncio': idAnuncio,
      'idanunciante': anuncioCriado.idAnunciante,
      'nomeanunciante': anuncioCriado.nomeAnunciante,
      'contatoanunciante': anuncioCriado.contatoAnunciante,
      'titulo': anuncioCriado.titulo,
      'descricao': anuncioCriado.descricao,
      'categoria': anuncioCriado.categoria,
      'opcaovalor': anuncioCriado.opcaoValor,
      'indcidade': anuncioCriado.indCidade,
      'indbairro': anuncioCriado.indBairro,
      'nquarto': anuncioCriado.nQuarto,
      'urlsimgs': anuncioCriado.urlsImg,
      'valor': anuncioCriado.valor,
      'piscina': anuncioCriado.piscina,
      'garagem': anuncioCriado.garagem,
      'arealazer': anuncioCriado.areaLazer,
      'condincluso': anuncioCriado.condIncluso,
      'iptuincluso': anuncioCriado.iptuIncluso,
      'proxpraia': anuncioCriado.proxPraia,
      'portaria': anuncioCriado.portaria,
      'urlfotoanunciante': anuncioCriado.urlImgAnunciante,
    };

    return formRequisicao;
  }

  Anuncio montarObjAnuncio(dynamic anuncio) {
    List<String> listUrlImg = List<String>.from(anuncio['urlsimgs']);

    return Anuncio(
      idAnuncio: anuncio['idanuncio'],
      idAnunciante: anuncio['idanunciante'],
      nomeAnunciante: anuncio['nomeanunciante'],
      contatoAnunciante: anuncio['contatoanunciante'],
      titulo: anuncio['titulo'],
      descricao: anuncio['descricao'],
      categoria: anuncio['categoria'],
      opcaoValor: anuncio['opcaovalor'],
      indCidade: anuncio['indcidade'],
      indBairro: anuncio['indbairro'],
      nQuarto: anuncio['nquarto'],
      urlsImg: listUrlImg,
      urlImgPesquisa: listUrlImg.first,
      valor: anuncio['valor'],
      piscina: anuncio['piscina'],
      garagem: anuncio['garagem'],
      areaLazer: anuncio['arealazer'],
      condIncluso: anuncio['condincluso'],
      iptuIncluso: anuncio['iptuincluso'],
      proxPraia: anuncio['proxpraia'],
      portaria: anuncio['portaria'],
      urlImgAnunciante: anuncio['urlfotoanunciante'],
    );
  }

  Anunciante montarObjAnunciante(dynamic anunciante) {
    bool estaAtivado = anunciante['ativado'];
    // return (anunciante['ativado'] && anunciante['permissaoanuncio'])
    return (anunciante['permissaoanuncio'])
        ? Anunciante(
            status: anunciante['ativado'] ? 'Ativo' : 'Desativado',
            dataVencimento: anunciante['vencimento'],
            dataInt: anunciante['intdata'],
            email: anunciante['email'],
            nome: anunciante['nomeanunciante'],
            contato: anunciante['contatoanunciante'],
            idAnunciante: anunciante['idAnunciante'],
          )
        : Anunciante(
            status: 'Desativado',
            nome: '-',
            contato: '-',
            dataVencimento: '-',
            email: anunciante['email'],
            idAnunciante: anunciante['idAnunciante'],
          );
  }
}
