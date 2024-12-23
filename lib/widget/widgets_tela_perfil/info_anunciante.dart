import 'package:app_alug_imovel/widget/campo_superior_info.dart';
import 'package:flutter/material.dart';

class InfoAnunciante extends StatelessWidget {
  final String nomeAnunciante, contatoAnunciante, urlImgAnunciante;
  const InfoAnunciante(
      this.nomeAnunciante, this.contatoAnunciante, this.urlImgAnunciante,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: alturaPadding * 0.15),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: alturaPadding * 0.1,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Informações do vendedor:',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CampoSuperiorInfo(nomeAnunciante, '#ffffff', '#57697d'),
                  SizedBox(
                    height: alturaPadding * 0.1,
                  ),
                  CampoSuperiorInfo(contatoAnunciante, '#ffffff', '#57697d'),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: larguraPadding * 0.7,
                      backgroundImage: NetworkImage(
                        urlImgAnunciante,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
