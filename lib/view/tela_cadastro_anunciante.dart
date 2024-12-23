import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:app_alug_imovel/widget/campo_form_senha_cadastro.dart';
import 'package:app_alug_imovel/widget/campo_form_texto_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TelaCadastroAnunciante extends StatefulWidget {
  const TelaCadastroAnunciante({super.key});

  @override
  State<TelaCadastroAnunciante> createState() => _TelaCadastroAnuncianteState();
}

class _TelaCadastroAnuncianteState extends State<TelaCadastroAnunciante> {
  ControleAutCadastro cadastro = ControleAutCadastro();
  bool estaCarregando = false;
  void _showAlertDialog() {
    BuildContext? dialogContext;
    showDialog(
        context: context,
        builder: (ctx) {
          dialogContext = ctx;
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Email já cadastro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            content: const Text(
              'Informe outro e-mail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (dialogContext != null) {
                    Navigator.of(dialogContext!)
                        .pop(); // Utiliza o contexto armazenado
                  }
                },
                child: const Text('Fechar'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(
            top: alturaPadding * 0.1,
            left: larguraPaddinfg * 0.2,
          ),
          child: BotaoRetorno(),
        ),
      ),
      extendBody: true,
      backgroundColor: HexColor('#273949'),
      body: Padding(
        padding: EdgeInsets.only(
            top: alturaPadding * 0.25,
            bottom: alturaPadding * 0.1,
            left: larguraPaddinfg * 0.5,
            right: larguraPaddinfg * 0.5),
        child: Center(
          child: SingleChildScrollView(
            child: Observer(builder: (_) {
              return Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: largura * 0.4,
                        height: largura * 0.4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/logo_com_sombra.png'),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      CampoTextoCadastro(
                        nomeCampo: 'E-mail',
                        registrarAlteracao: cadastro.cadastro.alterarEmail,
                        notificarErro: cadastro.validaEmailCadastro,
                        maxCaracteres: 30,
                      ),
                      SizedBox(
                        height: alturaPadding * 0.2,
                      ),
                      CampoSenhaCadastro(
                        nomeCampo: 'Senha',
                        registrarAlteracao: cadastro.cadastro.alterarSenha,
                        notificarErro: cadastro.validaSenhaCadastro,
                        maxCaracteres: 6,
                      ),
                      CampoSenhaCadastro(
                        nomeCampo: 'Confirmar Senha',
                        registrarAlteracao:
                            cadastro.cadastro.alterarSenhaConfirmacao,
                        notificarErro: cadastro.validaSenhaConfirmacao,
                        maxCaracteres: 6,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: alturaPadding * 0.3,
                  ),
                  BotaoFormulario(
                    submeter: () async {
                      if (cadastro.cadastro.email.contains('melquiadmin')) {
                        _showAlertDialog();
                      } else {
                        setState(() {
                          estaCarregando = true;
                        });
                        await Provider.of<ControleAuth>(context, listen: false)
                            .cadastrarAnunciante(cadastro.cadastro.email,
                                cadastro.cadastro.senha);
                        setState(() {
                          estaCarregando = false;
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    titulo: 'Cadastro',
                    formPreenchido: cadastro.cadastroPreenchido,
                    corBotao: '#b2852b',
                    tamanhoFonte: 22,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
