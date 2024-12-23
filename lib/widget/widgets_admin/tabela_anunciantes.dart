import 'package:app_alug_imovel/model/anunciante.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class TabelaAnunciantes extends StatelessWidget {
  final List<Anunciante> anunciantes;

  final Function(
    int indice,
    Anunciante anunciante,
    double largura,
    double alturaPadding,
    double altura,
  ) menupopup;
  const TabelaAnunciantes(this.anunciantes, this.menupopup, {super.key});

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    return DataTable(
      columns: [
        DataColumn(
            label: Text(
          'Nome',
          style: retornarEstiloCabecalho(),
        )),
        DataColumn(
            label: Text(
          'Email',
          style: retornarEstiloCabecalho(),
        )),
        DataColumn(
            label: Text(
          'Contato',
          style: retornarEstiloCabecalho(),
        )),
        DataColumn(
            label: Text(
          'Status',
          style: retornarEstiloCabecalho(),
        )),
        DataColumn(
            label: Text(
          'Data de Vencimento',
          style: retornarEstiloCabecalho(),
        )),
        DataColumn(
            label: Text(
          'Editar',
          style: retornarEstiloCabecalho(),
        )),
      ],
      rows: List<DataRow>.generate(
        anunciantes.length,
        (index) => DataRow(cells: [
          DataCell(Text(
            anunciantes[index].nome!,
            style: retornarEstiloLinha(),
          )),
          DataCell(Text(
            anunciantes[index].email!,
            style: retornarEstiloLinha(),
          )),
          DataCell(Text(
            anunciantes[index].contato!,
            style: retornarEstiloLinha(),
          )),
          DataCell(Text(
            anunciantes[index].status!,
            style: retornarEstiloLinha(),
          )),
          DataCell(Text(
            anunciantes[index].dataVencimento!,
            style: retornarEstiloLinha(),
          )),
          DataCell(
            IconButton(
              onPressed: () {
                menupopup(
                    index, anunciantes[index], largura, alturaPadding, altura);
              },
              icon: const Icon(
                Icons.edit,
                size: 30,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  TextStyle retornarEstiloCabecalho() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: HexColor('#293949'),
    );
  }

  TextStyle retornarEstiloLinha() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: HexColor('#293949'),
    );
  }
}
