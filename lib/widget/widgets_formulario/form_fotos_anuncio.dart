// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:app_alug_imovel/controller/controle_form_anuncio.dart';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/btn_form_card.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/btn_form_anuncio.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FormFotosAnuncio extends StatefulWidget {
  ControleFormAnuncio controle;
  List<File> imagens;
  final Function() concluir, voltar;
  FormFotosAnuncio(this.controle, this.imagens, this.concluir, this.voltar,
      {super.key});

  @override
  State<FormFotosAnuncio> createState() => _FormFotosAnuncioState();
}

class _FormFotosAnuncioState extends State<FormFotosAnuncio> {
  File? photo;
  final ImagePicker _picker = ImagePicker();
  bool naoTemFoto = true;
  Future importarFotoGaleria() async {
    final pickedFile = await _picker.pickMultiImage();
    //  final pickedFile = pickImage(source: ImageSource.gallery);
    setState(() {
      for (var file in pickedFile) {
        if (widget.imagens.length < 5) {
          if (file != null) {
            photo = File(file.path);
            widget.imagens.add(photo!);
          } else {
            print('Imagem não selecionada');
          }
        } else {
          if (file != null) {
            photo = File(file.path);
            widget.imagens.first = photo!;
          } else {
            print('Imagem não selecionada');
          }
        }
      }
    });

    // setState(() {
    //   if (widget.imagens.length < 6) {
    //     if (pickedFile != null) {
    //       photo = File(pickedFile.path);
    //       widget.imagens.add(photo!);
    //     } else {
    //       print('Imagem não selecionada');
    //     }
    //   } else {
    //     if (pickedFile != null) {
    //       photo = File(pickedFile.path);
    //       widget.imagens.first = photo!;
    //     } else {
    //       print('Imagem não selecionada');
    //     }
    //   }
    // });
  }

  void excluirImagem(int indice) {
    setState(() {
      widget.imagens.removeAt(indice);
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Container(
      height: widget.imagens.isEmpty ? altura * 0.6 : altura * 0.8,
      width: largura * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: larguraPadding * 0.5,
                vertical: alturaPadding * 0.05),
            child: SizedBox(
              height: altura * 0.08,
              child: const Center(
                child: CabecalhoForm(
                  'Selecionar fotos:',
                  corTexto: '#293949',
                  tamanhoFonte: 30,
                ),
              ),
            ),
          ),
          widget.imagens.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: altura * 0.08),
                  child: Center(
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: HexColor('#57697d'),
                      size: alturaPadding * 0.8,
                    ),
                  ),
                )
              : CarouselSlider(
                  options: CarouselOptions(height: altura * 0.5),
                  items: widget.imagens.asMap().entries.map((entry) {
                    int index = entry.key;
                    File image = entry.value;
                    print(' alturapadding $alturaPadding');
                    print('largurapadding $larguraPadding');
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(children: [
                          Container(
                            width: largura * 0.7,
                            height: altura * 0.5,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: alturaPadding * 0.07,
                            right: larguraPadding * 0.15,
                            child: InkWell(
                              onTap: () => excluirImagem(index),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]);
                      },
                    );
                  }).toList(),
                ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: alturaPadding * 0.05,
            ),
            child: SizedBox(
              width: largura * 0.3,
              child: BtnForm(
                colorBotao: '#57697d',
                submeter: importarFotoGaleria,
                titulo: 'Foto',
                formPreenchido: true,
              ),
            ),
          ),
          // FloatingActionButton(
          //   backgroundColor: HexColor('#ffffff'),
          //   onPressed: importarFotoGaleria,
          //   child: const Icon(Icons.add_a_photo),
          // ),
          SizedBox(
            height: alturaPadding * 0.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: largura * 0.38,
                child: BtnFormAnuncio(
                  submeter: widget.voltar,
                  titulo: 'Voltar',
                  formPreenchido: true,
                  corBotao: '#56828f',
                ),
              ),
              SizedBox(
                width: largura * 0.38,
                child: BtnFormAnuncio(
                  submeter: widget.concluir,
                  titulo: 'Concluir',
                  formPreenchido: widget.controle.validaFormAnuncio,
                  corBotao: '#56828f',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
