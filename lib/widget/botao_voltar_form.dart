import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class BotaoVoltarForm extends StatelessWidget {
  final Function() voltar;
  const BotaoVoltarForm(this.voltar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipOval(
        child: Material(
          color: Colors.transparent, // Button color
          child: InkWell(
            splashColor: Colors.amberAccent, // Splash color
            onTap: voltar,
            child: SizedBox(
                width: 46,
                height: 46,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: HexColor('#ffffff'),
                  size: 30,
                )),
          ),
        ),
      ),
    );
  }
}
