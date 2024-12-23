import 'dart:io';

import 'package:app_alug_imovel/widget/btn_form_card.dart';
import 'package:flutter/material.dart';

class CampoFoto extends StatelessWidget {
  final bool naoTemFoto;
  // final File photo;
  final Function() tirarFoto;
  final Function() trocarFoto;
  const CampoFoto(this.naoTemFoto, this.tirarFoto, this.trocarFoto,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
      width: largura,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // _photo == null
          naoTemFoto
              ? Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue.shade800,
                      size: 150,
                    ),
                    SizedBox(
                      width: largura * 0.4,
                      child: BtnForm(
                        submeter: tirarFoto,
                        titulo: 'Adicionar foto',
                        formPreenchido: true,
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: largura * 0.5,
                      width: largura * 0.4,
                      // child: Image.network(
                      //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3lN0PDfr_NQTdj1Q4kR4O7FqH2Ugir9eJng&usqp=CAU',
                      //   height: largura * 0.5,
                      //   width: largura * 0.4,
                      //   fit: BoxFit.cover,
                      // ),
                      child: Image.file(
                        File('ds'),
                        height: largura * 0.5,
                        width: largura * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: alturaPadding * 0.2,
                    ),
                    SizedBox(
                      width: largura * 0.4,
                      child: BtnForm(
                        submeter: trocarFoto,
                        titulo: 'Adicionar foto',
                        formPreenchido: true,
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
