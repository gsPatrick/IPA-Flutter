import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/botao_formulario.dart';
import 'package:app_alug_imovel/widget/botao_retorno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CadastroInfoAdicional extends StatefulWidget {
  const CadastroInfoAdicional({super.key});

  @override
  State<CadastroInfoAdicional> createState() => _CadastroInfoAdicionalState();
}

class _CadastroInfoAdicionalState extends State<CadastroInfoAdicional> {
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
                      // CampoTextoCadastro(
                      //   nomeCampo: 'Nome',
                      //   registrarAlteracao: cadastro.cadastro.alterarEmail,
                      //   notificarErro: cadastro.validaEmailCadastro,
                      //   maxCaracteres: 30,
                      // ),
                      // SizedBox(
                      //   height: alturaPadding * 0.2,
                      // ),
                      // CampoSenhaCadastro(
                      //   nomeCampo: 'Senha',
                      //   registrarAlteracao: cadastro.cadastro.alterarSenha,
                      //   notificarErro: cadastro.validaSenhaCadastro,
                      //   maxCaracteres: 6,
                      // ),
                      // CampoSenhaCadastro(
                      //   nomeCampo: 'Confirmar Senha',
                      //   registrarAlteracao:
                      //       cadastro.cadastro.alterarSenhaConfirmacao,
                      //   notificarErro: cadastro.validaSenhaConfirmacao,
                      //   maxCaracteres: 6,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: alturaPadding * 0.3,
                  ),
                  BotaoFormulario(
                    submeter: () {
                      // Provider.of<ControleAuth>(context, listen: false)
                      //     .cadastrarAnunciante(
                      //         cadastro.cadastro.email, cadastro.cadastro.senha);
                    },
                    titulo: 'Cadastro',
                    // formPreenchido: cadastro.cadastroPreenchido,
                    formPreenchido: true,
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
