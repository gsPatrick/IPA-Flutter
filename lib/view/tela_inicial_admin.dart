import 'package:app_alug_imovel/controller/controle_adm.dart';
import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/view/tela_anunciantes.dart';
import 'package:app_alug_imovel/view/tela_anuncios.dart';
import 'package:app_alug_imovel/view/tela_denuncias.dart';
import 'package:app_alug_imovel/view/tela_inicial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaInicialAdmin extends StatefulWidget {
  const TelaInicialAdmin({super.key});

  @override
  State<TelaInicialAdmin> createState() => _TelaInicialAdminState();
}

class _TelaInicialAdminState extends State<TelaInicialAdmin> {
  int indiceSelecionado = 0;

  final List<Widget> telas = const [
    TelaAnuncios(),
    TelaDenuncias(),
    TelaAnunciantes(),
  ];

  @override
  void initState() {
    super.initState();
    carregarListaAnunciantes();
  }

  carregarListaAnunciantes() async {
    await Provider.of<ControleAdm>(context, listen: false).carregarAnunciante();
  }

  escolherIndice(int indice) {
    setState(() {
      indiceSelecionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.1;
    return Scaffold(
      backgroundColor: HexColor('#273949'),
      extendBody: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            splashColor: Colors.amberAccent, // Splash color
            onTap: () async {
              await Provider.of<ControleAuth>(context, listen: false)
                  .sairConta();
              Provider.of<ControleAnuncio>(context, listen: false).sairSessao();
              //Codigo provisorio
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TelaInicial()),
              ).then((_) {
                Navigator.pop(context); // Remove a tela substituída da pilha
              });
              //Codigo provisorio
            },
            child: SizedBox(
              width: 46,
              height: 46,
              child: Icon(
                Icons.exit_to_app,
                color: HexColor('#ffffff'),
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: larguraPadding * 0.15,
            vertical: alturaPadding * 0.025,
          ),
          child: IndexedStack(
            index: indiceSelecionado,
            children: telas,
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            selectedFontSize: 0, // Remove o espaço extra
            unselectedFontSize: 0, // Remove o espaço extra
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: HexColor('#273949'),
                  size: alturaPadding * 0.25,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.warning_amber_rounded,
                  color: HexColor('#273949'),
                  size: alturaPadding * 0.25,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  color: HexColor('#273949'),
                  size: alturaPadding * 0.25,
                ),
                label: '',
              ),
            ],
            currentIndex: indiceSelecionado,
            onTap: escolherIndice,
          ),
        ),
      ),
    );
  }
}
