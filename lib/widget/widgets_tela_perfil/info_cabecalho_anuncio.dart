import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class InfoCabecalhoImovel extends StatelessWidget {
  final List<String> opcoesValor = ['/mes', '/dia', ''];
  final Anuncio anuncio;
  final bool ehFavorito;
  final bool clienteLogado;
  final Function() favoritar;
  final bool ehCliente;
  InfoCabecalhoImovel(
      this.anuncio, this.ehFavorito, this.favoritar, this.clienteLogado,
      {this.ehCliente = false, super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    // double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
          left: larguraPadding * 0.25, right: larguraPadding * 0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                anuncio.titulo!,
                style: TextStyle(
                  color: HexColor('#293949'),
                  //  const Color.fromARGB(255, 1, 36, 65),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              AutoSizeText(
                'R\$ ${anuncio.valor}0${opcoesValor[anuncio.opcaoValor!]}',
                style: TextStyle(
                  color: HexColor('#b2852b'),
                  //  const Color.fromARGB(255, 1, 36, 65),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
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
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          (clienteLogado || ehCliente)
              ? InkWell(
                  onTap: favoritar,
                  child: Column(
                    children: [
                      ehFavorito
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 40,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: HexColor('#293949'),
                              size: 40,
                            ),
                      AutoSizeText(
                        'Salvar',
                        style: TextStyle(
                          color: HexColor('#293949'),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }
}
