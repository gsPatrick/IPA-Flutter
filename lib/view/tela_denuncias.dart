import 'package:app_alug_imovel/controller/controle_adm.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaDenuncias extends StatefulWidget {
  const TelaDenuncias({super.key});

  @override
  State<TelaDenuncias> createState() => _TelaDenunciasState();
}

class _TelaDenunciasState extends State<TelaDenuncias> {
  @override
  void initState() {
    super.initState();
    carregarDenuncias();
  }

  carregarDenuncias() async {
    await Provider.of<ControleAdm>(context, listen: false).carregarDenuncias();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.1;
    List<Anuncio> denuncias =
        Provider.of<ControleAdm>(context).anunciosDenunciados;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: larguraPadding * 0.25,
        vertical: alturaPadding * 0.025,
      ),
      child: Center(
        child: Container(
          height: altura * 0.9,
          width: largura * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(29),
          ),
          child: SizedBox(
            height: altura * 0.7,
            width: largura * 0.9,
            // color: Colors.grey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: denuncias.length,
                    itemBuilder: ((context, index) {
                      Anuncio denuncia = denuncias[index];

                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(top: alturaPadding * 0.05),
                          child: SizedBox(
                            // color: Colors.amber.shade100,
                            height: largura * 0.35,
                            width: largura * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: alturaPadding * 0.05),
                                  child: SizedBox(
                                    height: largura * 0.25,
                                    width: largura * 0.25,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        denuncia.urlImgPesquisa!,
                                        height: largura * 0.2,
                                        width: largura * 0.2,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: largura * 0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        denuncia.titulo!,
                                        style: TextStyle(
                                          color: HexColor('#293949'),
                                          //  const Color.fromARGB(255, 1, 36, 65),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      AutoSizeText(
                                        '${denuncia.mensagemDenuncia}',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          //  const Color.fromARGB(255, 1, 36, 65),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
