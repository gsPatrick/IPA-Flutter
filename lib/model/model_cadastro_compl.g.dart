// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_cadastro_compl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ModelCadastroCompl on _ModelCadastroComplBase, Store {
  late final _$nomeAtom =
      Atom(name: '_ModelCadastroComplBase.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$contatoAtom =
      Atom(name: '_ModelCadastroComplBase.contato', context: context);

  @override
  String get contato {
    _$contatoAtom.reportRead();
    return super.contato;
  }

  @override
  set contato(String value) {
    _$contatoAtom.reportWrite(value, super.contato, () {
      super.contato = value;
    });
  }

  late final _$_ModelCadastroComplBaseActionController =
      ActionController(name: '_ModelCadastroComplBase', context: context);

  @override
  dynamic alterarNome(String nomeInformado) {
    final _$actionInfo = _$_ModelCadastroComplBaseActionController.startAction(
        name: '_ModelCadastroComplBase.alterarNome');
    try {
      return super.alterarNome(nomeInformado);
    } finally {
      _$_ModelCadastroComplBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic alterarContato(String contatoInformado) {
    final _$actionInfo = _$_ModelCadastroComplBaseActionController.startAction(
        name: '_ModelCadastroComplBase.alterarContato');
    try {
      return super.alterarContato(contatoInformado);
    } finally {
      _$_ModelCadastroComplBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
contato: ${contato}
    ''';
  }
}
