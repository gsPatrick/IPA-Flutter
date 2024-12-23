import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BtnSalvarAnunc extends StatelessWidget {
  final Function() submeter;
  final String titulo;
  final bool formPreenchido;
  final String colorBotao;
  const BtnSalvarAnunc(
      this.submeter, this.titulo, this.formPreenchido, this.colorBotao,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.1;
    double larguraBotao = largura * 0.3;
    return ElevatedButton(
      onPressed: formPreenchido ? submeter : () {},
      style: ElevatedButton.styleFrom(
        fixedSize: Size(larguraBotao, alturaPadding * 0.1),
        onPrimary: Colors.purple,
        // onPrimary: HexColor('#40e0d0'),
        primary: formPreenchido
            ? HexColor(colorBotao).withOpacity(0.9)
            : Colors.grey,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AutoSizeText(
            titulo,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
        ],
      ),

      // AutoSizeText(
      //   titulo,
      //   style: const TextStyle(color: Colors.white, fontSize: 17),
      // ),
    );
  }
}
