import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/btn_cab_borda.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/btn_pesquisa.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/form_pesquisa.dart';
import 'package:flutter/material.dart';

class CabecalhoPesquisaCliente extends StatelessWidget {
  final bool pesquisaFeita, estaFiltrando, apenasFavoritados, ehAdmin;
  final Function(String termo) armazenarTermo;
  final Function() realizarPesquisa,
      limparPesquisa,
      filtrarAnuncios,
      filtrarFavoritos;
  const CabecalhoPesquisaCliente(
      this.pesquisaFeita,
      this.estaFiltrando,
      this.apenasFavoritados,
      this.armazenarTermo,
      this.realizarPesquisa,
      this.limparPesquisa,
      this.filtrarAnuncios,
      this.filtrarFavoritos,
      this.ehAdmin,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // color: Colors.red,

          alignment: Alignment.topCenter,
          height: (pesquisaFeita ||
                  estaFiltrando ||
                  (apenasFavoritados && !ehAdmin))
              ? altura * 0.102
              : altura * 0.102,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: (pesquisaFeita ||
                        estaFiltrando ||
                        (apenasFavoritados && !ehAdmin))
                    ? altura * 0.102
                    : altura * 0.102,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: alturaPadding * 0.1,
                    left: larguraPadding * 0.1,
                  ),
                  child: SizedBox(
                    width: largura * 0.6,
                    height: alturaPadding * 0.4,
                    child: FormPesquisa('Pesquisar ', (value) {
                      armazenarTermo(value);
                    }, () {}, realizarPesquisa, 30, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: alturaPadding * 0.1),
                child:
                    BtnPesquisa(realizarPesquisa, 'Pesquisar', true, '#538292'),
              )
            ],
          ),
        ),
        Container(
          // color: Colors.green,
          alignment: Alignment.topLeft,
          width: largura,
          height: alturaPadding * 0.25,
          child: Padding(
            padding: EdgeInsets.only(left: larguraPadding * 0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BtnCabBorda(filtrarAnuncios, 'Filtrar', true, '#538292',
                    largura * 0.25, Icons.filter_alt_outlined),
                SizedBox(
                  width: larguraPadding * 0.2,
                ),
                ehAdmin
                    ? const SizedBox(
                        height: 1,
                      )
                    : BtnCabBorda(filtrarFavoritos, 'Anúncios Salvos', true,
                        '#538292', largura * 0.5, Icons.favorite_border),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: alturaPadding * 0.05, horizontal: larguraPadding * 0.2),
          child: (pesquisaFeita || estaFiltrando || apenasFavoritados)
              ? Container(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: limparPesquisa,
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
      ],
    );
  }
}
