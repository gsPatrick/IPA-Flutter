import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/campo_form_senha_cadastro.dart';
import 'package:app_alug_imovel/widget/campo_form_texto_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FormLoginCliente extends StatefulWidget {
  // final Function() concluirOperacao, loading;
  final Function() autenticacao;
  const FormLoginCliente(
      // this.concluirOperacao, this.loading,
      this.autenticacao,
      {super.key});

  @override
  State<FormLoginCliente> createState() => _FormLoginClienteState();
}

class _FormLoginClienteState extends State<FormLoginCliente> {
  ControleAutCadastro controleLogin = ControleAutCadastro();

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

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      child: Observer(builder: (_) {
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
                        nomeCampo: 'E-mail',
                        registrarAlteracao: controleLogin.login.alterarEmail,
                        notificarErro: controleLogin.validadeEmailLogin,
                        maxCaracteres: 30,
                        corTexto: '#112F47',
                      ),
                      CampoSenhaCadastro(
                        nomeCampo: 'Senha',
                        registrarAlteracao: controleLogin.login.alterarSenha,
                        notificarErro: controleLogin.validaSenhaLogin,
                        maxCaracteres: 6,
                        corTexto: '#112F47',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: larguraPadding * 0.35,
                right: larguraPadding * 0.35,
                top: alturaPadding * 0.15,
              ),
              child: BotaoFormulario(
                submeter: () async {
                  ControleAuth controleAut =
                      Provider.of<ControleAuth>(context, listen: false);
                  await controleAut.autenticarCliente(
                      controleLogin.login.email, controleLogin.login.senha);
                  if (controleAut.falhaAutenticacao) {
                    _showErrorDialog();
                  } else {
                    await widget.autenticacao();
                    // widget.loading();
                    // Provider.of<ControleAnuncio>(context, listen: false)
                    //     .sairSessao();
                    // widget.concluirOperacao();
                  }

                  // if () {

                  // } else {

                  // }

                  // widget.colocarEmLoading(true);
                  // await Provider.of<ControleAuth>(context, listen: false)
                  //     .cadastroComplementar(
                  //   photo!,
                  //   controleCadastro.cadastroCompl.nome,
                  //   controleCadastro.cadastroCompl.contato,
                  // );
                  // widget.colocarEmLoading(false);
                },
                titulo: 'Entrar',
                formPreenchido: controleLogin.loginPreenchido,
                corBotao: '#112F47',
                tamanhoFonte: 21,
              ),
            ),
          ],
        );
      }),
    );
  }
}
