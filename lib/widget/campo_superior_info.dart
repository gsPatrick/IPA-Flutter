import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class CampoSuperiorInfo extends StatelessWidget {
  final String texto, corTexto, corCampo;
  const CampoSuperiorInfo(this.texto, this.corTexto, this.corCampo,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
      alignment: Alignment.center,
      height: alturaPadding * 0.2,
      width: largura * 0.6,
      decoration: BoxDecoration(
        color: HexColor(corCampo),
        borderRadius: BorderRadius.circular(29),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: HexColor(corTexto),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
