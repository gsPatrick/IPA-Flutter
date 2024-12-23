import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/util/rotas_nomeadas.dart';
import 'package:app_alug_imovel/view/login_ou_incial_anunciante.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:app_alug_imovel/widget/btn_transp_borda.dart';
import 'package:app_alug_imovel/widget/campo_form_senha_cadastro.dart';
import 'package:app_alug_imovel/widget/campo_form_texto_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TelaLoginAnunciante extends StatefulWidget {
  const TelaLoginAnunciante({super.key});

  @override
  State<TelaLoginAnunciante> createState() => _TelaLoginAnuncianteState();
}

class _TelaLoginAnuncianteState extends State<TelaLoginAnunciante> {
  ControleAutCadastro login = ControleAutCadastro();
  bool checkSelecionado = false;
  bool carregandoTela = true;
  // bool autenticando = false;

  // bool anuncianteLogado = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showErrorDialog() {
    BuildContext? dialogContext;
    showDialog(
        context: context,
        builder: (ctx) {
          dialogContext = ctx;
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Email ou senha incorretos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: const Text(
              'Favor informar e-mail e senha novamente',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        });
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Conta Desativada',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Procure o administrador para maiores esclarecimentos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void showMessage(String faseMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'login ocorrencia',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'situacao : $faseMessage',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    // clienteLogado =
    //     Provider.of<ControleAuth>(context).clienteLogado ?? clienteLogado;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(
            top: alturaPadding * 0.1,
            left: larguraPadding * 0.2,
          ),
          child: BotaoRetorno(),
        ),
      ),
      extendBody: true,
      backgroundColor: HexColor('#273949'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: alturaPadding * 0.02, horizontal: larguraPadding * 0.5),
        child: Center(
          child: SingleChildScrollView(
            child: Observer(builder: (_) {
              return Column(
                children: [
                  Container(
                    width: largura * 0.4,
                    height: largura * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo_com_sombra.png'),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CampoTextoCadastro(
                        nomeCampo: 'E-mail',
                        registrarAlteracao: login.login.alterarEmail,
                        notificarErro: login.validadeEmailLogin,
                        maxCaracteres: 30,
                        corTexto: '#ffffff',
                      ),
                      SizedBox(
                        height: alturaPadding * 0.2,
                      ),
                      CampoSenhaCadastro(
                        nomeCampo: 'Senha',
                        registrarAlteracao: login.login.alterarSenha,
                        notificarErro: login.validaSenhaLogin,
                        maxCaracteres: 6,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: alturaPadding * 0.1,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(bottom: alturaPadding * 0.3),
                  //   child: Container(
                  //     alignment: Alignment.topLeft,
                  //     child: Row(
                  //       children: [
                  //         GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               checkSelecionado = !checkSelecionado;
                  //             });
                  //           },
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             width: 25,
                  //             height: 25,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.rectangle,
                  //               border: Border.all(
                  //                 color: Colors.white,
                  //                 width: 2.0,
                  //               ),
                  //               color: checkSelecionado
                  //                   ? HexColor('#b2852b')
                  //                   : Colors.transparent,
                  //             ),
                  //             child: checkSelecionado
                  //                 ? const Icon(Icons.check_outlined,
                  //                     color: Colors.white)
                  //                 : null,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: larguraPadding * 0.1,
                  //         ),
                  //         Text(
                  //           'Sou administrador',
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 18),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  BotaoFormulario(
                    submeter: () async {
                      // setState(() {
                      //   autenticando = true;
                      // });

                      ControleAuth controleAut =
                          Provider.of<ControleAuth>(context, listen: false);
                      // showMessage('login sendo iniciado');
                      if (login.login.email.contains('melquiadmin')) {
                        // showMessage('login admin sendo iniciado');
                        await controleAut.autenticarAdministrador(
                            login.login.email, login.login.senha);
                        if (controleAut.falhaAutenticacao) {
                          _showErrorDialog();
                        } else {
                          //Codigo provisorio
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AutLoginAnunciante()),
                          ).then((_) {
                            Navigator.pop(
                                context); // Remove a tela substituída da pilha
                          });
                          //Codigo provisorio
                        }
                      } else {
                        // showMessage('login anunciante sendo iniciado');
                        await controleAut.autenticarAnunciante(
                            login.login.email, login.login.senha);
                        if (controleAut.falhaAutenticacao) {
                          _showErrorDialog();
                        } else {
                          //Codigo provisorio
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AutLoginAnunciante()),
                          ).then((_) {
                            Navigator.pop(
                                context); // Remove a tela substituída da pilha
                          });
                          //Codigo provisorio
                        }

                        if (controleAut.permissaoAnuncio! &&
                            !controleAut.ehAtivo!) {
                          _showConfirmDialog();
                        }
                        // showMessage(
                        //     'dados atuais token : ${controleAut.token} eh admin ${controleAut.adminLogado} eh anunciante :${controleAut.anuncianteLogado}  rota atual : ${Navigator.of(context).toString()}');
                        //codigo alternativo
                        // Navigator.of(context).pop();
                        //codigo alternativo
                        // setState(() {
                        //   autenticando = false;
                        // });
                      }

                      // checkSelecionado
                      //     ? await Provider.of<ControleAuth>(context,
                      //             listen: false)
                      //         .autenticarAdministrador(
                      //             login.login.email, login.login.senha)
                      //     : await Provider.of<ControleAuth>(context,
                      //             listen: false)
                      //         .autenticarAnunciante(
                      //             login.login.email, login.login.senha);
                      // Navigator.of(context)
                      //     .pushNamed(RotasNomeadas.TELAINICIALANUNCIANTE);
                    },
                    titulo: 'Login',
                    formPreenchido: login.loginPreenchido,
                    corBotao: '#b2852b',
                    tamanhoFonte: 22,
                  ),
                  SizedBox(
                    height: alturaPadding * 0.15,
                  ),
                  BtnTranspBorda(
                    submeter: () {
                      Navigator.of(context).pushNamed(RotasNomeadas.CADASTRO);
                    },
                    titulo: 'Cadastre-se',
                    formPreenchido: true,
                    corBotao: '#273949',
                    tamanhoFonte: 22,
                    corBorda: '#b2852b',
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
