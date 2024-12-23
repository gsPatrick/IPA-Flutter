import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class CampoSenhaCadastro extends StatelessWidget {
  final String? nomeCampo;
  final Function(String value) registrarAlteracao;
  final Function() notificarErro;
  final int? maxCaracteres;
  final String? informacaoInicial;
  final String corTexto;

  const CampoSenhaCadastro(
      {required this.nomeCampo,
      required this.registrarAlteracao,
      required this.notificarErro,
      required this.maxCaracteres,
      this.informacaoInicial = '',
      this.corTexto = '#ffffff',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => registrarAlteracao(value),
      initialValue: informacaoInicial,
      obscureText: true,
      maxLength: maxCaracteres,
      style: TextStyle(
        color: HexColor(corTexto), // .withOpacity(0.8),
        fontSize: 20,
      ),
      decoration: InputDecoration(
          labelText: nomeCampo,
          labelStyle: TextStyle(
            color: HexColor(corTexto).withOpacity(0.7),
            //.withOpacity(0.6),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          errorText: notificarErro(),
          errorStyle: TextStyle(
            color: HexColor(corTexto),
          )),
    );
  }
}
