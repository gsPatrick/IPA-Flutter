import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class FormPesquisa extends StatelessWidget {
  final String? labelText;
  final Function(String value) onchanged;
  final Function() callBackErrorText;
  final Function() pesquisar;
  final int? maxCaracteres;
  final int? maxLines;
  final bool? editavel;
  final String? nomeEditavel;
  const FormPesquisa(this.labelText, this.onchanged, this.callBackErrorText,
      this.pesquisar, this.maxCaracteres, this.maxLines,
      {this.editavel = false, this.nomeEditavel = '', super.key});

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
        counterStyle: const TextStyle(color: Colors.transparent),
        labelStyle: TextStyle(
          color: HexColor('#112F47'),
          fontSize: 20,
        ),
        suffixIcon: IconButton(
          onPressed: pesquisar,
          icon: const Icon(
            Icons.search,
            size: 27,
          ), // Ícone de lupa
        ),
        // floatingLabelStyle: TextStyle(color: Colors.purple), serve para alterar a cor quando selecionado
        // enabledBorder: Borde,
        focusedBorder: OutlineInputBorder(
            // borda selecionada para imput
            borderRadius: const BorderRadius.all(
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
