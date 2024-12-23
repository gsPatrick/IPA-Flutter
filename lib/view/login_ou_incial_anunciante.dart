import 'package:app_alug_imovel/controller/controle_aut.dart';
import 'package:app_alug_imovel/view/tela_inicial_admin.dart';
import 'package:app_alug_imovel/view/tela_inicial_anunciante.dart';
import 'package:app_alug_imovel/view/tela_login_anunciante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutLoginAnunciante extends StatelessWidget {
  const AutLoginAnunciante({super.key});

  @override
  Widget build(BuildContext context) {
    ControleAuth auth = Provider.of<ControleAuth>(context);
    return (auth.isAuth && auth.ehAdmin)
        ? TelaInicialAdmin()
        : auth.isAuth
            ? TelaInicialAnunciante()
            : TelaLoginAnunciante();
  }
}
