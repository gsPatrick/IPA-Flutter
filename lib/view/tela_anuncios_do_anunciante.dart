import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:app_alug_imovel/widget/card_anuncio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaAnuncAnunciante extends StatefulWidget {
  final String idAnunciante;
  const TelaAnuncAnunciante(this.idAnunciante, {super.key});

  @override
  State<TelaAnuncAnunciante> createState() => _TelaAnuncAnuncianteState();
}

class _TelaAnuncAnuncianteState extends State<TelaAnuncAnunciante> {
  List<Anuncio> anuncios = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarAnuncios();
  }

  carregarAnuncios() async {
    // ControleAuth controleAut = Provider.of(context, listen: false);
    print('teste 1');
    await Provider.of<ControleAnuncio>(context, listen: false)
        .carregarPropriosAnuncios(widget.idAnunciante);
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    anuncios = Provider.of<ControleAnuncio>(context).anunciosProprios;

    return Scaffold(
      backgroundColor: HexColor('#273949'),
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(
            top: alturaPadding * 0.1,
            left: larguraPadding * 0.2,
          ),
          child: const BotaoRetorno(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: alturaPadding * 0.1,
          bottom: alturaPadding * 0.05,
          left: largura * 0.025,
          right: largura * 0.025,
        ),
        child: Container(
          height: altura * 0.85,
          width: largura * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(29),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: alturaPadding * 0.1),
                  child: Text(
                    'Imóveis anunciados: ',
                    style: TextStyle(
                      color: HexColor('#293949'),
                      //  const Color.fromARGB(255, 1, 36, 65),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  height: altura * 0.8,
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

                            return CardAnuncio(anuncio, ['/mes', '/dia', '']);
                          }),
                        ),
                      ],
                    ),
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
