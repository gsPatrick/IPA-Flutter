import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioTileIndice extends StatelessWidget {
  String titulo;
  int valorGrupo;
  double tamanhoFonte;
  dynamic indice;
  final Function(dynamic value) registrarSelecao;

  RadioTileIndice(
      this.titulo, this.valorGrupo, this.indice, this.registrarSelecao,
      {this.tamanhoFonte = 17, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titulo,
        style: TextStyle(
          color: Colors.blueGrey.shade800,
          fontSize: tamanhoFonte,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Radio(
          value: indice, groupValue: valorGrupo, onChanged: registrarSelecao),
    );
  }
}
