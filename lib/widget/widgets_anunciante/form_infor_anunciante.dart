import 'dart:io';

import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/campo_com_foto.dart';
import 'package:app_alug_imovel/widget/campo_form_celular.dart';
import 'package:app_alug_imovel/widget/campo_form_texto_cadastro.dart';
import 'package:app_alug_imovel/widget/campo_sem_foto.dart';
import 'package:app_alug_imovel/widget/spam_card_inicial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormInfoAnunciante extends StatefulWidget {
  final Function(bool estaCarregando) colocarEmLoading;
  const FormInfoAnunciante(this.colocarEmLoading, {super.key});

  @override
  State<FormInfoAnunciante> createState() => _FormInfoAnuncianteState();
}

class _FormInfoAnuncianteState extends State<FormInfoAnunciante> {
  bool primeiraVez = true;
  bool naoTemFoto = true;
  ControleAutCadastro controleCadastro = ControleAutCadastro();
  File? photo;
  final ImagePicker _picker = ImagePicker();

  Future importarFotoGaleria() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      child: primeiraVez
          ? SpamCardInicial(() {
              setState(() {
                primeiraVez = false;
              });
            })
          : Container(
              height: altura * 0.6,
              width: largura * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
              ),
              child: Observer(
                builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: largura * 0.8,
                            child: Column(
                              children: [
                                CampoTextoCadastro(
                                  nomeCampo: 'Nome',
                                  registrarAlteracao: controleCadastro
                                      .cadastroCompl.alterarNome,
                                  notificarErro: controleCadastro.validaNome,
                                  maxCaracteres: 20,
                                  corTexto: '#112F47',
                                ),
                                SizedBox(
                                  height: alturaPadding * 0.2,
                                ),
                                CampoFormCelular(
                                  nomeCampo: 'Contato',
                                  registrarAlteracao: controleCadastro
                                      .cadastroCompl.alterarContato,
                                  notificarErro:
                                      controleCadastro.validaNumeroCelular,
                                  maxCaracteres: 11,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: alturaPadding * 0.1,
                                horizontal: larguraPadding * 0.1),
                            child: SizedBox(
                              width: largura * 0.8,
                              child: naoTemFoto
                                  ? CampoSemFoto(() async {
                                      await importarFotoGaleria();
                                      setState(() {
                                        naoTemFoto = false;
                                      });
                                    })
                                  : CampoComFoto(photo!, () async {
                                      await importarFotoGaleria();
                                    }),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: larguraPadding * 0.5,
                        ),
                        child: BotaoFormulario(
                          submeter: () async {
                            widget.colocarEmLoading(true);
                            await Provider.of<ControleAuth>(context,
                                    listen: false)
                                .cadastroComplementar(
                              photo!,
                              controleCadastro.cadastroCompl.nome,
                              controleCadastro.cadastroCompl.contato,
                            );
                            widget.colocarEmLoading(false);
                          },
                          titulo: 'Cadastrar',
                          formPreenchido:
                              controleCadastro.cadastroComplPreenchido,
                          corBotao: '#b2852b',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}
