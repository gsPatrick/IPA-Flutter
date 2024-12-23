import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BtnTranspBorda extends StatelessWidget {
  final Function() submeter;
  final String titulo;
  final bool formPreenchido;
  final String corBotao;
  final String corBorda;
  final double tamanhoFonte;
  final String corTexto;

  const BtnTranspBorda(
      {required this.submeter,
      required this.titulo,
      required this.formPreenchido,
      required this.corBotao,
      this.tamanhoFonte = 16,
      required this.corBorda,
      this.corTexto = '#ffffff',
      super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    return ElevatedButton(
      onPressed: formPreenchido ? submeter : () {},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(largura * 0.9, alturaPadding * 0.25),
        onPrimary: Colors.amber,
        // onPrimary: HexColor('#40e0d0'),
        primary: formPreenchido ? HexColor(corBotao) : Colors.grey,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(29)),
        ),
        // backgroundColor: Colors.red, cor do botao
        // foregroundColor: Colors.amber, cor apos clicar
        side: BorderSide(color: HexColor(corBorda), width: 2.5),
      ),
      child: AutoSizeText(
        titulo,
        style: TextStyle(
          color: HexColor(corTexto),
          fontWeight: FontWeight.w900,
          fontSize: tamanhoFonte,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
