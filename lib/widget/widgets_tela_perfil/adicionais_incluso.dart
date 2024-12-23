// ignore_for_file: must_be_immutable

import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AdicionaisIncluso extends StatelessWidget {
  List<String> listaCategoria = [];
  final Anuncio anuncio;
  final bool ehEdicao;
  AdicionaisIncluso(this.anuncio, {this.ehEdicao = false, super.key}) {
    listaCategoria = gerarListaCategoria();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double miliAltura = alturaPadding * 0.25;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: alturaPadding * 0.1,
              bottom: alturaPadding * 0.05,
            ),
            child: Text(
              'Adicionais inclusos',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: larguraPadding * 0.25, right: larguraPadding * 0.25),
          child: SizedBox(
            width: largura * 0.8,
            child: Wrap(
              spacing: 2, // Espaçamento entre os widgets
              runSpacing: 10, // Espaçamento entre as linhas de widgets
              children: listaCategoria.map((text) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: alturaPadding * 0.25,
                  width: text.length > 10
                      ? largura * (text.length / 35)
                      : largura * (text.length / 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: HexColor('#293949'), width: 3.0),
                  ),
                  child: AutoSizeText(
                    text,
                    minFontSize: 14,
                    style: TextStyle(
                      color: HexColor('#293949'),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<String> gerarListaCategoria() {
    Anuncio anuncioLocal = anuncio;

    anuncioLocal.garagem == true ? listaCategoria.add('Garagem') : null;
    anuncioLocal.piscina == true ? listaCategoria.add('Piscina') : null;
    anuncioLocal.areaLazer == true ? listaCategoria.add('Area de Lazer') : null;
    anuncioLocal.condIncluso == true
        ? listaCategoria.add('Condomínio Inclusivo')
        : null;
    anuncioLocal.iptuIncluso == true
        ? listaCategoria.add('IPTU Incluso')
        : null;
    anuncioLocal.proxPraia == true
        ? listaCategoria.add('Próximo a Praia')
        : null;
    anuncioLocal.portaria == true ? listaCategoria.add('Portaria') : null;

    return listaCategoria;
  }
}
