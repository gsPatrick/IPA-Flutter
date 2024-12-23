import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:flutter/material.dart';

class SpamCardInicial extends StatelessWidget {
  final Function() cadastrar;
  const SpamCardInicial(this.cadastrar, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
        height: altura * 0.32,
        width: largura * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(29),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: larguraPaddinfg * 0.25),
                child: Text(
                  'Você ainda não cadastrou nenhum imóvel para anunciar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: alturaPadding * 0.2,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: larguraPaddinfg * 0.25),
                child: BotaoFormulario(
                  submeter: cadastrar,
                  titulo: 'Adicionar',
                  formPreenchido: true,
                  corBotao: '#b2852b',
                  tamanhoFonte: 18,
                ),
              ),
            ],
          ),
        ));
  }
}
