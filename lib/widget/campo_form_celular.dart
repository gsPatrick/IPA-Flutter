import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CampoFormCelular extends StatelessWidget {
  final String? nomeCampo;
  final Function(String value) registrarAlteracao;
  final Function() notificarErro;
  final int? maxCaracteres;
  final String? informacaoInicial;
  const CampoFormCelular(
      {required this.nomeCampo,
      required this.registrarAlteracao,
      required this.notificarErro,
      required this.maxCaracteres,
      this.informacaoInicial = '',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        initialText: informacaoInicial,
        type: MaskAutoCompletionType.lazy);

    return TextFormField(
      onChanged: (value) => registrarAlteracao(value),
      inputFormatters: [maskFormatter],
      initialValue: informacaoInicial,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: HexColor('#112F47'),
        fontSize: 20,
      ),
      decoration: InputDecoration(
          labelText: nomeCampo,
          labelStyle: TextStyle(
              color: HexColor('#112F47'),
              fontSize: 22,
              fontWeight: FontWeight.w600),
          errorText: notificarErro(),
          errorStyle: TextStyle(
            color: HexColor('#E4572E'),
          )),
    );
  }
}
