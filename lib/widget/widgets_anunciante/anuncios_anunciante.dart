import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/rotas_nomeadas.dart';
import 'package:app_alug_imovel/widget/anuncios_proprios.dart';
import 'package:app_alug_imovel/widget/widgets_anunciante/menu_config_anuncio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnunciosAnunciante extends StatelessWidget {
  final List<Anuncio> anuncios;
  final Function(Anuncio anuncio, int indice) exibirMenu;
  const AnunciosAnunciante(this.anuncios, this.exibirMenu, {super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    return AnunciosProprios(
      anuncios,
      () {
        print('funcao acionada');
        Navigator.of(context).pushNamed(RotasNomeadas.TELACADASTROANUNCIO);
      },
      (anuncio, indice) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            title: SizedBox(
              width: largura * 0.9,
              height: alturaPadding * 0.2,
              child: AutoSizeText(
                anuncio.titulo!,
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            content: MenuConfigAnuncio(anuncio, indice),
            // MenuBotoes(controleAdm!, usuario, index),
          ),
        );
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     backgroundColor: Colors.white,
        //     title: const Text(
        //       'Confirmação de exclusão',
        //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        //     ),
        //     content: const Text(
        //       'Tem certeza que deseja excluir este anúncio ?',
        //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        //     ),
        //     actions: <Widget>[
        //       ElevatedButton(
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //         style: ElevatedButton.styleFrom(
        //           onPrimary: Colors.white,
        //           // onPrimary: HexColor('#40e0d0'),
        //           primary: Colors.white,
        //         ),
        //         child: Text(
        //           'Voltar',
        //           style: TextStyle(
        //             fontWeight: FontWeight.w600,
        //             color: Colors.blueGrey.shade900,
        //             fontSize: 18,
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         width: largura * 0.08,
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           exibirMenu(anuncio, indice);

        //           // ignore: use_build_context_synchronously
        //           Navigator.of(context).pop();
        //         },
        //         style: ElevatedButton.styleFrom(
        //           onPrimary: Colors.red,
        //           // onPrimary: HexColor('#40e0d0'),
        //           primary: Colors.red,
        //         ),
        //         child: const Text(
        //           'Continuar',
        //           style: TextStyle(
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white,
        //             fontSize: 18,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }
}
