// ignore_for_file: unused_element

import 'package:mobx/mobx.dart';
part 'model_form_anuncio.g.dart';

class ModelFormAnuncio = _ModelFormAnuncioBase with _$ModelFormAnuncio;

abstract class _ModelFormAnuncioBase with Store {
  _ModelFormAnuncioBase({
    this.tituloAnuncio = '',
    this.ehCompra = false,
    this.indCategoria = 0,
    this.valorReal = 0,
    this.valor = '',
    this.indOpcValor = 0,
    this.descricao = '',
    this.indCidade = 0,
    this.indBairro = 0,
    this.nQuarto = 0,
    this.temGaragem = false,
    this.temPiscina = false,
    this.temAreaLazer = false,
    this.temCondIncluso = false,
    this.temIptuIncluso = false,
    this.ehProxPraia = false,
    this.temPortaria = false,
  });

  @observable
  String tituloAnuncio = '';
  @action
  alterarTituloAnunc(String tituloAnuncInformado) =>
      tituloAnuncio = tituloAnuncInformado;

  @observable
  bool ehCompra = false;
  @action
  alterarehCompra(bool resposta) => ehCompra = resposta;

  @observable
  int indCategoria = 0;
  @action
  alterarIndCategoria(int indCategoriaInf) => indCategoria = indCategoriaInf;

  @observable
  double valorReal = 0;
  alterarValorReal(double valorInformado) => valorReal = valorInformado;

  @observable
  String valor = '';
  alterarValor(String valorInformado) => valor = valorInformado;

  @observable
  int indOpcValor = 0;
  @action
  alterarIndOpcValor(int indOpcValorInf) => indOpcValor = indOpcValorInf;

  @observable
  String descricao = '';
  @action
  alterarDescricao(String descInformada) => descricao = descInformada;

  @observable
  int indCidade = 0;
  @action
  alterarIndCidade(int indCidadeInf) => indCidade = indCidadeInf;

  @observable
  int indBairro = 0;
  @action
  alterarIndBairro(int indBairroInf) => indBairro = indBairroInf;

  @observable
  int nQuarto = 0;
  @action
  alterarNQuarto(int nQuartoInf) => nQuarto = nQuartoInf;

  @observable
  bool temGaragem = false;
  @action
  altRespGaragem(bool temGaragemAlt) => temGaragem = temGaragemAlt;

  @observable
  bool temPiscina = false;
  @action
  altRespPiscina(bool temPiscinaAlt) => temPiscina = temPiscinaAlt;

  @observable
  bool temAreaLazer = false;
  @action
  altRespAreaLazer(bool areLazerAlt) => temAreaLazer = areLazerAlt;

  @observable
  bool temCondIncluso = false;
  @action
  altCondIncluso(bool condInclusoAlt) => temCondIncluso = condInclusoAlt;

  @observable
  bool temIptuIncluso = false;
  @action
  altIptuIncluso(bool iptuInclusoAlt) => temIptuIncluso = iptuInclusoAlt;

  @observable
  bool ehProxPraia = false;
  @action
  altProxPraia(bool proxPraiaAlt) => ehProxPraia = proxPraiaAlt;

  @observable
  bool temPortaria = false;
  @action
  altTemPortaria(bool temPortariaAlt) => temPortaria = temPortariaAlt;
}
