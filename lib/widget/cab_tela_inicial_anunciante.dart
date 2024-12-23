import 'dart:io';

import 'package:app_alug_imovel/widget/campo_superior_info.dart';
import 'package:flutter/material.dart';

class CabecalhoTelaInicialAnunciante extends StatelessWidget {
  final String nome, contato;
  final bool foiCadastrado;
  final String urlFoto;
  const CabecalhoTelaInicialAnunciante(this.foiCadastrado,
      {this.nome = 'Seu nome',
      this.contato = 'Seu WhatsApp',
      this.urlFoto = '',
      super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.1;
    double largura = MediaQuery.of(context).size.width;
    double larguraPaddinfg = largura * 0.2;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              foiCadastrado
                  ? CampoSuperiorInfo(nome, '#ffffff', '#57697d')
                  : CampoSuperiorInfo(nome, '#273949', '#57697d'),
              SizedBox(
                height: alturaPadding * 0.1,
              ),
              foiCadastrado
                  ? CampoSuperiorInfo(contato, '#ffffff', '#57697d')
                  : CampoSuperiorInfo(contato, '#273949', '#57697d'),
            ],
          ),

          foiCadastrado
              ? Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: larguraPaddinfg * 0.5,
                        backgroundImage: NetworkImage(
                          urlFoto,
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 85,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.transparent,
                        size: 85,
                      ),
                    ),
                  ],
                )
          // Icon(
          //   Icons.person,
          //   color: Colors.white70,
          // ),
        ],
      ),
    );
  }
}
