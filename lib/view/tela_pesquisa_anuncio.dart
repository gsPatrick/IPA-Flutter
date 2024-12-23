import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_checkbox_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_dropdown_bairro.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_dropdown_cidade.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_selec_categoria.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/form_selec_nquartos.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/form_compra_ou_aluguel.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/form_slider_valor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TelaPesquisaAnuncio extends StatefulWidget {
  const TelaPesquisaAnuncio({super.key});

  @override
  State<TelaPesquisaAnuncio> createState() => _TelaPesquisaAnuncioState();
}

class _TelaPesquisaAnuncioState extends State<TelaPesquisaAnuncio> {
  bool estaCarregando = false;
  int indiceForm = 0;
  CidadeBairroModel cidadesEBairro = CidadeBairroModel();
  ControleFormAnuncio contrAnuncio = ControleFormAnuncio();
  List<String> categorias = [
    'Casa',
    'Apartamento',
    'Flat',
    'Quarto',
    'Kitnet',
  ];
  List<String> tipoCompra = ['Alugar', 'Comprar'];

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

  concluir(Function callback) async {
    setState(() {
      estaCarregando = true;
    });
    await Provider.of<ControleAnuncio>(context, listen: false)
        .retornarPesquisa(contrAnuncio);

    setState(() {
      estaCarregando = false;
    });
    callback();
    Navigator.of(context).pop();
  }

  voltarTela() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    final Map args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    Function callback = args['callback'];

    List<Widget> componentes = [
      // form escolha aluguel ou compra
      FormCompraAluguel(contrAnuncio, tipoCompra, avancar, voltarTela),

      FormDropdownCidade(cidadesEBairro.cidades, contrAnuncio, avancar, voltar),
      FormDropdownBairro(
          cidadesEBairro
              .bairros[cidadesEBairro.cidades[contrAnuncio.anuncio.indCidade]]!,
          contrAnuncio,
          avancar,
          voltar),
      FormSelecCategoria(contrAnuncio, categorias, avancar, voltar),
      FormSliderValor(
          contrAnuncio, avancar, voltar, contrAnuncio.anuncio.ehCompra),
      // formulario para valor
      FormSelecNQuartos(contrAnuncio, avancar, voltar),
      FormCheckBoxAnuncio(contrAnuncio, () {
        concluir(callback);
      }, voltar, ehPesquisa: true),
    ];

    // categorias, (value) {
    //     contrAnuncio.anuncio.alterarIndCategoria(value);
    //   },
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
                  return componentes[indiceForm];
                }),
        ),
      ),
    );
  }
}
