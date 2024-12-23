import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_form_texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FormTitulo extends StatelessWidget {
  final ControleFormAnuncio controle;
  final Function() avancar;
  const FormTitulo(this.controle, this.avancar, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: altura * 0.45,
      width: largura * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Container(
            height: altura * 0.1,
            child: const Center(
              child: CabecalhoForm(
                'Título do anúncio:',
                corTexto: '#293949',
              ),
            ),
          ),
          Observer(builder: (_) {
            return SizedBox(
              height: altura * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: larguraPadding * 0.3),
                      child: CampoFormTexto(
                        labelText: 'Titulo',
                        nomeEditavel: controle.anuncio.tituloAnuncio,
                        onchanged: controle.anuncio.alterarTituloAnunc,
                        callBackErrorText: controle.validaTituloAnuncio,
                        maxCaracteres: 40,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: larguraPadding * 0.7),
                    child: BotaoFormulario(
                      submeter: avancar,
                      titulo: 'Avançar',
                      formPreenchido: controle.anuncio.tituloAnuncio.isNotEmpty,
                      corBotao: '#56828f',
                    ),
                  )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
