import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:flutter/material.dart';

class CampoDropDownItem extends StatelessWidget {
  final List<String> itens;
  List<DropdownMenuItem>? _listaDropDownItem;
  final int itemSelecionado;
  final double alturaPadding;
  final Function(int value) callBack;
  final Icon iconeDropdown;
  final String tituloDropdown;
  // const CampoDropDownItem({Key? key}) : super(key: key);

  List<DropdownMenuItem> _gerarLista(List<String> itens) {
    int ct = -1;
    return itens.map((modelo) {
      ct++;
      return DropdownMenuItem(
        value: ct,
        child: Text(
          modelo,
          style: TextStyle(
            color: HexColor('#293949'),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }).toList();
  }

  CampoDropDownItem(this.iconeDropdown, this.itens, this.itemSelecionado,
      this.alturaPadding, this.callBack,
      {this.tituloDropdown = 'selecione o modelo', Key? key})
      : super(key: key) {
    _listaDropDownItem = _gerarLista(itens);
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: EdgeInsets.all(5),
        errorStyle: TextStyle(color: Colors.red),
      ),
      child: DropdownButton<dynamic>(
        value: itemSelecionado == -1 ? null : itemSelecionado,
        items: _listaDropDownItem,
        isExpanded: true,
        hint: Text(
          tituloDropdown,
          style: TextStyle(
            color: HexColor('#E4572E'),
          ),
        ),
        style: TextStyle(
          color: HexColor('#293949'),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        icon: iconeDropdown,
        dropdownColor: Colors.grey[100],
        disabledHint: const Text('selecione o modelo'),
        underline: Container(
          color: Colors.transparent,
        ),
        onChanged: (value) => callBack(value),
      ),
    );
  }
}
