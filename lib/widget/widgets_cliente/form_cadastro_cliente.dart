import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/controller/controle_aut_cadastro.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/campo_form_senha_cadastro.dart';
import 'package:app_alug_imovel/widget/campo_form_texto_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FormCadastroCliente extends StatefulWidget {
  // final Function() concluirOperacao;

  final Function(String, String) concluirCadastro;
  const FormCadastroCliente(this.concluirCadastro, {super.key});

  @override
  State<FormCadastroCliente> createState() => _FormCadastroClienteState();
}

class _FormCadastroClienteState extends State<FormCadastroCliente> {
  ControleAutCadastro controleCadastro = ControleAutCadastro();
  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return SizedBox(
      width: largura * 0.8,
      child: Observer(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CampoTextoCadastro(
                  nomeCampo: 'E-mail',
                  registrarAlteracao: controleCadastro.cadastro.alterarEmail,
                  notificarErro: controleCadastro.validaEmailCadastro,
                  maxCaracteres: 30,
                  corTexto: '#112F47',
                ),
                CampoSenhaCadastro(
                  nomeCampo: 'Senha',
                  registrarAlteracao: controleCadastro.cadastro.alterarSenha,
                  notificarErro: controleCadastro.validaSenhaCadastro,
                  maxCaracteres: 6,
                  corTexto: '#112F47',
                ),
                CampoSenhaCadastro(
                  nomeCampo: 'Confirmar Senha',
                  registrarAlteracao:
                      controleCadastro.cadastro.alterarSenhaConfirmacao,
                  notificarErro: controleCadastro.validaSenhaConfirmacao,
                  maxCaracteres: 6,
                  corTexto: '#112F47',
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: larguraPadding * 0.1,
                right: larguraPadding * 0.1,
                top: alturaPadding * 0.15,
              ),
              child: BotaoFormulario(
                submeter: controleCadastro.cadastroPreenchido
                    ? () async {
                        String email = controleCadastro.cadastro.email;
                        String senha = controleCadastro.cadastro.senha;
                        await Provider.of<ControleAuth>(context, listen: false)
                            .cadastrarCliente(controleCadastro.cadastro.email,
                                controleCadastro.cadastro.senha);

                        widget.concluirCadastro(email, senha);
                        // widget.colocarEmLoading(true);
                        // await Provider.of<ControleAuth>(context, listen: false)
                        //     .cadastroComplementar(
                        //   photo!,
                        //   controleCadastro.cadastroCompl.nome,
                        //   controleCadastro.cadastroCompl.contato,
                        // );
                        // widget.colocarEmLoading(false);
                      }
                    : () {
                        print(
                            'controle cadastro nao estao preenchido, value : ${controleCadastro.cadastroPreenchido}');
                      },
                titulo: 'Cadastrar',
                formPreenchido: controleCadastro.cadastroPreenchido,
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
