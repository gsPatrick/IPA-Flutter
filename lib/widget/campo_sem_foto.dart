import 'package:app_alug_imovel/widget/btn_form_card.dart';
import 'package:flutter/material.dart';

class CampoSemFoto extends StatelessWidget {
  final Function() tirarFoto;
  const CampoSemFoto(this.tirarFoto, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: alturaPadding * 0.1, horizontal: larguraPaddinfg * 0.3),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.blueGrey.shade700,
                size: 85,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueGrey.shade600,
                    width: 4.0,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.transparent,
                  size: 85,
                ),
              ),
            ],
          ),
          SizedBox(
            width: larguraPaddinfg * 0.25,
          ),
          SizedBox(
            width: largura * 0.3,
            child: BtnForm(
              colorBotao: '#57697d',
              submeter: tirarFoto,
              titulo: 'Foto',
              formPreenchido: true,
            ),
          )
        ],
      ),
    );
  }
}
