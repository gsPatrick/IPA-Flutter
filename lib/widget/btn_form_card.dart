import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BtnForm extends StatelessWidget {
  final Function() submeter;
  final String titulo;
  final bool formPreenchido;
  final String colorBotao;
  final bool ehEcoponto;
  const BtnForm(
      {required this.submeter,
      required this.titulo,
      required this.formPreenchido,
      this.colorBotao = '#25AC26',
      this.ehEcoponto = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.1;
    double larguraBotao = largura * 0.4;
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
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.add_a_photo,
            color: Colors.white,
          ),
          AutoSizeText(
            titulo,
            style: const TextStyle(color: Colors.white, fontSize: 18),
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
