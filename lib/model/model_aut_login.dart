import 'package:mobx/mobx.dart';
part 'model_aut_login.g.dart';

class ModelAutLogin = _ModelAutLoginBase with _$ModelAutLogin;

abstract class _ModelAutLoginBase with Store {
  _ModelAutLoginBase({
    this.email = '',
    this.senha = '',
  });

  @observable
  String email = '';
  @action
  alterarEmail(String emailInformado) => email = emailInformado;

  @observable
  String senha = '';
  @action
  alterarSenha(String senhaInformada) => senha = senhaInformada;
}
