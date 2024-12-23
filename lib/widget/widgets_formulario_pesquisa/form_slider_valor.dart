import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';

class FormSliderValor extends StatefulWidget {
  final bool tipoAnuncio;
  final ControleFormAnuncio controle;
  final Function() avancar, voltar;
  const FormSliderValor(
      this.controle, this.avancar, this.voltar, this.tipoAnuncio,
      {super.key});

  @override
  State<FormSliderValor> createState() => _FormSliderValorState();
}

class _FormSliderValorState extends State<FormSliderValor> {
  bool carregando = true;
  List<double> valAluguel = [];
  List<double> valCompra = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // carregarLista();

    // Cálculo dos valores para compra
  }

  carregarLista() {
    double valInicial = 0;
    valAluguel = List.generate(10, (index) {
      if (index < 9) {
        return (375 * index.toDouble());
      } else {
        return (1000 * index.toDouble());
      }
    });
    valCompra = List.generate(10, (index) => 100000.0 + (index * 90000));
    valAluguel.forEach((value) {
      print(value.toString());
    });
    setState(() {
      carregando = false;
    });
  }

  double _sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: altura * 0.4,
      width: largura * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: altura * 0.1,
            child: const Center(
              child: CabecalhoForm(
                'Informe até que valor procura :',
                corTexto: '#293949',
                tamanhoFonte: 22,
              ),
            ),
          ),
          Container(
            height: altura * 0.1,
            child: FlutterSlider(
              values: [_sliderValue],
              max: widget.tipoAnuncio ? 1000000 : 4000,
              min: 0,
              tooltip: FlutterSliderTooltip(disabled: true),
              onDragging: (index, lowerValue, upperValue) {
                setState(() {
                  _sliderValue = lowerValue;
                  widget.controle.anuncio.valorReal = _sliderValue;
                });
              },
              trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 8,
                inactiveTrackBarHeight: 6,
                inactiveTrackBar: BoxDecoration(
                  color: Colors.black,
                ),
                activeTrackBar: BoxDecoration(
                  color: HexColor('#56828f'),
                ),
              ),
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                  color: HexColor('#56828f'),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2)],
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  // child: Icon(Icons.star, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: altura * 0.05,
            alignment: Alignment.center,
            child: Text(
              // 'R\$ ${_sliderValue.toString()}',
              'R\$ ${NumberFormat("#,##0", "pt_BR").format(_sliderValue.toInt())}',
              style: TextStyle(
                fontSize: 25,
                color: HexColor('#56828f'),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: alturaPadding * 0.1),
            child: Container(
              height: altura * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: largura * 0.35,
                    child: BtnFormAnuncio(
                      submeter: widget.voltar,
                      titulo: 'Voltar',
                      formPreenchido: true,
                      corBotao: '#56828f',
                    ),
                  ),
                  SizedBox(
                    width: largura * 0.38,
                    child: BtnFormAnuncio(
                      submeter: widget.avancar,
                      titulo: 'Avançar',
                      formPreenchido: true,
                      corBotao: '#56828f',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
