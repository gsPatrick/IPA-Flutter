// ignore_for_file: unused_element

import 'package:mobx/mobx.dart';
part 'model_form_filtro.g.dart';

class ModelFormFiltro = _ModelFormFiltroBase with _$ModelFormFiltro;

abstract class _ModelFormFiltroBase with Store {
  _ModelFormFiltroBase({
    this.indOpcBusca = 0,
    this.indCidade = 0,
    this.indBairro = 0,
    this.indTipoImovel = 0,
    this.valor = 0,
    this.nQuarto = 0,
    this.temGaragem = false,
    this.temPiscina = false,
    this.temAreaLazer = false,
    this.temCondIncluso = false,
    this.temIptuIncluso = false,
    this.temPortaria = false,
  });

  @observable
  int indOpcBusca = 0;
  @action
  alterarIndOpcBusca(int indOpcBuscaInf) => indOpcBusca = indOpcBuscaInf;

  @observable
  int indCidade = 0;
  @action
  alterarIndCidade(int indCidadeInf) => indCidade = indCidadeInf;

  @observable
  int indBairro = 0;
  @action
  alterarIndBairro(int indBairroInf) => indBairro = indBairroInf;

  @observable
  int indTipoImovel = 0;
  @action
  alterarTipoImovel(int indTipoImovelInf) => indTipoImovel = indTipoImovelInf;

  @observable
  double valor = 0;
  @action
  alterarValorImovel(double valorInformado) => valor = valorInformado;

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
