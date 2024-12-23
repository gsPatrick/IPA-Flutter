import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_dropdown_item.dart';
import 'package:flutter/material.dart';

class FormDropdownBairro extends StatefulWidget {
  final List<String> itens;
  final ControleFormAnuncio controle;
  final Function() avancar, voltar;
  const FormDropdownBairro(this.itens, this.controle, this.avancar, this.voltar,
      {super.key});

  @override
  State<FormDropdownBairro> createState() => _FormDropdownBairroState();
}

class _FormDropdownBairroState extends State<FormDropdownBairro> {
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
        children: [
          SizedBox(
            height: altura * 0.1,
            child: const Center(
              child: CabecalhoForm(
                'Bairro:',
                corTexto: '#293949',
                tamanhoFonte: 24,
              ),
            ),
          ),
          SizedBox(
            height: alturaPadding * 0.2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: larguraPadding * 0.5),
            child: CampoDropDownItem(
              Icon(Icons.arrow_drop_down_outlined),
              widget.itens,
              widget.controle.anuncio.indBairro,
              alturaPadding,
              (value) {
                setState(() {
                  widget.controle.anuncio.alterarIndBairro(value);
                });
              },
            ),
          ),
          SizedBox(
            height: alturaPadding * 0.5,
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
                  formPreenchido: true,
                  corBotao: '#56828f',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
