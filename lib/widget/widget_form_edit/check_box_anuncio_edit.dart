import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/model/indices_anuncio.dart';
import 'package:app_alug_imovel/model/model_form_anuncio.dart';
import 'package:app_alug_imovel/widget/btn_transp_borda.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:flutter/material.dart';

class CheckBoxAnuncioEdit extends StatefulWidget {
  final ControleFormAnuncio controle;
  final Function() avancar, voltar;
  const CheckBoxAnuncioEdit(this.controle, this.avancar, this.voltar,
      {super.key});

  @override
  State<CheckBoxAnuncioEdit> createState() => _CheckBoxAnuncioEditState();
}

class _CheckBoxAnuncioEditState extends State<CheckBoxAnuncioEdit> {
  List<AdicionaisCheckBoxItem>? itens;

  @override
  void initState() {
    super.initState();
    gerarLista();
  }

  gerarLista() {
    ModelFormAnuncio anuncioEdit = widget.controle.anuncio;
    itens = [
      AdicionaisCheckBoxItem(
          nome: 'Garagem', foiSelecionado: anuncioEdit.temGaragem),
      AdicionaisCheckBoxItem(
          nome: 'Piscina', foiSelecionado: anuncioEdit.temPiscina),
      AdicionaisCheckBoxItem(
          nome: 'Área de lazer', foiSelecionado: anuncioEdit.temAreaLazer),
      AdicionaisCheckBoxItem(
          nome: 'Condomínio incluso',
          foiSelecionado: anuncioEdit.temCondIncluso),
      AdicionaisCheckBoxItem(
          nome: 'IPTU Incluso', foiSelecionado: anuncioEdit.temIptuIncluso),
      AdicionaisCheckBoxItem(
          nome: 'Próximo a Praia', foiSelecionado: anuncioEdit.ehProxPraia),
      AdicionaisCheckBoxItem(
          nome: 'Portaria', foiSelecionado: anuncioEdit.temPortaria),
    ];
  }

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
    return Scaffold(
      body: Center(
        child: Container(
          height: altura * 0.75,
          width: largura * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: larguraPadding * 0.5,
                    vertical: alturaPadding * 0.1),
                child: SizedBox(
                  height: altura * 0.1,
                  child: const Center(
                    child: CabecalhoForm(
                      'Selecione adicionais que seu imóvel oferece',
                      corTexto: '#293949',
                      tamanhoFonte: 25,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itens!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: largura * 0.5,
                          child: Text(
                            itens![index].nome,
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
                                itens![index].foiSelecionado =
                                    !itens![index].foiSelecionado;
                                selecionarAlteracao(
                                    index, itens![index].foiSelecionado);
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: itens![index].foiSelecionado
                                      ? Colors.transparent
                                      : Colors.black,
                                  width: 3.0,
                                ),
                                color: itens![index].foiSelecionado
                                    ? Colors.green
                                    : Colors.white,
                              ),
                              child: itens![index].foiSelecionado
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
                height: alturaPadding * 0.3,
              ),
              SizedBox(
                width: largura * 0.45,
                child: BtnTranspBorda(
                  submeter: () {
                    Navigator.of(context).pop();
                  },
                  titulo: 'Voltar',
                  formPreenchido: true,
                  corBotao: '#ffffff',
                  corBorda: '#495664',
                  corTexto: '#495664',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
