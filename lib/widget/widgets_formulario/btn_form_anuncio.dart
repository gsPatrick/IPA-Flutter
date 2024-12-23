import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BtnFormAnuncio extends StatelessWidget {
  final Function() submeter;
  final String titulo;
  final bool formPreenchido;
  final String corBotao;
  final double tamanhoFonte;

  const BtnFormAnuncio(
      {required this.submeter,
      required this.titulo,
      required this.formPreenchido,
      required this.corBotao,
      this.tamanhoFonte = 16,
      super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    return ElevatedButton(
      onPressed: formPreenchido ? submeter : () {},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(largura * 0.4, alturaPadding * 0.25),
        onPrimary: Colors.purple,
        // onPrimary: HexColor('#40e0d0'),
        primary: formPreenchido ? HexColor(corBotao) : Colors.grey,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
        ),
      ),
      child: AutoSizeText(
        titulo,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: tamanhoFonte,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
