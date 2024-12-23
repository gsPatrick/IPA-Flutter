import 'package:app_alug_imovel/controller/controle_adm.dart';
import 'package:app_alug_imovel/model/anunciante.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/widgets_admin/menu_botoes.dart';
import 'package:app_alug_imovel/widget/widgets_admin/tabela_anunciantes.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/btn_pesquisa.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/form_pesquisa.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaAnunciantes extends StatefulWidget {
  const TelaAnunciantes({super.key});

  @override
  State<TelaAnunciantes> createState() => _TelaAnunciantesState();
}

class _TelaAnunciantesState extends State<TelaAnunciantes> {
  ControleAdm? controleAdm;
  bool pesquisaFeita = false;
  String termoPesquisa = '';

  void _menupopup(
      int index, Anunciante usuario, double largura, alturaPadding, altura) {
    controleAdm = Provider.of<ControleAdm>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: SizedBox(
          width: largura * 0.9,
          height: alturaPadding * 0.25,
          child: AutoSizeText(
            usuario.nome!,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.w700,
              fontSize: 21,
            ),
            maxLines: 2,
          ),
        ),
        content: MenuBotoes(controleAdm!, usuario, index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.1;
    List<Anunciante> anunciantes =
        Provider.of<ControleAdm>(context).anunciantes;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: larguraPadding * 0.1,
        vertical: alturaPadding * 0.025,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            height: altura * 0.9,
            width: largura * 0.98,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
            ),
            child: Column(
              children: [
                Container(
                  // color: Colors.red,

                  alignment: Alignment.topCenter,
                  height: altura * 0.102,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: altura * 0.102,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: alturaPadding * 0.1,
                            left: larguraPadding * 0.1,
                          ),
                          child: SizedBox(
                            width: largura * 0.6,
                            height: alturaPadding * 0.4,
                            child: FormPesquisa(
                                'Pesquisar ',
                                (value) {
                                  setState(() {
                                    termoPesquisa = value;
                                  });
                                },
                                () {},
                                () {
                                  Provider.of<ControleAdm>(context,
                                          listen: false)
                                      .pesquisaIndexAnuncio(termoPesquisa);
                                  setState(() {
                                    pesquisaFeita = true;
                                    //mudar status para pesquisafeita igual a true
                                  });
                                },
                                30,
                                1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: alturaPadding * 0.1),
                        child: BtnPesquisa(() {
                          Provider.of<ControleAdm>(context, listen: false)
                              .pesquisaIndexAnuncio(termoPesquisa);
                          setState(() {
                            pesquisaFeita = true;
                            //mudar status para pesquisafeita igual a true
                          });
                        }, 'Pesquisar', true, '#538292'),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: alturaPadding * 0.05,
                      horizontal: larguraPadding * 0.2),
                  child: pesquisaFeita
                      ? Container(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                pesquisaFeita = false;
                              });
                              Provider.of<ControleAdm>(context, listen: false)
                                  .limparPesquisa();
                            },
                            child: Text(
                              'Limpar pesquisa',
                              style: TextStyle(
                                color: HexColor('#293949'),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 1,
                        ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      TabelaAnunciantes(
                        anunciantes,
                        (indice, anunciante, largura, alturaPadding, altura) {
                          _menupopup(indice, anunciante, largura, alturaPadding,
                              altura);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
