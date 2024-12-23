import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:mobx/mobx.dart';
part 'model_form_pesquisa.g.dart';

class ModelFormPesquisa = _ModelFormPequisaBase with _$ModelFormPesquisa;

abstract class _ModelFormPequisaBase with Store {
  CidadeBairroModel cidBairros = CidadeBairroModel();

  _ModelFormPequisaBase({
    this.ehCompra = true,
    this.indCidade = 0,
    this.indBairro = 0,
    this.indCategoria = 0,
    this.valor = 0,
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
  bool ehCompra = true;
  @action
  alterarehCompra(bool resposta) => ehCompra = resposta;

  @observable
  int indCidade = 0;
  @action
  alterarIndCidade(int indCidadeInf) => indCidade = indCidadeInf;

  @observable
  int indBairro = 0;
  @action
  alterarIndBairro(int indBairroInf) => indBairro = indBairroInf;

  @observable
  int indCategoria = 0;
  @action
  alterarIndCategoria(int indCategoriaInf) => indCategoria = indCategoriaInf;

  @observable
  double valor = 0;
  alterarValor(double valorInformado) => valor = valorInformado;

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
