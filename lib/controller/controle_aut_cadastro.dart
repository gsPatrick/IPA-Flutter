import 'package:app_alug_imovel/model/model_aut_cadastro.dart';
import 'package:app_alug_imovel/model/model_aut_login.dart';
import 'package:app_alug_imovel/model/model_cadastro_compl.dart';
import 'package:mobx/mobx.dart';
part 'controle_aut_cadastro.g.dart';

class ControleAutCadastro = _ControleAutCadastroBase with _$ControleAutCadastro;

abstract class _ControleAutCadastroBase with Store {
  var login = ModelAutLogin();
  var cadastro = ModelAutCadastro();
  var cadastroCompl = ModelCadastroCompl();

  @computed
  bool get loginPreenchido =>
      validadeEmailLogin() == null && validaSenhaLogin() == null;

  @computed
  bool get cadastroPreenchido =>
      validaEmailCadastro() == null &&
      validaSenhaCadastro() == null &&
      validaSenhaConfirmacao() == null;

  @computed
  bool get cadastroComplPreenchido =>
      validaNome() == null && validaNumeroCelular() == null;

  String? validaEmail(String email) {
    if (email.isEmpty) {
      return 'Campo obrigatório';
    } else if (!email.contains('@')) {
      return 'Caractere @ obrigatório ';
    } else if (email.length < 10) {
      return 'Informe um email válido';
    } else {
      return null;
    }
  }

  String? validadeEmailLogin() {
    if (login.email != null) {
      return validaEmail(login.email);
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validaEmailCadastro() {
    if (cadastro.email != null) {
      return validaEmail(cadastro.email);
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validaSenha(String senha) {
    if (senha.isEmpty) {
      return 'Campo obrigatório';
    } else if (senha.length < 6) {
      return 'tamanho mínimo de 6 caracteres';
    } else {
      return null;
    }
  }

  String? validaSenhaLogin() {
    if (login.senha != null) {
      return validaSenha(login.senha);
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validaSenhaCadastro() {
    if (cadastro.senha != null) {
      return validaSenha(cadastro.senha);
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validaSenhaConfirmacao() {
    if (cadastro.senhaConfirmacao != null) {
      if (cadastro.senhaConfirmacao.isEmpty) {
        return 'Campo obrigatório';
      } else if (cadastro.senhaConfirmacao != cadastro.senha) {
        return 'Senhas diferentes';
      } else {
        return null;
      }
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validaNome() {
    if (cadastroCompl.nome != null) {
      if (cadastroCompl.nome.isEmpty) {
        return 'Campo obrigatório';
      } else {
        return null;
      }
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validaNumeroCelular() {
    // ignore: unnecessary_null_comparison
    if (cadastroCompl.contato != null) {
      if (cadastroCompl.contato.isEmpty) {
        return 'Campo obrigatório';
      } else if (cadastroCompl.contato.length < 15) {
        return 'Preencha o campo corretamente';
      } else {
        return null;
      }
    } else {
      return 'Campo obrigatório';
    }
  }
}
