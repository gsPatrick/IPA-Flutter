import 'package:mobx/mobx.dart';
part 'model_aut_cadastro.g.dart';

class ModelAutCadastro = _ModelAutCadastroBase with _$ModelAutCadastro;

abstract class _ModelAutCadastroBase with Store {
  _ModelAutCadastroBase({
    this.email = '',
    this.senha = '',
    this.senhaConfirmacao = '',
  });

  @observable
  String email = '';
  @action
  alterarEmail(String emailInformado) => email = emailInformado;

  @observable
  String senha = '';
  @action
  alterarSenha(String senhaInformada) => senha = senhaInformada;

  @observable
  String senhaConfirmacao = '';
  @action
  alterarSenhaConfirmacao(String senhaConfirmacaoInformada) =>
      senhaConfirmacao = senhaConfirmacaoInformada;
}
