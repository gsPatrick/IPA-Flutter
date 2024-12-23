import 'package:app_alug_imovel/model/anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BotaoContatoWhats extends StatefulWidget {
  final Anuncio anuncio;
  const BotaoContatoWhats({required this.anuncio, super.key});

  @override
  State<BotaoContatoWhats> createState() => _BotaoContatoWhatsState();
}

class _BotaoContatoWhatsState extends State<BotaoContatoWhats> {
  _openWhatsApp(String numPhone) {
    final formattedPhoneNumber = numPhone.replaceAll(RegExp(r'[^\d]'), '');
    return launchUrl(
        Uri.parse(
          'https://api.whatsapp.com/send/?phone=55$formattedPhoneNumber&text=Olá', //put your number here
        ),
        mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    return ElevatedButton(
      onPressed: () {
        final formattedPhoneNumber =
            widget.anuncio.contatoAnunciante!.replaceAll(RegExp(r'[^\d]'), '');
        print('numero contato: $formattedPhoneNumber');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Atenção',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            content: const Text(
              'Não nos responsabilizamos por qualquer ação feita fora do aplicativo. Caso verifique algo suspeito, denuncie o anúncio para a gente',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _openWhatsApp(formattedPhoneNumber);
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.green,
                  // onPrimary: HexColor('#40e0d0'),
                  primary: Colors.green,
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(largura * 0.65, alturaPadding * 0.35),
        onPrimary: Colors.purple,
        // onPrimary: HexColor('#40e0d0'),
        primary: HexColor('#44a734'),

        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          side: BorderSide(color: Colors.green.shade900, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const AutoSizeText(
            'Entrar em contato',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: alturaPadding * 0.01),
            child: Container(
              width: larguraPadding * 0.55,
              height: larguraPadding * 0.55,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logowhats.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
