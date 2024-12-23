import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_form_texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CampoFormDescricao extends StatelessWidget {
  final ControleFormAnuncio controle;
  final Function() avancar, voltar;
  const CampoFormDescricao(this.controle, this.avancar, this.voltar,
      {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return SingleChildScrollView(
      child: Container(
          height: altura * 0.65,
          width: largura * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Observer(builder: (_) {
            return Column(
              children: [
                SizedBox(
                  height: alturaPadding * 0.4,
                  child: const Center(
                    child: CabecalhoForm(
                      'Descrição:',
                      corTexto: '#293949',
                      tamanhoFonte: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: alturaPadding * 0.15,
                ),
                SizedBox(
                  height: altura * 0.35,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: larguraPadding * 0.3),
                      child: CampoFormTexto(
                        labelText: 'Descrição',
                        onchanged: controle.anuncio.alterarDescricao,
                        callBackErrorText: controle.validaDescricao,
                        maxCaracteres: 360,
                        maxLines: 8,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: alturaPadding * 0.3,
                ),
                SizedBox(
                  height: alturaPadding * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: largura * 0.38,
                        child: BtnFormAnuncio(
                          submeter: voltar,
                          titulo: 'Voltar',
                          formPreenchido: true,
                          corBotao: '#56828f',
                        ),
                      ),
                      SizedBox(
                        width: largura * 0.38,
                        child: BtnFormAnuncio(
                          submeter: avancar,
                          titulo: 'Avançar',
                          formPreenchido: controle.anuncio.descricao.isNotEmpty,
                          corBotao: '#56828f',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          })),
    );
  }
}
