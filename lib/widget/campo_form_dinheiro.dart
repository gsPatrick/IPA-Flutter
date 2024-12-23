import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CampoFormDinheiro extends StatelessWidget {
  final String? nomeCampo;
  final Function(String value) registrarAlteracao;
  final Function() notificarErro;
  final int? maxCaracteres;
  final String? informacaoInicial;
  const CampoFormDinheiro(
      {required this.nomeCampo,
      required this.registrarAlteracao,
      required this.notificarErro,
      required this.maxCaracteres,
      this.informacaoInicial = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
      mask: 'R\$ ##,###.###',
      filter: {"#": RegExp(r'[0-9]')},
      initialText: informacaoInicial,
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      onChanged: (value) => registrarAlteracao(value),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyPtBrInputFormatter(),
      ],
      initialValue: informacaoInicial,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: HexColor('#112F47'),
        fontSize: 20,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: HexColor('#112F47'),
          fontSize: 20,
        ),
        // floatingLabelStyle: TextStyle(color: Colors.purple), serve para alterar a cor quando selecionado
        // enabledBorder: Borde,
        focusedBorder: OutlineInputBorder(
            // borda selecionada para imput
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(
              color: HexColor('#25AC26'),
              width: 2.0,
            )),
        enabledBorder: OutlineInputBorder(
          //  borda nao selecionada para imput
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: HexColor('#112F47'),
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          //  borda nao selecionada para imput
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: HexColor('#E4572E'),
            width: 2.0,
          ),
        ),
        // disabledBorder: InputBorder.none,
        focusedErrorBorder: OutlineInputBorder(
          //  borda nao selecionada para imput
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(
            color: HexColor('#E4572E'),
            width: 2.0,
          ),
        ),
        labelText: nomeCampo,
        errorText: notificarErro(),
        errorStyle: TextStyle(
          color: HexColor('#E4572E'),
        ),
      ),
    );
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
