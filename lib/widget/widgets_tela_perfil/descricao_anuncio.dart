import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DescricaoAnuncio extends StatelessWidget {
  final String descricao;
  const DescricaoAnuncio(this.descricao, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: alturaPadding * 0.1,
              bottom: alturaPadding * 0.05,
            ),
            child: Text(
              'Descrição',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: largura * 0.25,
            width: largura * 0.9,
            color: Colors.grey.shade200,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  descricao,
                  // widget.anuncio.descricao!,
                  minFontSize: 17,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
