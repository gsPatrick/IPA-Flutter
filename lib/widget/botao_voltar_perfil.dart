import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class BotaoVoltarPerfil extends StatelessWidget {
  final Function() retornar;
  const BotaoVoltarPerfil(this.retornar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        splashColor: Colors.amberAccent, // Splash color
        onTap: retornar,

        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: HexColor('#293949'),
            size: 40,
          ),
        ),
      ),
    );
  }
}
