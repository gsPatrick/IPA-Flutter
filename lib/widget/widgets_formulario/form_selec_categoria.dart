import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';

import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FormSelecCategoria extends StatefulWidget {
  final ControleFormAnuncio controle;
  final List<String> categorias;

  final Function() avancar, voltar;

  const FormSelecCategoria(
      this.controle, this.categorias, this.avancar, this.voltar,
      {super.key});

  @override
  State<FormSelecCategoria> createState() => _FormSelecCategoriaState();
}

class _FormSelecCategoriaState extends State<FormSelecCategoria> {
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return SingleChildScrollView(
      child: Container(
        height: altura * 0.6,
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
                  'Selecione uma categoria:',
                  corTexto: '#293949',
                ),
              ),
            ),
            Container(
              height: altura * 0.4,
              color: Colors.white,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.categorias.length,
                itemBuilder: ((context, index) {
                  String categoria = widget.categorias[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: larguraPadding,
                      vertical: alturaPadding * 0.05,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.controle.anuncio.alterarIndCategoria(index);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: alturaPadding * 0.25,
                        width: largura * 0.5,
                        decoration: BoxDecoration(
                          color: widget.controle.anuncio.indCategoria == index
                              ? HexColor('#293949')
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: HexColor('#293949'), width: 3.0),
                        ),
                        child: AutoSizeText(
                          categoria,
                          minFontSize: 14,
                          style: TextStyle(
                            color: widget.controle.anuncio.indCategoria == index
                                ? Colors.white
                                : HexColor('#293949'),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
