import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/view/tela_anuncio_edit.dart';
import 'package:app_alug_imovel/view/tela_perfil_anuncio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuConfigAnuncio extends StatelessWidget {
  // final ControleAdm controleAdm;
  final Anuncio anuncio;
  final int index;
  const MenuConfigAnuncio(this.anuncio, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    return SizedBox(
      height: altura * 0.3,
      width: largura * 0.9,
      child: Column(
        children: [
          SizedBox(
            height: altura * 0.2,
            width: largura * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                retornarBotao(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TelaPerfilAnuncio(anuncio.urlsImg!, anuncio),
                    ),
                  );
                }, 'Visualizar', largura, alturaPadding),
                retornarBotao(() {
                  // await controleAdm.renovarPrazo(usuario, index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaAnuncioEdit(anuncio),
                    ),
                  );
                  // Navigator.of(context).pop();
                }, 'Editar', largura, alturaPadding),
                retornarBotao(() async {
                  // await controleAdm.desativarPerfilAnunciante(usuario, index);
                  await Provider.of<ControleAnuncio>(context, listen: false)
                      .excluirAnuncio(anuncio.idAnunciante!, anuncio.idAnuncio!,
                          index, false);
                  Navigator.of(context).pop();
                }, 'Excluir', largura, alturaPadding),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: alturaPadding * 0.1),
            child: SizedBox(
              height: alturaPadding * 0.22,
              width: largura * 0.4,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.red,
                  // onPrimary: HexColor('#40e0d0'),
                  primary: Colors.red,
                ),
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget retornarBotao(
      Function() funcao, String tituloBotao, double largura, alturaPadding) {
    return ElevatedButton(
      onPressed: funcao,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(largura * 0.5, alturaPadding * 0.2),
        onPrimary: Colors.white,
        // onPrimary: HexColor('#40e0d0'),
        primary: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          side: BorderSide(
            color: Colors.blueGrey.shade900,
            width: 2,
          ),
        ),
      ),
      child: AutoSizeText(
        tituloBotao,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey.shade800,
          fontSize: 20,
        ),
      ),
    );
  }
}
