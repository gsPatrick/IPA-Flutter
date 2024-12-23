import 'package:app_alug_imovel/controller/controle_anuncio.dart';
import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/campo_form_texto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DenunciaAnunciante extends StatefulWidget {
  final Anuncio anuncio;
  const DenunciaAnunciante(this.anuncio, {super.key});

  @override
  State<DenunciaAnunciante> createState() => _DenunciaAnuncianteState();
}

class _DenunciaAnuncianteState extends State<DenunciaAnunciante> {
  String motivoDenuncia = '';
  void _campoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Informe o tipo de denuncia'),
        content: CampoFormTexto(
            labelText: 'Informe o motivo',
            onchanged: (value) {
              setState(() {
                motivoDenuncia = value;
              });
            },
            callBackErrorText: () {},
            maxCaracteres: 70,
            maxLines: 3),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<ControleAnuncio>(context, listen: false)
                  .registrarDenuncia(widget.anuncio, motivoDenuncia);
              Navigator.of(context).pop();
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;

    return Container(
      alignment: Alignment.center,
      height: alturaPadding * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _campoDialog();
            },
            child: Text(
              'Denunciar anúncio',
              style: TextStyle(
                color: HexColor('#293949'),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Icon(
            Icons.warning_amber_rounded,
            size: 25,
          ),
        ],
      ),
    );
  }
}
