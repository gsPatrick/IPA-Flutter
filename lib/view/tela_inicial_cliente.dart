import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/util/rotas_nomeadas.dart';
import 'package:app_alug_imovel/view/tela_inicial.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:app_alug_imovel/widget/filtro_tela_inicial.dart';
import 'package:app_alug_imovel/widget/lista_anuncio_cliente.dart';
import 'package:app_alug_imovel/widget/widgets_cliente/card_regs_login.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/cabecalho_pesquisa_cliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaInicialCliente extends StatefulWidget {
  const TelaInicialCliente({super.key});

  @override
  State<TelaInicialCliente> createState() => _TelaInicialClienteState();
}

class _TelaInicialClienteState extends State<TelaInicialCliente> {
  bool carregando = false;
  ControleAnuncio? controleAnuncio;
  bool pesquisaFeita = false;
  bool estaFiltrando = false;
  bool estaAutenticando = false;
  bool clienteLogado = false;
  bool apenasFavoritados = false;
  String termoPesquisa = '';
  String tituloCard = 'Cadastro';

  @override
  void initState() {
    super.initState();
    // verificarRegistroCliente();
    carregarLista();
  }

  verificarRegistroCliente() async {
    ControleAuth controleAut =
        Provider.of<ControleAuth>(context, listen: false);
    await controleAut.iniciarBD();
    clienteLogado = controleAut.verificarCredenciais();
  }

  carregarLista() async {
    setState(() {
      carregando = true;
    });
    ControleAuth controleAut =
        Provider.of<ControleAuth>(context, listen: false);
    ControleAnuncio controleAnunc =
        Provider.of<ControleAnuncio>(context, listen: false);
    await controleAnunc.carregarAnunciosTelaInicial();

    // await controleAnunc.funcaoInfoFotosTeste();
    bool temId = controleAut.prefs!.containsKey('id');

    if (temId && controleAut.temFavorito) {
      await controleAnunc.carregarFavoritos(controleAut.idUsuario!);
    }
    setState(() {
      carregando = false;
    });
  }

  exibirFavoritos() {
    setState(() {
      apenasFavoritados = true;
    });
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

  alterarStatusPesquisa() {
    setState(() {
      pesquisaFeita = true;
    });
  }

  alterarParaAutenticacao() {
    setState(() {
      estaAutenticando = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    List<Anuncio> anuncios = Provider.of<ControleAnuncio>(context).anuncios;
    ControleAuth controleAut = Provider.of<ControleAuth>(context);
    clienteLogado = controleAut.clienteLogado;
    // estaAutenticando = Provider.of<ControleAuth>(context).clienteLogado;

    return carregando
        ? Scaffold(
            backgroundColor: HexColor('#273949'),
            extendBody: true,
            body: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                color: Colors.white,
                value: 50,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: HexColor('#273949'),
            extendBody: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              shadowColor: Colors.transparent,
              leading: Padding(
                padding: EdgeInsets.only(
                  top: alturaPadding * 0.1,
                  left: larguraPadding * 0.2,
                ),
                child: estaAutenticando
                    ? Container(
                        alignment: Alignment.center,
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent, // Button color
                            child: InkWell(
                              splashColor: Colors.amberAccent, // Splash color
                              onTap: () {
                                setState(() {
                                  estaAutenticando = false;
                                });
                              },
                              child: SizedBox(
                                  width: 46,
                                  height: 46,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: HexColor('#ffffff'),
                                    size: 30,
                                  )),
                            ),
                          ),
                        ),
                      )
                    : controleAut.clienteLogado
                        ? const SizedBox(
                            height: 1,
                          )
                        : const BotaoRetorno(
                            apagarLista: true,
                          ),
              ),
              actions: [
                clienteLogado
                    // estaAutenticando
                    ? IconButton(
                        onPressed: () async {
                          await Provider.of<ControleAuth>(context,
                                  listen: false)
                              .sairConta();
                          //Codigo provisorio
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaInicial()),
                          ).then((_) {
                            Navigator.pop(
                                context); // Remove a tela substituída da pilha
                          });
                          //Codigo provisorio
                        },
                        icon: const Icon(
                          Icons.exit_to_app_outlined,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(
                        height: 1,
                      ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: alturaPadding * 0.02,
                bottom: alturaPadding * 0.05,
                left: larguraPadding * 0.08,
                right: larguraPadding * 0.08,
              ),
              child: SingleChildScrollView(
                child: estaAutenticando
                    ? Padding(
                        padding: EdgeInsets.only(top: alturaPadding * 0.5),
                        child: Center(
                          child: CardRegsLogin(() {
                            setState(() async {
                              estaAutenticando = false;
                              await carregarLista();
                              // clienteLogado =
                              //     Provider.of<ControleAuth>(context, listen: false)
                              //         .verificarCredenciais();
                            });
                          }),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: larguraPadding * 0.5,
                              vertical: alturaPadding * 0.05,
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
                            height: alturaPadding * 0.1,
                          ),
                          Container(
                            height: altura * 0.76,
                            width: largura * 0.95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: larguraPadding * 0.01,
                                    right: larguraPadding * 0.01,
                                  ),
                                  child: CabecalhoPesquisaCliente(
                                    pesquisaFeita,
                                    estaFiltrando,
                                    apenasFavoritados,
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
                                      contrPesq
                                          .pesquisaIndexAnuncio(termoPesquisa);
                                      setState(() {
                                        pesquisaFeita = true;
                                      });
                                    },
                                    () {
                                      Provider.of<ControleAnuncio>(context,
                                              listen: false)
                                          .limparPesquisa();
                                      setState(() {
                                        pesquisaFeita = false;
                                        estaFiltrando = false;
                                        apenasFavoritados = false;
                                        // termoPesquisa = '';
                                      });
                                    },
                                    () {
                                      _campoDialog(altura, alturaPadding,
                                          larguraPadding);
                                      setState(() {
                                        estaFiltrando = true;
                                      });
                                    },
                                    () {
                                      clienteLogado
                                          // estaAutenticando
                                          ? exibirFavoritos()
                                          : alterarParaAutenticacao();
                                    },
                                    false,
                                  ),
                                ),
                                ListaAnuncioCliente(pesquisaFeita,
                                    estaFiltrando, anuncios, apenasFavoritados),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
  }
}
