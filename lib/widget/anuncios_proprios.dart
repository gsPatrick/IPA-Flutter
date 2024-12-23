import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/card_anuncio.dart';
import 'package:flutter/material.dart';

class AnunciosProprios extends StatelessWidget {
  final List<Anuncio> anuncios;
  final Function() adicionar;
  final Function(Anuncio anuncio, int value) exibirMenu;

  const AnunciosProprios(this.anuncios, this.adicionar, this.exibirMenu,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: altura * 0.7,
      width: largura * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: alturaPadding * 0.1),
            child: Text(
              'Seus imóveis anunciados: ',
              style: TextStyle(
                color: HexColor('#293949'),
                //  const Color.fromARGB(255, 1, 36, 65),
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          anuncios.isEmpty
              ? Center(
                  child: Text(
                    'Você ainda não cadastrou \n nenhum imóvel',
                    style: TextStyle(
                      color: HexColor('#293949'),
                      //  const Color.fromARGB(255, 1, 36, 65),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(
                  height: altura * 0.55,
                  width: largura * 0.9,
                  // color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: anuncios.length,
                          itemBuilder: ((context, index) {
                            Anuncio anuncio = anuncios[index];

                            return CardAnuncio(
                              anuncio,
                              const ['/mes', '/dia', ''],
                              ehAdmin: true,
                              exibirMenu: () {
                                exibirMenu(anuncios[index], index);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: larguraPadding * 0.5,
              vertical: alturaPadding * 0.05,
            ),
            child: BotaoFormulario(
              submeter: adicionar,
              titulo: 'Adicionar',
              formPreenchido: true,
              corBotao: '#b2852b',
            ),
          )
        ],
      ),
    );
  }
}
