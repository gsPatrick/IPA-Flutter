// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controle_aut_cadastro.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControleAutCadastro on _ControleAutCadastroBase, Store {
  Computed<bool>? _$loginPreenchidoComputed;

  @override
  bool get loginPreenchido =>
      (_$loginPreenchidoComputed ??= Computed<bool>(() => super.loginPreenchido,
              name: '_ControleAutCadastroBase.loginPreenchido'))
          .value;
  Computed<bool>? _$cadastroPreenchidoComputed;

  @override
  bool get cadastroPreenchido => (_$cadastroPreenchidoComputed ??=
          Computed<bool>(() => super.cadastroPreenchido,
              name: '_ControleAutCadastroBase.cadastroPreenchido'))
      .value;
  Computed<bool>? _$cadastroComplPreenchidoComputed;

  @override
  bool get cadastroComplPreenchido => (_$cadastroComplPreenchidoComputed ??=
          Computed<bool>(() => super.cadastroComplPreenchido,
              name: '_ControleAutCadastroBase.cadastroComplPreenchido'))
      .value;

  @override
  String toString() {
    return '''
loginPreenchido: ${loginPreenchido},
cadastroPreenchido: ${cadastroPreenchido},
cadastroComplPreenchido: ${cadastroComplPreenchido}
    ''';
  }
}
