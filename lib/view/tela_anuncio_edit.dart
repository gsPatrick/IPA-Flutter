// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:app_alug_imovel/model/model_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_contato_whatsapp.dart';
import 'package:app_alug_imovel/widget/btn_transp_borda.dart';
import 'package:app_alug_imovel/widget/campo_form_dinheiro.dart';
import 'package:app_alug_imovel/widget/widget_form_edit/card_form_edit.dart';
import 'package:app_alug_imovel/widget/widget_form_edit/check_box_anuncio_edit.dart';
import 'package:app_alug_imovel/widget/widget_form_edit/form_fotos_edit.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_dropdown_item.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_form_texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TelaAnuncioEdit extends StatefulWidget {
  final Anuncio anuncio;
  const TelaAnuncioEdit(this.anuncio, {super.key});

  @override
  State<TelaAnuncioEdit> createState() => _TelaAnuncioEditState();
}

class _TelaAnuncioEditState extends State<TelaAnuncioEdit> {
  List<Imagem> imagens = [];
  List<String> urlsImgExcluidas = [];
  List<File> imgsNovas = [];
  ControleFormAnuncio? contrAnuncio;
  bool valorAlterado = false;
  CidadeBairroModel cidadesEBairro = CidadeBairroModel();

  List<String> categorias = [
    'Casa',
    'Apartamento',
    'Flat',
    'Quarto',
    'Kitnet',
  ];
  List<String> tiposValores = [
    'Valor Mensal',
    'Valor por Dia',
    'Valor Único',
  ];

  bool estaAlterando = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gerarListaImagem();
    carregarInstancia();
  }

  carregarInstancia() {
    print('valor anuncio : ${widget.anuncio.valor.toString()}');
    contrAnuncio = ControleFormAnuncio();

    contrAnuncio?.anuncio = ModelFormAnuncio(
      tituloAnuncio: widget.anuncio.titulo!,
      descricao: widget.anuncio.descricao!,
      valor: '${widget.anuncio.valor.toString()}0',
      valorReal: widget.anuncio.valor!,
      indOpcValor: widget.anuncio.opcaoValor!,
      indCategoria: widget.anuncio.categoria!,
      indCidade: widget.anuncio.indCidade!,
      indBairro: widget.anuncio.indBairro!,
      nQuarto: widget.anuncio.nQuarto!,
      temGaragem: widget.anuncio.garagem!,
      temPiscina: widget.anuncio.piscina!,
      temAreaLazer: widget.anuncio.areaLazer!,
      temCondIncluso: widget.anuncio.condIncluso!,
      temIptuIncluso: widget.anuncio.iptuIncluso!,
      ehProxPraia: widget.anuncio.proxPraia!,
      temPortaria: widget.anuncio.portaria!,
    );
  }

  gerarListaImagem() {
    // urlsImg.addAll(widget.anuncio.urlsImg!);

    for (var urls in widget.anuncio.urlsImg!) {
      imagens.add(Imagem('url', urls, (imagens.length + 1)));
      print('tamanho atual : ${imagens.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      // appBar: AppBar(
      //   forceMaterialTransparency: true,
      //   shadowColor: Colors.transparent,
      //   automaticallyImplyLeading: false,
      // leading: Padding(
      //     padding: EdgeInsets.only(
      //       top: alturaPadding * 0.1,
      //       left: larguraPadding * 0.2,
      //     ),
      //     child: estaAutenticando
      //         ? BotaoVoltarForm(
      //             () {
      //               setState(() {
      //                 estaAutenticando = false;
      //               });
      //             },
      //           )
      //         : ehFavorito != ehFavoritoInicial
      //             ? BotaoVoltarPerfil(
      //                 () async {
      //                   await controleAnunc!
      //                       .salvarAnuncioFavorito(controleAut!.idUsuario!);

      //                   Navigator.maybePop(context);
      //                 },
      //               )
      //             : BotaoVoltarPerfil(() {
      //                 Navigator.maybePop(context);
      //               })),
      // ),
      body: estaAlterando
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: HexColor('#273949'),
                value: 50,
              ),
            )
          : SingleChildScrollView(
              child: Observer(builder: (_) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: alturaPadding * 0.3,
                    bottom: alturaPadding * 0.2,
                    left: larguraPadding * 0.1,
                    right: larguraPadding * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: alturaPadding * 0.5,
                        child: const Center(
                          child: CabecalhoForm(
                            'Editar Informações',
                            corTexto: '#293949',
                            tamanhoFonte: 25,
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: larguraPadding * 0.2),
                        child: Column(
                          children: [
                            Container(
                              height: alturaPadding * 0.5,
                              child: const Center(
                                child: CabecalhoForm(
                                  'Título do anúncio:',
                                  corTexto: '#293949',
                                ),
                              ),
                            ),
                            CampoFormTexto(
                              labelText: 'Titulo',
                              nomeEditavel: contrAnuncio?.anuncio.tituloAnuncio,
                              onchanged:
                                  contrAnuncio!.anuncio.alterarTituloAnunc,
                              callBackErrorText:
                                  contrAnuncio!.validaTituloAnuncio,
                              maxCaracteres: 40,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: HexColor('#293949'),
                        thickness: 1.5,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: alturaPadding * 0.1),
                        child: CardFormEdit(Icons.image, 'Imagens anúncio', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FormFotosEdit(imagens, () {
                                // setState(() {
                                //   imagens.clear();
                                //   gerarListaImagem();
                                //   urlsImgExcluidas.clear();
                                //   imgsNovas.clear();
                                //   Navigator.of(context).pop();
                                // });
                                Navigator.of(context).pop();
                              }, () {
                                Navigator.of(context).pop();
                              }, (imagem) {
                                setState(() {
                                  if (imagens.length > 1) {
                                    imagens.remove(imagem);

                                    if (imagem.tipo == 'file') {
                                      imgsNovas.remove(imagem.valor as File);
                                    } else {
                                      urlsImgExcluidas
                                          .add(imagem.valor as String);
                                    }
                                  } else {}
                                });
                              }, (novaFoto) {
                                setState(() {
                                  if (imagens.length < 5) {
                                    imagens.add(Imagem('file', novaFoto,
                                        (imagens.length + 1)));
                                  } else {
                                    imagens.first = Imagem('file', novaFoto, 1);
                                  }

                                  if (imgsNovas.length < 5) {
                                    imgsNovas.add(novaFoto);
                                  } else {
                                    imgsNovas.first = novaFoto;
                                  }
                                });
                              }),
                            ),
                          );
                        }),
                      ),
                      // Card(
                      //   shadowColor: Colors.blueGrey.shade900,

                      // )
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: larguraPadding * 0.1),
                      //   child: ListTile(
                      //     leading: Icon(Icons.image),
                      //     title: T;})ext('Imagens anuncio'),
                      //     trailing: IconButton(
                      //       style: ButtonStyle(
                      //         backgroundColor: MaterialStateProperty.all(
                      //             Colors.orange), // Define a cor do fundo
                      //         foregroundColor: MaterialStateProperty.all(
                      //             Colors.white), // Define a cor do ícone
                      //         overlayColor: MaterialStateProperty.all(
                      //           Colors.blue.withOpacity(0.2),
                      //         ),
                      //       ),
                      //       onPressed: () {},
                      //       icon: Icon(
                      //         Icons.edit,
                      //         size: 30,
                      //         // color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // CarrosselFotosAnuncio(widget.anuncio.urlsImg!),
                      // FormFotosEdit(imagens, () {}, () {}),
                      Divider(
                        color: HexColor('#293949'),
                        thickness: 1.5,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: alturaPadding * 0.1),
                        child: Column(
                          children: [
                            Container(
                              height: alturaPadding * 0.2,
                              child: const Center(
                                child: CabecalhoForm(
                                  'Localização:',
                                  corTexto: '#293949',
                                  tamanhoFonte: 20,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: largura * 0.35,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: alturaPadding * 0.25,
                                        child: const CabecalhoForm(
                                          'Cidade :',
                                          corTexto: '#293949',
                                        ),
                                      ),
                                      CampoDropDownItem(
                                        Icon(Icons.arrow_drop_down_outlined),
                                        cidadesEBairro.cidades,
                                        contrAnuncio!.anuncio.indCidade,
                                        alturaPadding,
                                        (value) {
                                          setState(() {
                                            contrAnuncio!.anuncio
                                                .alterarIndCidade(value);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width: largura * 0.35,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: alturaPadding * 0.25,
                                          child: const CabecalhoForm(
                                            'Bairro :',
                                            corTexto: '#293949',
                                          ),
                                        ),
                                        CampoDropDownItem(
                                          Icon(Icons.arrow_drop_down_outlined),
                                          cidadesEBairro.bairros[
                                              cidadesEBairro.cidades[
                                                  contrAnuncio!
                                                      .anuncio.indCidade]]!,
                                          contrAnuncio!.anuncio.indBairro,
                                          alturaPadding,
                                          (value) {
                                            setState(() {
                                              contrAnuncio!.anuncio
                                                  .alterarIndBairro(value);
                                            });
                                          },
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: HexColor('#293949'),
                        thickness: 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: largura * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: alturaPadding * 0.25,
                                  child: const CabecalhoForm(
                                    'Valor:',
                                    corTexto: '#293949',
                                  ),
                                ),
                                CampoFormDinheiro(
                                  nomeCampo: 'Valor',
                                  registrarAlteracao: (value) {
                                    setState(() {
                                      valorAlterado = true;
                                      contrAnuncio!.anuncio.alterarValor(value);
                                    });
                                  },

                                  // (value) {
                                  //   setState(() {
                                  //     contrAnuncio!.anuncio.alterarValor(value);
                                  //   });
                                  // },
                                  notificarErro: () {},
                                  maxCaracteres: 11,
                                  informacaoInicial:
                                      'R\$ ${contrAnuncio!.anuncio.valor}',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: largura * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: alturaPadding * 0.25,
                                  child: const CabecalhoForm(
                                    'Tipo :',
                                    corTexto: '#293949',
                                  ),
                                ),
                                CampoDropDownItem(
                                  const Icon(Icons.arrow_drop_down_outlined),
                                  tiposValores,
                                  contrAnuncio!.anuncio.indOpcValor,
                                  alturaPadding,
                                  (value) {
                                    setState(() {
                                      valorAlterado = true;
                                      contrAnuncio!.anuncio
                                          .alterarIndOpcValor(value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: alturaPadding * 0.1,
                            horizontal: alturaPadding * 0.1),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: largura * 0.4,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: larguraPadding * 0.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: alturaPadding * 0.25,
                                  child: const CabecalhoForm(
                                    'Categoria :',
                                    corTexto: '#293949',
                                  ),
                                ),
                                CampoDropDownItem(
                                  Icon(Icons.arrow_drop_down_outlined),
                                  categorias,
                                  contrAnuncio!.anuncio.indCategoria,
                                  alturaPadding,
                                  (value) {
                                    setState(() {
                                      contrAnuncio!.anuncio
                                          .alterarIndCategoria(value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: HexColor('#293949'),
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: alturaPadding * 0.1,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: larguraPadding * 0.3),
                            child: SizedBox(
                              height: alturaPadding * 0.2,
                              child: const CabecalhoForm(
                                'Descrição:',
                                corTexto: '#293949',
                                tamanhoFonte: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: altura * 0.2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: larguraPadding * 0.3),
                              child: CampoFormTexto(
                                labelText: 'Descrição',
                                nomeEditavel: contrAnuncio!.anuncio.descricao,
                                onchanged:
                                    contrAnuncio!.anuncio.alterarDescricao,
                                callBackErrorText:
                                    contrAnuncio!.validaDescricao,
                                maxCaracteres: 360,
                                maxLines: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: alturaPadding * 0.1,
                      ),
                      Divider(
                        color: HexColor('#293949'),
                        thickness: 1.5,
                      ),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: alturaPadding * 0.1),
                        child: CardFormEdit(
                            Icons.check_circle_outline, 'Adicionais anúncio',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CheckBoxAnuncioEdit(contrAnuncio!, () {}, () {
                                Navigator.of(context).pop();
                              }),
                            ),
                          );
                        }),
                      ),
                      Divider(
                        color: HexColor('#293949'),
                        thickness: 1.5,
                      ),
                      SizedBox(
                        height: alturaPadding * 0.2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: largura * 0.38,
                              child: BtnTranspBorda(
                                submeter: () {
                                  Navigator.of(context).pop();
                                },
                                titulo: 'Voltar',
                                formPreenchido: true,
                                corBotao: '#ffffff',
                                corBorda: '#495664',
                                corTexto: '#495664',
                              )),
                          SizedBox(
                            width: largura * 0.38,
                            child: BtnFormAnuncio(
                              submeter: () async {
                                double valorFinal = 0.0;
                                if (!valorAlterado) {
                                  valorFinal = contrAnuncio!.anuncio.valorReal;
                                } else {
                                  valorFinal = double.parse(
                                      extractCurrencyValue(
                                          contrAnuncio!.anuncio.valor));
                                }

                                Anuncio novoAnuncio = Anuncio(
                                  idAnunciante: widget.anuncio.idAnunciante,
                                  idAnuncio: widget.anuncio.idAnuncio,
                                  nomeAnunciante: widget.anuncio.nomeAnunciante,
                                  contatoAnunciante:
                                      widget.anuncio.contatoAnunciante,
                                  titulo: contrAnuncio?.anuncio.tituloAnuncio,
                                  descricao: contrAnuncio?.anuncio.descricao,
                                  categoria: contrAnuncio?.anuncio.indCategoria,
                                  opcaoValor: contrAnuncio?.anuncio.indOpcValor,
                                  indCidade: contrAnuncio?.anuncio.indCidade,
                                  indBairro: contrAnuncio?.anuncio.indBairro,
                                  nQuarto: contrAnuncio?.anuncio.nQuarto,
                                  urlsImg: widget.anuncio.urlsImg,
                                  urlImgPesquisa: widget.anuncio.urlImgPesquisa,
                                  valor: valorFinal,
                                  // double.parse(
                                  //     extractCurrencyValue(valorFormatado)),
                                  // double.parse(extractCurrencyValue(
                                  //     contrAnuncio!.anuncio.valor)),
                                  garagem: contrAnuncio?.anuncio.temGaragem,
                                  piscina: contrAnuncio?.anuncio.temPiscina,
                                  areaLazer: contrAnuncio?.anuncio.temAreaLazer,
                                  condIncluso:
                                      contrAnuncio?.anuncio.temCondIncluso,
                                  iptuIncluso:
                                      contrAnuncio?.anuncio.temIptuIncluso,
                                  proxPraia: contrAnuncio?.anuncio.ehProxPraia,
                                  portaria: contrAnuncio?.anuncio.temPortaria,
                                  urlImgAnunciante:
                                      widget.anuncio.urlImgPesquisa,
                                );
                                print(
                                    'lista de anuncio antes da exclusao : ${novoAnuncio.urlsImg}');
                                setState(() {
                                  estaAlterando = true;
                                });
                                await Provider.of<ControleAnuncio>(context,
                                        listen: false)
                                    .editarAnuncio(
                                  novoAnuncio,
                                  novoAnuncio.idAnunciante!,
                                  urlsImgExcluidas,
                                  imgsNovas,
                                );
                                setState(() {
                                  estaAlterando = false;
                                });
                                Navigator.of(context).pop();
                                // print(
                                //     'numero de fotos do firebase excluidas : ${urlsImgExcluidas.length}');
                                // print(
                                //     'numero de fotos adicionadas : ${imgsNovas.length}');
                              },
                              titulo: 'Alterar',
                              formPreenchido: true,
                              corBotao: '#14870c',
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     AdicionaisIncluso(
                      //       widget.anuncio,
                      //       ehEdicao: true,
                      //     ),
                      //     BtnFormAnuncio(
                      //       submeter: () {},
                      //       titulo: 'Editar',
                      //       formPreenchido: true,
                      //       corBotao: '#ffa500',
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                );
              }),
            ),
    );
  }

  String extractCurrencyValue(String input) {
    // Encontrar o padrão de valor em reais na string
    print('no input : $input');
    RegExp regExp = RegExp(r'R\$?\s?(\d{1,3}(\.\d{3})*,\d{2})');
    String? valueWithCurrency = regExp.stringMatch(input);
    print('valor inserido : $valueWithCurrency');
    if (valueWithCurrency != null) {
      // Extrair somente o valor numérico da string
      String valueWithoutCurrency =
          valueWithCurrency.replaceAll(RegExp(r'[^\d,]'), '');

      // Substituir a vírgula por ponto para formatar como double
      String valueFormatted = valueWithoutCurrency.replaceAll(',', '.');

      return valueFormatted;
    }

    return '0.00';
  }
}

// CarrosselFotosAnuncio(widget.anuncio.urlsImg!),
//               InfoCabecalhoImovel(widget.anuncio, ehFavorito, favoritar,
//                   controleAut!.clienteLogado),
//               SizedBox(
//                 height: alturaPadding * 0.25,
//               ),
//               // BotaoContatoWhats(anuncio: widget.anuncio),
//               DescricaoAnuncio(widget.anuncio.descricao!),
//               AdicionaisIncluso(widget.anuncio),
