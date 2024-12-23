import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotaoRetorno extends StatelessWidget {
  final bool apagarLista;
  const BotaoRetorno({this.apagarLista = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipOval(
        child: Material(
          color: Colors.transparent, // Button color
          child: InkWell(
            splashColor: Colors.amberAccent, // Splash color
            onTap: () {
              if (apagarLista) {
                Provider.of<ControleAnuncio>(context, listen: false)
                    .sairSessao();
              }
              Navigator.maybePop(context);
            },
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
