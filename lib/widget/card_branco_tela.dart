import 'package:flutter/material.dart';

class CardBrancoTela extends StatelessWidget {
  final String tituloCard;
  final double alturaCard, larguraCard;
  Widget corpoCard;
  Widget botoesCard;

  CardBrancoTela(this.tituloCard, this.alturaCard, this.larguraCard,
      this.corpoCard, this.botoesCard,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
      height: alturaCard,
      width: larguraCard,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        children: [
          Text(tituloCard),
          corpoCard,
          botoesCard,
        ],
      ),
    );
  }
}
