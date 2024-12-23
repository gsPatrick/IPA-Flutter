import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/model/indices_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:flutter/material.dart';

class FormCheckBoxAnuncio extends StatefulWidget {
  final ControleFormAnuncio controle;
  final tituloCadastro = 'Selecione adicionais que seu imóvel oferece';
  final tituloPesquisa = 'Selecione adicionais que procura no imóvel';
  final bool ehPesquisa;
  final Function() avancar, voltar;
  const FormCheckBoxAnuncio(this.controle, this.avancar, this.voltar,
      {this.ehPesquisa = false, super.key});

  @override
  State<FormCheckBoxAnuncio> createState() => _FormCheckBoxAnuncioState();
}

class _FormCheckBoxAnuncioState extends State<FormCheckBoxAnuncio> {
  List<AdicionaisCheckBoxItem> itens = IndicesAnuncios().itens;

  alterarIndice(Function(bool) alterar, bool foiSelecionado) {
    setState(() {
      alterar(foiSelecionado);
    });
  }

  selecionarAlteracao(int indice, bool foiSelecionado) {
    switch (indice) {
      case 0:
        alterarIndice(widget.controle.anuncio.altRespGaragem, foiSelecionado);
        break;
      case 1:
        alterarIndice(widget.controle.anuncio.altRespPiscina, foiSelecionado);

        break;
      case 2:
        alterarIndice(widget.controle.anuncio.altRespAreaLazer, foiSelecionado);

        break;
      case 3:
        alterarIndice(widget.controle.anuncio.altCondIncluso, foiSelecionado);

        break;
      case 4:
        alterarIndice(widget.controle.anuncio.altIptuIncluso, foiSelecionado);

        break;
      case 5:
        alterarIndice(widget.controle.anuncio.altProxPraia, foiSelecionado);

        break;
      case 6:
        alterarIndice(widget.controle.anuncio.altTemPortaria, foiSelecionado);

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: altura * 0.9,
      width: largura * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: larguraPadding * 0.5,
                vertical: alturaPadding * 0.02),
            child: SizedBox(
              height: alturaPadding * 0.5,
              child: Center(
                child: CabecalhoForm(
                  widget.ehPesquisa
                      ? widget.tituloPesquisa
                      : widget.tituloCadastro,
                  corTexto: '#293949',
                  tamanhoFonte: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            height: alturaPadding * 0.15,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itens.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: largura * 0.5,
                      child: Text(
                        itens[index].nome,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: largura * 0.2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            itens[index].foiSelecionado =
                                !itens[index].foiSelecionado;
                            selecionarAlteracao(
                                index, itens[index].foiSelecionado);
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: itens[index].foiSelecionado
                                  ? Colors.transparent
                                  : Colors.black,
                              width: 3.0,
                            ),
                            color: itens[index].foiSelecionado
                                ? Colors.green
                                : Colors.white,
                          ),
                          child: itens[index].foiSelecionado
                              ? const Icon(Icons.check_outlined,
                                  color: Colors.white)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: alturaPadding * 0.25,
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
                  titulo: widget.ehPesquisa ? 'Concluir' : 'Avançar',
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
