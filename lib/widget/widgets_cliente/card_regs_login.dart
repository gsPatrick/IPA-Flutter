import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/btn_transp_borda.dart';
import 'package:app_alug_imovel/widget/widgets_cliente/form_cadastro_cliente.dart';
import 'package:app_alug_imovel/widget/widgets_cliente/form_login_cliente.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardRegsLogin extends StatefulWidget {
  final Function() concluirOperacao;
  const CardRegsLogin(this.concluirOperacao, {super.key});

  @override
  State<CardRegsLogin> createState() => _CardRegsLoginState();
}

class _CardRegsLoginState extends State<CardRegsLogin> {
  bool ehCadastro = true;
  String titulo = 'Cadastro';
  bool autenticando = false;

  cadastro(String email, String senha) async {
    await Provider.of<ControleAuth>(context, listen: false)
        .autenticarCliente(email, senha);
    autenticacao();
    // widget.concluirOperacao();
  }

  autenticacao() {
    loading();
    Provider.of<ControleAnuncio>(context, listen: false).sairSessao();
    finalizarAutenticacao();
  }

  loading() {
    setState(() {
      autenticando = true;
    });
  }

  finalizarAutenticacao() {
    widget.concluirOperacao();
    setState(() {
      autenticando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    // double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return autenticando
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
              color: Colors.white,
              value: 50,
            ),
          )
        : Container(
            height: ehCadastro ? altura * 0.7 : altura * 0.6,
            width: largura * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    titulo,
                    style: TextStyle(
                      fontSize: 35,
                      color: HexColor('#112F47'),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ehCadastro
                    ? FormCadastroCliente(
                        (email, senha) {
                          cadastro(email, senha);
                        },
                        // widget.concluirOperacao
                      )
                    : FormLoginCliente(autenticacao
                        // () {
                        //   widget.concluirOperacao();
                        //   setState(() {
                        //     autenticando = false;
                        //   });
                        // },
                        // () {
                        //   setState(() {
                        //     autenticando = true;
                        //   });
                        // },
                        ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: larguraPadding * 0.65),
                  child: BtnTranspBorda(
                    submeter: () {
                      setState(() {
                        ehCadastro = !ehCadastro;
                        titulo = ehCadastro ? 'Cadastro' : 'Login';
                      });
                    },
                    titulo: ehCadastro ? 'Login' : 'Cadastro',
                    formPreenchido: true,
                    corBotao: '#ffffff',
                    tamanhoFonte: 22,
                    corBorda: '#273949',
                    corTexto: '#273949',
                  ),
                )
              ],
            ));
  }
}
