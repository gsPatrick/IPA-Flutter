import 'package:app_alug_imovel/controller/controle_adm.dart';
import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/util/rotas_nomeadas.dart';
import 'package:app_alug_imovel/view/login_ou_incial_anunciante.dart';
import 'package:app_alug_imovel/view/tela_cadastro_anunciante.dart';
import 'package:app_alug_imovel/view/tela_cadastro_anuncio.dart';
import 'package:app_alug_imovel/view/tela_inicial.dart';
import 'package:app_alug_imovel/view/tela_inicial_anunciante.dart';
import 'package:app_alug_imovel/view/tela_inicial_cliente.dart';
import 'package:app_alug_imovel/view/tela_login_anunciante.dart';
import 'package:app_alug_imovel/view/tela_pesquisa_anuncio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ControleAuth(),
        ),
        ChangeNotifierProvider(
          create: (_) => ControleAnuncio(),
        ),
        ChangeNotifierProxyProvider<ControleAuth, ControleAdm>(
          create: (_) => ControleAdm(email: null, senha: null),
          update: ((context, aut, adm) =>
              ControleAdm(email: aut.email, senha: aut.senha)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vendly',
        theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        routes: {
          RotasNomeadas.TELAINICIAL: (ctx) => const TelaInicial(),
          RotasNomeadas.TELAINICIALCLIENTE: (ctx) => const TelaInicialCliente(),
          RotasNomeadas.TELAINICIALOULOGIN: (ctx) => AutLoginAnunciante(),
          RotasNomeadas.LOGINANUNCIANTE: (ctx) => const TelaLoginAnunciante(),
          RotasNomeadas.CADASTRO: (ctx) => const TelaCadastroAnunciante(),
          RotasNomeadas.TELAINICIALANUNCIANTE: (ctx) =>
              const TelaInicialAnunciante(),
          RotasNomeadas.TELACADASTROANUNCIO: (ctx) => TelaCadastroAnuncio(),
          RotasNomeadas.TELAPESQUISAANUNCIO: (ctx) => TelaPesquisaAnuncio(),
        },
      ),
    );
  }
}
