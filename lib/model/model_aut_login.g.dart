// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_aut_login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ModelAutLogin on _ModelAutLoginBase, Store {
  late final _$emailAtom =
      Atom(name: '_ModelAutLoginBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$senhaAtom =
      Atom(name: '_ModelAutLoginBase.senha', context: context);

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  late final _$_ModelAutLoginBaseActionController =
      ActionController(name: '_ModelAutLoginBase', context: context);

  @override
  dynamic alterarEmail(String emailInformado) {
    final _$actionInfo = _$_ModelAutLoginBaseActionController.startAction(
        name: '_ModelAutLoginBase.alterarEmail');
    try {
      return super.alterarEmail(emailInformado);
    } finally {
      _$_ModelAutLoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alterarSenha(String senhaInformada) {
    final _$actionInfo = _$_ModelAutLoginBaseActionController.startAction(
        name: '_ModelAutLoginBase.alterarSenha');
    try {
      return super.alterarSenha(senhaInformada);
    } finally {
      _$_ModelAutLoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
senha: ${senha}
    ''';
  }
}
