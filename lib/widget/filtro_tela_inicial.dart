import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/model/cidade_bairro_model.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/campo_form_dinheiro.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:app_alug_imovel/widget/widgets_formulario_pesquisa/campo_dropdown_filtro.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltroTelaInicial extends StatefulWidget {
  const FiltroTelaInicial({super.key});

  @override
  State<FiltroTelaInicial> createState() => _FiltroTelaInicialState();
}

class _FiltroTelaInicialState extends State<FiltroTelaInicial> {
  bool carregando = false;
  ControleAnuncio? controleAnuncio;
  CidadeBairroModel? cidadeBairro;
  bool pesquisaFeita = false;
  String termoPesquisa = '';
  List<String> tipoCategoria = ['Alugar', 'Diária', 'Comprar'];
  List<String> tipoImovel = [
    'Casa',
    'Apartamento',
    'Flat',
    'Quarto',
    'Kitnet',
  ];
  List<String>? cidades;
  // Map<String, List<String>>? bairros;
  List<String>? bairros;
  double valor = 0;
  String valorExib = '';
  int indCategoria = 0;
  int indTipoImovel = 0;
  int indCidade = 0;
  int indBairro = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarLista();
  }

  carregarLista() {
    cidadeBairro = CidadeBairroModel();
    cidades = cidadeBairro!.cidades;
    bairros = cidadeBairro!.bairros[cidades?[0]];
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

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    // List<Anuncio> anuncios = Provider.of<ControleAnuncio>(context).anuncios;
    return SizedBox(
      height: altura * 0.6,
      width: largura * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CampoDropdownFiltro('Categoria: ', tipoCategoria, indCategoria,
                  (indice) {
                setState(() {
                  indCategoria = indice;
                });
              }),
              CampoDropdownFiltro(
                  'Tipo de \n imóvel: ', tipoImovel, indTipoImovel, (indice) {
                setState(() {
                  indTipoImovel = indice;
                });
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: altura * 0.05,
                    child: Container(
                      alignment: Alignment.center,
                      child: const CabecalhoForm(
                        'Valor máximo :',
                        corTexto: '#293949',
                        tamanhoFonte: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: altura * 0.1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: larguraPadding * 0.1,
                      ),
                      child: SizedBox(
                        width: largura * 0.5,
                        height: alturaPadding * 0.25,
                        child: CampoFormDinheiro(
                          nomeCampo: 'Valor máximo :',
                          registrarAlteracao: (value) {
                            setState(() {
                              valorExib = value;
                            });
                          },
                          notificarErro: () {},
                          maxCaracteres: 11,
                          informacaoInicial: 'R\$ 00,00',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CampoDropdownFiltro('Cidade: ', cidades!, indCidade, (indice) {
                setState(() {
                  indCidade = indice;
                  bairros = cidadeBairro?.bairros[cidades?[indCidade]] ?? [];
                  indBairro = 0;
                });
              }),
              CampoDropdownFiltro('Bairro: ', bairros!, indBairro, (indice) {
                setState(() {
                  indBairro = indice;
                });
              }),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: alturaPadding * 0.1),
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<ControleAnuncio>(context, listen: false)
                    .pesquisaRapida(
                        indCategoria,
                        indCidade,
                        indBairro,
                        indTipoImovel,
                        double.parse(extractCurrencyValue(valorExib)));

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(largura * 0.55, alturaPadding * 0.2),
                onPrimary: HexColor('#538292'),
                // onPrimary: HexColor('#40e0d0'),
                primary: HexColor('#538292'),
              ),
              child: const AutoSizeText(
                'Filtrar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
