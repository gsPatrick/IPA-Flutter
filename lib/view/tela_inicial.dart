import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/util/rotas_nomeadas.dart';
import 'package:app_alug_imovel/view/login_ou_incial_anunciante.dart';
import 'package:app_alug_imovel/view/tela_inicial_admin.dart';
import 'package:app_alug_imovel/view/tela_inicial_anunciante.dart';
import 'package:app_alug_imovel/view/tela_inicial_cliente.dart';
import 'package:app_alug_imovel/view/tela_login_anunciante.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool estaLogado = false;
  bool estaCarregando = false;
  String? tipo;
  ControleAuth? controleAuth;

  @override
  void initState() {
    super.initState();
    // verificarRegistro();
    realizarLoginAutomatico();
  }

  // verificarRegistro() async {
  //   ControleAuth controleAut =
  //       Provider.of<ControleAuth>(context, listen: false);
  //   setState(() {
  //     estaCarregando = true;
  //   });
  //   await controleAut.iniciarBD().then((value) {
  //     setState(() {
  //       estaCarregando = false;
  //     });
  //   });
  //   // estaLogado = controleAut.verificarCredenciais();
  // }

  Future<void> realizarLoginAutomatico() async {
    setState(() {
      estaCarregando = true;
    });

    ControleAuth controleAut =
        Provider.of<ControleAuth>(context, listen: false);
    String? email, senha, tipo, id;
    await controleAut.iniciarBD();
    email = controleAut.prefs?.getString('email');
    senha = controleAut.prefs?.getString('senha');
    id = controleAut.prefs?.getString('id');
    tipo = controleAut.prefs?.getString('tipo');
    print('informacoes da conta :  $email  $senha  $id  $tipo');
    if (tipo == 'anunciante') {
      print('entrou no if do anunciante');
      await controleAut.autenticarAnunciante(email!, senha!);
    } else if (tipo == 'admin') {
      await controleAut.autenticarAdministrador(email!, senha!);
    } else if (tipo == 'cliente') {
      await controleAut.autenticarCliente(email!, senha!);
    }

    setState(() {
      estaCarregando = false;
    });

    // String? numCelular = prefs.getString('numero');
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    controleAuth = Provider.of<ControleAuth>(context);
    estaLogado = controleAuth!.verificarCredenciais();
    print('tipo : $estaLogado');
    tipo = estaLogado ? controleAuth!.prefs!.getString('tipo') : ' ';
    print('tipo : $tipo');

    return estaCarregando
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
        : estaLogado
            ? (tipo == 'admin' || tipo == 'anunciante')
                ? AutLoginAnunciante()
                : TelaInicialCliente()
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  forceMaterialTransparency: true,
                  shadowColor: Colors.transparent,
                ),
                backgroundColor: HexColor('#273949'),
                extendBody: true,
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: alturaPadding * 0.2,
                        horizontal: larguraPaddinfg * 0.4),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Aqui você encontrará as melhores oportunidades',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          //emoji

                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: alturaPadding * 0.1),
                            child: Container(
                              width: largura * 0.7,
                              height: largura * 0.7,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/logo_com_sombra.png'),
                                  // image: AssetImage('assets/images/logo_app.jpg'),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          // Text(EmojiParser().getEmoji('🤩').toString()),
                          // Text(
                          //   Emoji('grinning_face_with_star_eyes', '🤩'),
                          // ), solicitar um aruqivo png desse rostinho feliz
                          // Text(EmojiParser().emojify(':grinning_face_with_star_eyes:')),
                          // EmojiWidget(),
                          const Text(
                            'O que você deseja com o nosso app ? ',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: alturaPadding * 0.3,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BotaoFormulario(
                                submeter: () {
                                  Navigator.of(context).pushNamed(
                                      RotasNomeadas.TELAINICIALCLIENTE);
                                },
                                titulo: 'Estou à procura de um imóvel',
                                formPreenchido: true,
                                corBotao: '#b2852b',
                              ),
                              SizedBox(
                                height: alturaPadding * 0.2,
                              ),
                              BotaoFormulario(
                                submeter: () {
                                  Navigator.of(context).pushNamed(
                                      RotasNomeadas.TELAINICIALOULOGIN);
                                },
                                titulo: 'Estou vendendo/alugando um imóvel',
                                formPreenchido: true,
                                corBotao: '#b2852b',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }
}
