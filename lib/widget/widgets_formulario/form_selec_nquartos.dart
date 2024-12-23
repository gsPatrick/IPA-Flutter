import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:flutter/material.dart';

class FormSelecNQuartos extends StatefulWidget {
  final ControleFormAnuncio controle;
  final Function() avancar, voltar;
  const FormSelecNQuartos(this.controle, this.avancar, this.voltar,
      {super.key});

  @override
  State<FormSelecNQuartos> createState() => _FormSelecNQuartosState();
}

class _FormSelecNQuartosState extends State<FormSelecNQuartos> {
  final List<int> numeros = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;

    return Container(
      height: altura * 0.45,
      width: largura * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          SizedBox(
            height: altura * 0.1,
            child: const Center(
              child: CabecalhoForm(
                'Quartos:',
                corTexto: '#293949',
                tamanhoFonte: 25,
              ),
            ),
          ),
          SizedBox(
            height: altura * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: numeros.map((number) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controle.anuncio.alterarNQuarto(number);
                    });
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: widget.controle.anuncio.nQuarto == number
                        ? HexColor('#293949')
                        : Colors.grey.shade400,
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        color: widget.controle.anuncio.nQuarto == number
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: alturaPadding * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: largura * 0.38,
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
                  formPreenchido: widget.controle.anuncio.nQuarto > 0,
                  corBotao: '#56828f',
                ),
              ),
            ],
          ),
          SizedBox(
            height: alturaPadding * 0.2,
          ),
        ],
      ),
    );
  }
}
