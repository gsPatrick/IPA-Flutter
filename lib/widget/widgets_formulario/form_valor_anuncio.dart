import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/campo_form_dinheiro.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FormValorImovelAnuncio extends StatefulWidget {
  final ControleFormAnuncio controle;
  final List<String> opcValores;

  final Function() avancar, voltar;
  const FormValorImovelAnuncio(
      this.controle, this.opcValores, this.avancar, this.voltar,
      {super.key});

  @override
  State<FormValorImovelAnuncio> createState() => _FormValorImovelAnuncioState();
}

class _FormValorImovelAnuncioState extends State<FormValorImovelAnuncio> {
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return SingleChildScrollView(
      child: Container(
          height: altura * 0.75,
          width: largura * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Observer(builder: (_) {
            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: altura * 0.1,
                      child: const Center(
                        child: CabecalhoForm(
                          'Valor:',
                          corTexto: '#293949',
                          tamanhoFonte: 27,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: altura * 0.1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: larguraPadding * 0.4,
                        ),
                        child: CampoFormDinheiro(
                          nomeCampo: 'Valor',
                          registrarAlteracao:
                              widget.controle.anuncio.alterarValor,
                          notificarErro: widget.controle.validaValor,
                          maxCaracteres: 11,
                          informacaoInicial: 'R\$ 00,00',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: alturaPadding * 0.2,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: altura * 0.1,
                      child: const Center(
                        child: CabecalhoForm(
                          'Selecione uma opção referente ao valor :',
                          corTexto: '#293949',
                          tamanhoFonte: 22,
                        ),
                      ),
                    ),
                    Container(
                      height: altura * 0.3,
                      color: Colors.white,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.opcValores.length,
                        itemBuilder: ((context, index) {
                          String opcValor = widget.opcValores[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: larguraPadding,
                              vertical: alturaPadding * 0.05,
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.controle.anuncio
                                      .alterarIndOpcValor(index);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: alturaPadding * 0.3,
                                width: largura * 0.5,
                                decoration: BoxDecoration(
                                  color: widget.controle.anuncio.indOpcValor ==
                                          index
                                      ? HexColor('#293949')
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: HexColor('#293949'), width: 3.0),
                                ),
                                child: AutoSizeText(
                                  opcValor,
                                  minFontSize: 14,
                                  style: TextStyle(
                                    color:
                                        widget.controle.anuncio.indOpcValor ==
                                                index
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
                  ],
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
                        formPreenchido:
                            widget.controle.anuncio.valor != 'R\$ 0,00',
                        corBotao: '#56828f',
                      ),
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}
