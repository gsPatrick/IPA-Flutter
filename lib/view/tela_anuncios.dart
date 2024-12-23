import 'package:app_alug_imovel/controller/controle_adm.dart';
import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/util/rotas_nomeadas.dart';
import 'package:app_alug_imovel/view/tela_perfil_anuncio.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/card_anuncio.dart';
import 'package:app_alug_imovel/widget/filtro_tela_inicial.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/cabecalho_pesquisa_cliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaAnuncios extends StatefulWidget {
  const TelaAnuncios({super.key});

  @override
  State<TelaAnuncios> createState() => _TelaAnunciosState();
}

class _TelaAnunciosState extends State<TelaAnuncios> {
  bool carregando = false;
  ControleAnuncio? controleAnuncio;
  bool pesquisaFeita = false;
  String termoPesquisa = '';

  @override
  void initState() {
    super.initState();
    carregarLista();
  }

  carregarLista() async {
    controleAnuncio = Provider.of<ControleAnuncio>(context, listen: false);
    if (controleAnuncio!.anuncios.isEmpty) {
      print('tamanho da lista : ${controleAnuncio?.anuncios.length}');
      await controleAnuncio!.carregarAnunciosTelaInicial();
    }
  }

  void _campoDialog(
    double altura,
    double alturaPadding,
    double larguraPadding,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Filtro',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: HexColor('#293949'),
          ),
          textAlign: TextAlign.center,
        ),
        content: const FiltroTelaInicial(),
      ),
    );
  }

  void exclusaoAnuncioDialog(
      double largura, List<Anuncio> denuncias, int index, Anuncio anuncio) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Confirmação de exclusão',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Tem certeza que deseja excluir este anúncio ?',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              // onPrimary: HexColor('#40e0d0'),
              primary: Colors.white,
            ),
            child: Text(
              'Voltar',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade900,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: largura * 0.08,
          ),
          ElevatedButton(
            onPressed: () async {
              excluirAnuncio(anuncio, index);

              for (var denuncia in denuncias) {
                if (denuncia.idAnuncio == anuncio.idAnuncio) {
                  excluirDenuncia(denuncia, denuncias.indexOf(denuncia));
                }
              }

              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.red,
              // onPrimary: HexColor('#40e0d0'),
              primary: Colors.red,
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  excluirAnuncio(Anuncio anuncio, int indice) async {
    await Provider.of<ControleAnuncio>(context, listen: false).excluirAnuncio(
        anuncio.idAnunciante!, anuncio.idAnuncio!, indice, true);
  }

  excluirDenuncia(Anuncio anuncio, int indice) async {
    await Provider.of<ControleAdm>(context, listen: false)
        .excluirDenuncia(anuncio.idAnuncio!, indice);
  }

  alterarStatusPesquisa() {
    setState(() {
      pesquisaFeita = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    List<Anuncio> anuncios = Provider.of<ControleAnuncio>(context).anuncios;
    List<Anuncio> denuncias =
        Provider.of<ControleAdm>(context).anunciosDenunciados;
    return Padding(
      padding: EdgeInsets.only(
        top: alturaPadding * 0.025,
        bottom: alturaPadding * 0.025,
        left: larguraPadding * 0.08,
        right: larguraPadding * 0.08,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: larguraPadding * 0.5,
                vertical: alturaPadding * 0.025,
              ),
              child: BotaoFormulario(
                submeter: () {
                  Navigator.of(context).pushNamed(
                    RotasNomeadas.TELAPESQUISAANUNCIO,
                    arguments: {
                      'callback': alterarStatusPesquisa,
                    },
                  );
                },
                titulo: 'Encontrar a melhor opção',
                formPreenchido: true,
                corBotao: '#b2842c',
                tamanhoFonte: 18,
              ),
            ),
            SizedBox(
              height: alturaPadding * 0.05,
            ),
            Container(
              height: altura * 0.75,
              width: largura * 0.95,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: alturaPadding * 0.05,
                      left: larguraPadding * 0.01,
                      right: larguraPadding * 0.01,
                    ),
                    child: CabecalhoPesquisaCliente(
                      pesquisaFeita,
                      pesquisaFeita,
                      false,
                      (value) {
                        setState(() {
                          termoPesquisa = value;
                        });
                      },
                      () {
                        ControleAnuncio contrPesq =
                            Provider.of<ControleAnuncio>(context,
                                listen: false);
                        contrPesq.limparPesquisa();
                        contrPesq.pesquisaIndexAnuncio(termoPesquisa);
                        setState(() {
                          pesquisaFeita = true;
                        });
                      },
                      () {
                        Provider.of<ControleAnuncio>(context, listen: false)
                            .limparPesquisa();
                        setState(() {
                          pesquisaFeita = false;
                        });
                      },
                      () {
                        _campoDialog(altura, alturaPadding, larguraPadding);
                        setState(() {
                          pesquisaFeita = true;
                        });
                      },
                      () {
                        // tratar depois filtragem favoritos
                      },
                      true,
                    ),
                  ),
                  SizedBox(
                    height: pesquisaFeita ? altura * 0.52 : altura * 0.55,
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

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TelaPerfilAnuncio(
                                        anuncio.urlsImg!,
                                        anuncio,
                                      ),
                                    ),
                                  );
                                },
                                child: CardAnuncio(
                                  anuncio,
                                  const ['/mes', '/dia', ''],
                                  ehAdmin: true,
                                  exibirMenu: () {
                                    exclusaoAnuncioDialog(
                                        largura, denuncias, index, anuncio);
                                  },
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
