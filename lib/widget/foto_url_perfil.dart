import 'package:app_alug_imovel/widget/btn_form_card.dart';
import 'package:flutter/material.dart';

class FotoUrlPerfil extends StatelessWidget {
  final Function() trocarFoto;
  final String urlFoto;

  const FotoUrlPerfil(this.trocarFoto, this.urlFoto, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
      child: Row(
        children: [
          Container(
            height: largura * 0.4,
            width: largura * 0.4,
            // child: Image.network(
            //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3lN0PDfr_NQTdj1Q4kR4O7FqH2Ugir9eJng&usqp=CAU',
            //   height: largura * 0.5,
            //   width: largura * 0.4,
            //   fit: BoxFit.cover,
            // ),
            child: Image.network(
              urlFoto,
              height: largura * 0.2,
              width: largura * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: larguraPaddinfg * 0.2,
          ),
          SizedBox(
            width: largura * 0.3,
            child: BtnForm(
              colorBotao: '#57697d',
              submeter: trocarFoto,
              titulo: 'Foto',
              formPreenchido: true,
            ),
          )
        ],
      ),
    );
  }
}
