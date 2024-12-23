import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardFormEdit extends StatelessWidget {
  final IconData icone;
  final String texto;
  final Function() redirecionar;
  const CardFormEdit(this.icone, this.texto, this.redirecionar, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2.0, color: HexColor('#293949')),
        ),
        color: Colors.white,
        child: Container(
          height: alturaPadding * 0.75,
          width: largura * 0.8,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icone,
                size: larguraPadding,
                color: HexColor('#293949'),
              ),
              const SizedBox(
                width: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: alturaPadding * 0.025),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      texto,
                      style: TextStyle(
                        color: HexColor('#293949'),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: redirecionar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF57C00),
                        fixedSize: Size(largura * 0.35, alturaPadding * 0.2),
                        padding: EdgeInsets.symmetric(
                          horizontal: larguraPadding * 0.1,
                          vertical: alturaPadding * 0.025,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Editar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
