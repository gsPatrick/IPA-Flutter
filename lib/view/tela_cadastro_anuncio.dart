import 'dart:io';

import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_form_descricao.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_checkbox_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_dropdown_bairro.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_dropdown_cidade.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_fotos_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_selec_categoria.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_selec_nquartos.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_titulo.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_valor_anuncio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TelaCadastroAnuncio extends StatefulWidget {
  const TelaCadastroAnuncio({super.key});

  @override
  State<TelaCadastroAnuncio> createState() => _TelaCadastroAnuncioState();
}

class _TelaCadastroAnuncioState extends State<TelaCadastroAnuncio> {
  ControleFormAnuncio contrAnuncio = ControleFormAnuncio();
  CidadeBairroModel cidadesEBairro = CidadeBairroModel();
  List<File> imagens = [];
  int indiceForm = 0;
  bool estaCarregando = false;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('esta sendo iniciado');
  }

  String extractCurrencyValue(String input) {
    // Encontrar o padrão de valor em reais na string
    RegExp regExp = RegExp(r'R\$?\s?(\d{1,3}(\.\d{3})*,\d{2})');
    String? valueWithCurrency = regExp.stringMatch(input);

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

  avancar() {
    setState(() {
      indiceForm++;
    });
  }

  voltar() {
    setState(() {
      indiceForm--;
    });
  }

  concluir() async {
    setState(() {
      estaCarregando = true;
    });
    ControleAuth controleAut =
        Provider.of<ControleAuth>(context, listen: false);
    await Provider.of<ControleAnuncio>(context, listen: false).cadastrarAnuncio(
        Anuncio(
          idAnunciante: controleAut.idUsuario!,
          nomeAnunciante: controleAut.nome,
          contatoAnunciante: controleAut.contato,
          titulo: contrAnuncio.anuncio.tituloAnuncio,
          descricao: contrAnuncio.anuncio.descricao,
          categoria: contrAnuncio.anuncio.indCategoria,
          opcaoValor: contrAnuncio.anuncio.indOpcValor,
          indCidade: contrAnuncio.anuncio.indCidade,
          indBairro: contrAnuncio.anuncio.indBairro,
          nQuarto: contrAnuncio.anuncio.nQuarto,
          imgsImovel: imagens,
          valor: double.parse(extractCurrencyValue(contrAnuncio.anuncio.valor)),
          garagem: contrAnuncio.anuncio.temGaragem,
          piscina: contrAnuncio.anuncio.temPiscina,
          areaLazer: contrAnuncio.anuncio.temAreaLazer,
          condIncluso: contrAnuncio.anuncio.temCondIncluso,
          iptuIncluso: contrAnuncio.anuncio.temIptuIncluso,
          proxPraia: contrAnuncio.anuncio.ehProxPraia,
          portaria: contrAnuncio.anuncio.temPortaria,
          urlImgAnunciante: controleAut.urlFotoPerfil,
        ),
        controleAut.idUsuario!);
    setState(() {
      estaCarregando = false;
    });
    Navigator.of(context).pop();

    print('concluido');
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    print('comecou a funcao build  estacarregando : $estaCarregando ');
    List<Widget> componentes = [
      FormTitulo(contrAnuncio, () {
        avancar();
      }),
      FormSelecCategoria(contrAnuncio, categorias, () {
        avancar();
      }, () {
        voltar();
      }),
      FormValorImovelAnuncio(contrAnuncio, tiposValores, () {
        avancar();
      }, () {
        voltar();
      }),
      CampoFormDescricao(contrAnuncio, () {
        avancar();
      }, () {
        voltar();
      }),
      FormDropdownCidade(cidadesEBairro.cidades, contrAnuncio, () {
        avancar();
      }, () {
        voltar();
      }),
      FormDropdownBairro(
          cidadesEBairro
              .bairros[cidadesEBairro.cidades[contrAnuncio.anuncio.indCidade]]!,
          contrAnuncio, () {
        avancar();
      }, () {
        voltar();
      }),
      FormSelecNQuartos(contrAnuncio, () {
        avancar();
      }, () {
        voltar();
      }),
      FormCheckBoxAnuncio(contrAnuncio, () {
        avancar();
      }, () {
        voltar();
      }),
      FormFotosAnuncio(contrAnuncio, imagens, () {
        concluir();
      }, () {
        voltar();
      })
    ];

    return Scaffold(
      backgroundColor: estaCarregando ? Colors.white : HexColor('#273949'),
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
          child: const BotaoRetorno(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: alturaPadding * 0.1,
          bottom: alturaPadding * 0.2,
          left: larguraPadding * 0.15,
          right: larguraPadding * 0.15,
        ),
        child: Center(
          child: estaCarregando
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: HexColor('#273949'),
                  value: 40,
                )
              : Observer(builder: (_) {
                  return
                      // Container(
                      //   color: Colors.purple,
                      // );

                      componentes[indiceForm];
                }),
        ),
      ),
    );
  }
}
