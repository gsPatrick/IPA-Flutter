import 'package:app_alug_imovel/controller/controle_adm.dart';
import 'package:app_alug_imovel/model/anunciante.dart';
import 'package:app_alug_imovel/view/tela_anuncios_do_anunciante.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MenuBotoes extends StatelessWidget {
  final ControleAdm controleAdm;
  final Anunciante usuario;
  final int index;
  const MenuBotoes(this.controleAdm, this.usuario, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;

    return SizedBox(
      height: altura * 0.45,
      width: largura * 0.9,
      child: Column(
        children: [
          SizedBox(
            height: altura * 0.3,
            width: largura * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                retornarBotao(() async {
                  await controleAdm.renovarPrazo(usuario, index);
                  Navigator.of(context).pop();
                }, 'Renovar', largura, alturaPadding),
                retornarBotao(() async {
                  await controleAdm.desativarPerfilAnunciante(usuario, index);
                  Navigator.of(context).pop();
                }, 'Desativar', largura, alturaPadding),
                retornarBotao(() async {
                  controleAdm.anunciantes.removeAt(index);
                  // setState(() {
                  //   controleAdm.anunciantes.removeAt(index);
                  // });
                  await controleAdm.excluirPerfilAnunciante(usuario, index);
                  Navigator.of(context).pop();
                }, 'Excluir', largura, alturaPadding),
                retornarBotao(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TelaAnuncAnunciante(usuario.idAnunciante!),
                    ),
                  );
                }, 'Ver anúncios', largura, alturaPadding),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: alturaPadding * 0.3),
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
