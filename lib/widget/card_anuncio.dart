import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardAnuncio extends StatelessWidget {
  final Anuncio anuncio;
  final List<String> opcoesValor;
  final bool ehAdmin;
  final Function() exibirMenu;

  const CardAnuncio(this.anuncio, this.opcoesValor,
      {this.ehAdmin = false, this.exibirMenu = _funcaoDefault, super.key});
  static void _funcaoDefault() {
    // Aqui você pode definir o comportamento padrão da função
    print('Excluindo anúncio...');
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Padding(
      padding: EdgeInsets.only(bottom: alturaPadding * 0.05),
      child: SizedBox(
        // color: Colors.amber.shade100,
        height: largura * 0.35,
        width: largura * 0.9,
        child: Row(
          children: [
            SizedBox(
              width: ehAdmin ? largura * 0.75 : largura * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: alturaPadding * 0.025),
                    height: ehAdmin ? largura * 0.3 : largura * 0.35,
                    width: ehAdmin ? largura * 0.3 : largura * 0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        anuncio.urlImgPesquisa!,
                        height: ehAdmin ? largura * 0.3 : largura * 0.35,
                        width: ehAdmin ? largura * 0.3 : largura * 0.35,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ehAdmin ? largura * 0.45 : largura * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: larguraPadding * 0.05,
                          ),
                          child: AutoSizeText(
                            anuncio.titulo!,
                            style: TextStyle(
                              color: HexColor('#293949'),
                              //  const Color.fromARGB(255, 1, 36, 65),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: larguraPadding * 0.2,
                          ),
                          child: AutoSizeText(
                            'R\$ ${anuncio.valor}0${opcoesValor[anuncio.opcaoValor!]}',
                            style: TextStyle(
                              color: HexColor('#b2852b'),
                              //  const Color.fromARGB(255, 1, 36, 65),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: larguraPadding * 0.2,
                          ),
                          child: AutoSizeText(
                            anuncio.descricao!,
                            minFontSize: 14,
                            style: TextStyle(
                              color: HexColor('#293949'),
                              //  const Color.fromARGB(255, 1, 36, 65),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: larguraPadding * 0.05,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: HexColor('#293949'),
                              ),
                              AutoSizeText(
                                '${anuncio.bairro}, ${anuncio.cidade}',
                                style: TextStyle(
                                  color: HexColor('#293949'),
                                  //  const Color.fromARGB(255, 1, 36, 65),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
            ehAdmin
                ? InkWell(
                    onTap: exibirMenu,
                    child: SizedBox(
                      width: largura * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: largura * 0.15,
                            child: const VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                              width: 3,
                            ),
                          ),
                          SizedBox(
                            width: largura * 0.05,
                            child: Center(
                              child: Icon(
                                Icons.settings,
                                size: 30,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),

                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     SizedBox(
                          //       width: largura * 0.05,
                          //       child: const Center(
                          //         child: Icon(
                          //           Icons.edit,
                          //           size: 30,
                          //           color: Colors.orange,
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: largura * 0.05,
                          //       child: const Center(
                          //         child: Icon(
                          //           Icons.delete,
                          //           size: 30,
                          //           color: Colors.red,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    width: 1,
                  ),
          ],
        ),
      ),
    );
  }
}
