import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class CampoFormTexto extends StatelessWidget {
  final String? labelText;
  final Function(String value) onchanged;
  final Function() callBackErrorText;
  final int? maxCaracteres;
  final int? maxLines;
  final bool? editavel;
  final String? nomeEditavel;

  const CampoFormTexto(
      {required this.labelText,
      required this.onchanged,
      required this.callBackErrorText,
      required this.maxCaracteres,
      required this.maxLines,
      this.editavel = false,
      this.nomeEditavel = '',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: HexColor('#112F47'),
        fontSize: 20,
      ),
      onChanged: (value) => onchanged(value),
      initialValue: nomeEditavel,
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
        labelText: labelText,
        errorText: callBackErrorText(),
        errorStyle: TextStyle(
          color: HexColor('#E4572E'),
        ),
      ),
      maxLength: maxCaracteres,
      maxLines: maxLines,
    );
  }
}
