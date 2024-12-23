import 'dart:io';

import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/model/model_cadastro_compl.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/btn_transp_borda.dart';
import 'package:app_alug_imovel/widget/campo_com_foto.dart';
import 'package:app_alug_imovel/widget/campo_form_celular.dart';
import 'package:app_alug_imovel/widget/campo_form_texto_cadastro.dart';
import 'package:app_alug_imovel/widget/foto_url_perfil.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TelaEditarPerfilAnunciante extends StatefulWidget {
  final ControleAuth anunciante;
  const TelaEditarPerfilAnunciante(this.anunciante, {super.key});

  @override
  State<TelaEditarPerfilAnunciante> createState() =>
      _TelaEditarPerfilAnuncianteState();
}

class _TelaEditarPerfilAnuncianteState
    extends State<TelaEditarPerfilAnunciante> {
  bool primeiraVez = true;
  bool fotoUrl = true;
  bool estaCarregando = false;
  ControleAutCadastro controleCadastro = ControleAutCadastro();
  ControleAuth? controleAut;
  File? photo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inicializarController();
  }

  inicializarController() {
    controleAut = Provider.of<ControleAuth>(context, listen: false);
    controleCadastro.cadastroCompl = ModelCadastroCompl(
      nome: controleAut!.nome!,
      contato: controleAut!.contato!,
    );
  }

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
    return estaCarregando
        ? Scaffold(
            backgroundColor: HexColor('#273949'),
            extendBody: true,
            body: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                color: Colors.white,
                value: 50,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            extendBody: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: alturaPadding * 0.4,
                  bottom: alturaPadding * 0.2,
                  left: larguraPadding * 0.1,
                  right: larguraPadding * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: alturaPadding * 0.5,
                      child: const Center(
                        child: CabecalhoForm(
                          'Editar Informações',
                          corTexto: '#293949',
                          tamanhoFonte: 28,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      height: altura * 0.6,
                      child: controleCadastro == null
                          ? Container(
                              color: Colors.pink,
                            )
                          : Observer(
                              builder: (_) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: largura * 0.8,
                                          child: Column(
                                            children: [
                                              CampoTextoCadastro(
                                                nomeCampo: 'Nome',
                                                registrarAlteracao:
                                                    controleCadastro
                                                        .cadastroCompl
                                                        .alterarNome,
                                                notificarErro:
                                                    controleCadastro.validaNome,
                                                maxCaracteres: 20,
                                                corTexto: '#112F47',
                                                textoInicial: controleCadastro
                                                    .cadastroCompl.nome,
                                              ),
                                              SizedBox(
                                                height: alturaPadding * 0.2,
                                              ),
                                              CampoFormCelular(
                                                nomeCampo: 'Contato',
                                                registrarAlteracao:
                                                    controleCadastro
                                                        .cadastroCompl
                                                        .alterarContato,
                                                notificarErro: controleCadastro
                                                    .validaNumeroCelular,
                                                maxCaracteres: 11,
                                                informacaoInicial:
                                                    controleCadastro
                                                        .cadastroCompl.contato,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: alturaPadding * 0.2,
                                              // bottom: alturaPadding * 0.1,
                                              left: larguraPadding * 0.1,
                                              right: larguraPadding * 0.1),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: alturaPadding * 0.3,
                                                child: const Center(
                                                  child: CabecalhoForm(
                                                    'Foto de perfil',
                                                    corTexto: '#293949',
                                                    tamanhoFonte: 21,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: alturaPadding * 0.125,
                                              ),
                                              SizedBox(
                                                width: largura * 0.8,
                                                child: fotoUrl
                                                    ? FotoUrlPerfil(
                                                        () async {
                                                          await importarFotoGaleria();
                                                          setState(() {
                                                            fotoUrl = false;
                                                          });
                                                        },
                                                        controleAut!
                                                            .urlFotoPerfil!,
                                                      )
                                                    : CampoComFoto(
                                                        photo!,
                                                        () async {
                                                          await importarFotoGaleria();
                                                        },
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                    SizedBox(
                      height: alturaPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: largura * 0.38,
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
                          SizedBox(
                            width: largura * 0.38,
                            child: BtnFormAnuncio(
                              submeter: () async {
                                setState(() {
                                  estaCarregando = true;
                                });
                                await Provider.of<ControleAuth>(context,
                                        listen: false)
                                    .editarAnunciante(
                                  fotoUrl,
                                  fotoUrl ? File('') : photo!,
                                  controleCadastro.cadastroCompl.nome,
                                  controleCadastro.cadastroCompl.contato,
                                );
                                // await Provider.of<ControleAuth>(context,
                                //         listen: false)
                                //     .editarAnunciante();

                                setState(() {
                                  estaCarregando = false;
                                });
                                Navigator.of(context).pop();
                              },
                              titulo: 'Alterar',
                              formPreenchido: true,
                              corBotao: '#14870c',
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
