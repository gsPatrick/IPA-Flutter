import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FormCompraAluguel extends StatefulWidget {
  final ControleFormAnuncio controle;
  final List<String> tipoCompra;
  final Function() avancar, voltar;
  const FormCompraAluguel(
      this.controle, this.tipoCompra, this.avancar, this.voltar,
      {super.key});

  @override
  State<FormCompraAluguel> createState() => _FormCompraAluguelState();
}

class _FormCompraAluguelState extends State<FormCompraAluguel> {
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: altura * 0.6,
      width: largura * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Observer(builder: (_) {
        return Column(
          children: [
            SizedBox(
              height: altura * 0.1,
              child: const Center(
                child: CabecalhoForm(
                  'O que está procurando ?',
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
                itemCount: widget.tipoCompra.length,
                itemBuilder: ((context, index) {
                  String categoria = widget.tipoCompra[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: larguraPadding,
                      vertical: alturaPadding * 0.05,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.controle.anuncio.alterarIndOpcValor(index);
                          print('tipo compra : ${widget.tipoCompra[index]}');
                          widget.controle.anuncio
                              .alterarehCompra(index == 0 ? false : true);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: alturaPadding * 0.25,
                        width: largura * 0.5,
                        decoration: BoxDecoration(
                          color: widget.controle.anuncio.indOpcValor == index
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
                            color: widget.controle.anuncio.indOpcValor == index
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
        );
      }),
    );
  }
}
