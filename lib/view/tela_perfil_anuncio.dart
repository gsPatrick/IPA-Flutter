import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_contato_whatsapp.dart';
import 'package:app_alug_imovel/widget/botao_voltar_form.dart';
import 'package:app_alug_imovel/widget/botao_voltar_perfil.dart';
import 'package:app_alug_imovel/widget/widgets_cliente/card_regs_login.dart';
import 'package:app_alug_imovel/widget/widgets_tela_perfil/adicionais_incluso.dart';
import 'package:app_alug_imovel/widget/widgets_tela_perfil/carrosel_fotos_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_tela_perfil/denuncia_anunciante.dart';
import 'package:app_alug_imovel/widget/widgets_tela_perfil/descricao_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_tela_perfil/info_anunciante.dart';
import 'package:app_alug_imovel/widget/widgets_tela_perfil/info_cabecalho_anuncio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaPerfilAnuncio extends StatefulWidget {
  final List<String> imagens;
  final Anuncio anuncio;
  final bool ehCliente;
  const TelaPerfilAnuncio(this.imagens, this.anuncio,
      {this.ehCliente = false, super.key});

  @override
  State<TelaPerfilAnuncio> createState() => _TelaPerfilAnuncioState();
}

class _TelaPerfilAnuncioState extends State<TelaPerfilAnuncio> {
  String motivoDenuncia = '';
  List<String> opcoesValor = ['/mes', '/dia', ''];
  List<String> infoDenuncia = ['É golpe', 'Anúncio falso'];
  List<String> listaCategoria = [];
  bool ehFavoritoInicial = false;
  bool ehFavorito = false;
  bool clienteLogado = false;
  bool estaAutenticando = false;
  // int tamanhoDaLista = 0;
  ControleAuth? controleAut;
  ControleAnuncio? controleAnunc;
  @override
  void initState() {
    super.initState();
    verificarUsuario();
  }

  verificarUsuario() {
    controleAut = Provider.of<ControleAuth>(context, listen: false);
    clienteLogado = controleAut!.clienteLogado;
    controleAnunc = Provider.of<ControleAnuncio>(context, listen: false);

    if (clienteLogado) {
      ehFavorito = widget.anuncio.ehFavorito;
      ehFavoritoInicial = ehFavorito;
    } else {}
  }

  favoritar() {
    if (clienteLogado) {
      setState(() {
        ehFavorito = !ehFavorito;
      });

      controleAnunc!
          .atualizarFavoritoNaListaPrincipal(widget.anuncio.idAnuncio!);
    } else {
      setState(() {
        estaAutenticando = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    // tamanhoDaLista = Provider.of<ControleAnuncio>(context, listen: false)
    //     .idAnunciosFavoritos
    //     .length;
    return Scaffold(
      backgroundColor: estaAutenticando ? HexColor('#112F47') : Colors.white,
      extendBody: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Padding(
            padding: EdgeInsets.only(
              top: alturaPadding * 0.1,
              left: larguraPadding * 0.2,
            ),
            child: estaAutenticando
                ? BotaoVoltarForm(
                    () {
                      setState(() {
                        estaAutenticando = false;
                      });
                    },
                  )
                : ehFavorito != ehFavoritoInicial
                    ? BotaoVoltarPerfil(
                        () async {
                          await controleAnunc!
                              .salvarAnuncioFavorito(controleAut!.idUsuario!);

                          Navigator.maybePop(context);
                        },
                      )
                    : BotaoVoltarPerfil(() {
                        Navigator.maybePop(context);
                      })),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: alturaPadding * 0.3,
            bottom: alturaPadding * 0.2,
            left: larguraPadding * 0.02,
            right: larguraPadding * 0.02,
          ),
          child: estaAutenticando
              ? Center(
                  child: CardRegsLogin(() {
                    setState(() {
                      estaAutenticando = false;
                    });
                    Navigator.of(context).pop();
                  }),
                )
              : Column(
                  children: [
                    CarrosselFotosAnuncio(widget.imagens),
                    InfoCabecalhoImovel(
                      widget.anuncio,
                      ehFavorito,
                      favoritar,
                      controleAut!.clienteLogado,
                      ehCliente: widget.ehCliente,
                    ),
                    SizedBox(
                      height: alturaPadding * 0.25,
                    ),
                    BotaoContatoWhats(anuncio: widget.anuncio),
                    DescricaoAnuncio(widget.anuncio.descricao!),
                    AdicionaisIncluso(widget.anuncio),
                    InfoAnunciante(
                      widget.anuncio.nomeAnunciante!,
                      widget.anuncio.contatoAnunciante!,
                      widget.anuncio.urlImgAnunciante!,
                    ),
                    (clienteLogado || widget.ehCliente)
                        ? DenunciaAnunciante(widget.anuncio)
                        : const SizedBox(
                            height: 1,
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
