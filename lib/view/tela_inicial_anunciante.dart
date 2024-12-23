import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/util/manipulacao_img.dart';
import 'package:app_alug_imovel/view/login_ou_incial_anunciante.dart';
import 'package:app_alug_imovel/view/tela_editar_perfil_anunciante.dart';
import 'package:app_alug_imovel/view/tela_inicial.dart';
import 'package:app_alug_imovel/view/tela_login_anunciante.dart';
import 'package:app_alug_imovel/widget/cab_tela_inicial_anunciante.dart';
import 'package:app_alug_imovel/widget/widgets_anunciante/anuncios_anunciante.dart';
import 'package:app_alug_imovel/widget/widgets_anunciante/form_infor_anunciante.dart';
import 'package:app_alug_imovel/widget/widgets_anunciante/menu_config_anuncio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaInicialAnunciante extends StatefulWidget {
  const TelaInicialAnunciante({super.key});

  @override
  State<TelaInicialAnunciante> createState() => _TelaInicialAnuncianteState();
}

class _TelaInicialAnuncianteState extends State<TelaInicialAnunciante> {
  ControleAuth? anunciante;
  ControleAutCadastro controleCadastro = ControleAutCadastro();
  bool estaCarregando = false;
  ControleAnuncio? controleAnuncio;

  @override
  void initState() {
    super.initState();
    anunciante = Provider.of<ControleAuth>(context, listen: false);
    // temNome = cadastro!.nome!.isNotEmpty;
    carregarLista(anunciante!.idUsuario!);
  }

  carregarLista(String idAnunciante) async {
    setState(() {
      estaCarregando = true;
    });
    ManipulacaoImg manipImg = ManipulacaoImg();
    // manipImg.substituirTodasFotosAnuncio([], idAnunciante, 'idAnuncio');
    await Provider.of<ControleAnuncio>(context, listen: false)
        .carregarPropriosAnuncios(idAnunciante);

    setState(() {
      estaCarregando = false;
    });
  }

  void menupopup(
      int index, Anuncio anuncio, double largura, alturaPadding, altura) {
    // controleAdm = Provider.of<ControleAdm>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: SizedBox(
          width: largura * 0.9,
          height: alturaPadding * 0.8,
          child: AutoSizeText(
            anuncio.titulo!,
            style: TextStyle(
              color: Colors.blueGrey.shade900,
              fontWeight: FontWeight.w700,
              fontSize: 21,
            ),
            maxLines: 2,
          ),
        ),
        content: MenuConfigAnuncio(anuncio, index),
        // MenuBotoes(controleAdm!, usuario, index),
      ),
    );
  }

  excluirAnuncio(Anuncio anuncio, int indice) async {
    await Provider.of<ControleAnuncio>(context, listen: false).excluirAnuncio(
        anuncio.idAnunciante!, anuncio.idAnuncio!, indice, false);
  }

  void showMessage(String faseMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'saida ocorrencia',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'situacao : $faseMessage',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    List<Anuncio> anuncios =
        Provider.of<ControleAnuncio>(context).anunciosProprios;
    anunciante = Provider.of<ControleAuth>(context);

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
        : Scaffold(
            backgroundColor: HexColor('#273949'),
            extendBody: true,
            appBar: AppBar(
              forceMaterialTransparency: true,
              shadowColor: Colors.transparent,
              // automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsets.only(left: larguraPadding * 0.25),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaEditarPerfilAnunciante(anunciante!),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              actions: [
                InkWell(
                  splashColor: Colors.amberAccent, // Splash color
                  onTap: () async {
                    // showMessage('começando a sair');
                    ControleAuth controle =
                        Provider.of<ControleAuth>(context, listen: false);
                    await controle.sairConta();
                    //Codigo provisorio
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TelaInicial()),
                    ).then((_) {
                      Navigator.pop(
                          context); // Remove a tela substituída da pilha
                    });
                    //Codigo provisorio
                    // showMessage(
                    //     'saindo finalmente valor do token : ${controle.token}');
                    //codigo alternativo

                    //codigo alternativo
                  },
                  child: SizedBox(
                      width: 46,
                      height: 46,
                      child: Icon(
                        Icons.exit_to_app,
                        color: HexColor('#ffffff'),
                        size: 30,
                      )),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: alturaPadding * 0.1,
                bottom: alturaPadding * 0.05,
                left: larguraPadding * 0.15,
                right: larguraPadding * 0.15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    anunciante!.permissaoAnuncio!
                        ? CabecalhoTelaInicialAnunciante(
                            anunciante!.permissaoAnuncio!,
                            nome: anunciante!.nome!,
                            contato: anunciante!.contato!,
                            urlFoto: anunciante!.urlFotoPerfil!,
                          )
                        : CabecalhoTelaInicialAnunciante(
                            anunciante!.permissaoAnuncio!),
                    SizedBox(
                      height: alturaPadding * 0.25,
                    ),
                    anunciante!.nome!.isEmpty
                        ? FormInfoAnunciante((value) {
                            setState(() {
                              estaCarregando = value;
                            });
                          })
                        : AnunciosAnunciante(anuncios, (anuncio, indice) {
                            // menupopup(indice, anuncio, largura, alturaPadding,
                            //     altura);
                          }),
                  ],
                ),
              ),
            ),
          );
  }
}
