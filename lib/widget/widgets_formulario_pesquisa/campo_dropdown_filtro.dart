import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_dropdown_item.dart';
import 'package:flutter/material.dart';

class CampoDropdownFiltro extends StatelessWidget {
  final String titulo;
  final List<String> itens;
  final int indSelecionado;
  final Function(int) selecionar;
  const CampoDropdownFiltro(
      this.titulo, this.itens, this.indSelecionado, this.selecionar,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: alturaPadding * 0.4,
          width: largura * 0.25,
          child: Center(
            child: CabecalhoForm(
              titulo,
              corTexto: '#293949',
              tamanhoFonte: 20,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: larguraPadding * 0.1),
          child: SizedBox(
            width: largura * 0.32,
            height: alturaPadding * 0.4,
            child: Center(
              child: CampoDropDownItem(
                const Icon(Icons.arrow_drop_down_outlined),
                itens,
                indSelecionado,
                alturaPadding,
                selecionar,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
