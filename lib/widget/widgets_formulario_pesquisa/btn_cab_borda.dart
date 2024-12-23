import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BtnCabBorda extends StatelessWidget {
  final Function() submeter;
  final String titulo;
  final bool formPreenchido;
  final String colorBotao;
  final double larguraBotao;
  final IconData icone;
  const BtnCabBorda(this.submeter, this.titulo, this.formPreenchido,
      this.colorBotao, this.larguraBotao, this.icone,
      {super.key});

  @override
  Widget build(BuildContext context) {
    // double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.1;
    // double larguraBotao = largura * 0.3;
    return ElevatedButton(
      onPressed: formPreenchido ? submeter : () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(larguraBotao, alturaPadding * 0.1),
        onPrimary: Colors.purple,
        // onPrimary: HexColor('#40e0d0'),
        primary: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(alturaPadding * 0.25)),
          side: BorderSide(color: HexColor('#112F47'), width: 2),
        ),
        // padding: EdgeInsets.symmetric(horizontal: -28, vertical: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            titulo,
            style: TextStyle(
                color: HexColor('#112F47'),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            icone,
            color: HexColor('#112F47'),
            size: 25,
          ),
        ],
      ),
    );
  }
}
