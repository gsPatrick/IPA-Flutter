import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/view/tela_perfil_anuncio.dart';
import 'package:app_alug_imovel/widget/card_anuncio.dart';
import 'package:flutter/material.dart';

class ListaAnuncioCliente extends StatelessWidget {
  final bool pesquisaFeita, estaFiltrando, apenasFavoritados;
  final List<Anuncio> anuncios;
  const ListaAnuncioCliente(this.pesquisaFeita, this.estaFiltrando,
      this.anuncios, this.apenasFavoritados,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: (pesquisaFeita || estaFiltrando || apenasFavoritados)
          ? altura * 0.5
          : altura * 0.56,
      width: largura * 0.95,
      // color: Colors.grey,
      child: SingleChildScrollView(
        child: apenasFavoritados
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: anuncios.length,
                itemBuilder: ((context, index) {
                  Anuncio anuncio = anuncios[index];

                  return anuncio.ehFavorito
                      ? Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TelaPerfilAnuncio(
                                    anuncio.urlsImg!,
                                    anuncio,
                                    ehCliente: true,
                                  ),
                                ),
                              );
                            },
                            child: CardAnuncio(
                              anuncio,
                              ['/mês', '/dia', ''],
                            ),
                          ),
                        )
                      : const SizedBox();
                }),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: anuncios.length,
                itemBuilder: ((context, index) {
                  Anuncio anuncio = anuncios[index];

                  return Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaPerfilAnuncio(
                              anuncio.urlsImg!,
                              anuncio,
                              ehCliente: true,
                            ),
                          ),
                        );
                      },
                      child: CardAnuncio(
                        anuncio,
                        ['/mês', '/dia', ''],
                      ),
                    ),
                  );
                }),
              ),
      ),
    );
  }
}
