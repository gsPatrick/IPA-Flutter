import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CabecalhoForm extends StatelessWidget {
  final String titulo, corTexto;
  final double tamanhoFonte;
  const CabecalhoForm(this.titulo,
      {this.corTexto = '', this.tamanhoFonte = 18, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AutoSizeText(
        titulo,
        minFontSize: 16,
        style: TextStyle(
          fontSize: tamanhoFonte,
          fontWeight: FontWeight.w800,
          color: HexColor(corTexto),
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }
}
