import 'dart:io';
import 'package:app_alug_imovel/util/hexColor.dart';
import 'package:app_alug_imovel/widget/btn_form_card.dart';
import 'package:app_alug_imovel/widget/btn_transp_borda.dart';
import 'package:app_alug_imovel/widget/widgets_formulario/cabecalho_form.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class FormFotosEdit extends StatefulWidget {
  List<Imagem> imagens;

  final Function() voltar, concluir;
  final Function(Imagem) excluir;
  final Function(File) adicionar;
  FormFotosEdit(
      this.imagens, this.voltar, this.concluir, this.excluir, this.adicionar,
      {super.key});

  @override
  State<FormFotosEdit> createState() => _FormFotosEditState();
}

class _FormFotosEditState extends State<FormFotosEdit> {
  File? photo;
  final ImagePicker _picker = ImagePicker();
  bool naoTemFoto = true;
  int indice = 0;
  @override
  void initState() {
    super.initState();
  }

  gerarListadynamic() {}

  Future importarFotoGaleria() async {
    final pickedFile = await _picker.pickMultiImage();
    //  final pickedFile = pickImage(source: ImageSource.gallery);
    setState(() {
      for (var file in pickedFile) {
        if (widget.imagens.length < 5) {
          if (file != null) {
            photo = File(file.path);

            // widget.imagens.add(Imagem('file', photo!));
            widget.adicionar(photo!);
          } else {
            print('Imagem não selecionada');
          }
        } else {
          if (file != null) {
            photo = File(file.path);
            widget.adicionar(photo!);
          } else {
            print('Imagem não selecionada');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double alturaPadding = altura * 0.2;
    double largura = MediaQuery.of(context).size.width;
    double larguraPadding = largura * 0.2;
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        height: widget.imagens.isEmpty ? altura * 0.7 : altura,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.purple,
          // color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: alturaPadding * 0.4),
              child: SizedBox(
                height: altura * 0.08,
                child: const Center(
                  child: CabecalhoForm(
                    'Alterar imagens',
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
                : Container(
                    // color: Colors.green,
                    padding: EdgeInsets.only(top: alturaPadding * 0.25),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: altura * 0.4,
                        aspectRatio: 1,
                        viewportFraction: 0.7,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                      ),
                      items: widget.imagens.map((imagem) {
                        indice++;

                        return Builder(
                          builder: (BuildContext context) {
                            return Stack(children: [
                              Container(
                                width: largura * 0.6,
                                height: altura * 0.37,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: imagem.tipo == 'url'
                                    ? Image.network(imagem.valor as String)
                                    : Image.file(
                                        imagem.valor as File,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                top: alturaPadding * 0.07,
                                right: larguraPadding * 0.15,
                                child: InkWell(
                                  onTap: () {
                                    // excluirImagem(
                                    //     widget.imagens.indexOf(imagem));
                                    setState(() {
                                      widget.excluir(imagem);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   top: alturaPadding * 0.07,
                              //   right: larguraPadding * 0.15,
                              //   child: Text(
                              //     imagem.indice.toString(),
                              //     style: TextStyle(fontSize: 23),
                              //   ),
                              // ),
                            ]);
                          },
                        ); // Tratar outros casos
                      }).toList(),
                    ),
                  ),
            Container(
              // color: Colors.blue,
              child: Padding(
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
            ),
            // FloatingActionButton(
            //   backgroundColor: HexColor('#ffffff'),
            //   onPressed: importarFotoGaleria,
            //   child: const Icon(Icons.add_a_photo),
            // ),
            SizedBox(
              height: alturaPadding * 0.3,
            ),
            SizedBox(
              width: largura * 0.45,
              child: BtnTranspBorda(
                submeter: () {
                  Navigator.of(context).pop();
                },
                titulo: 'Voltar',
                formPreenchido: true,
                corBotao: '#ffffff',
                corBorda: '#495664',
                corTexto: '#495664',
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SizedBox(
            //         width: largura * 0.38,
            //         child: BtnTranspBorda(
            //           submeter: () {
            //             Navigator.of(context).pop();
            //           },
            //           titulo: 'Voltar',
            //           formPreenchido: true,
            //           corBotao: '#ffffff',
            //           corBorda: '#495664',
            //           corTexto: '#495664',
            //         )),
            //     SizedBox(
            //       width: largura * 0.38,
            //       child: BtnFormAnuncio(
            //         submeter: () {},
            //         titulo: 'Alterar',
            //         formPreenchido: true,
            //         corBotao: '#14870c',
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class Imagem {
  final String tipo; // Pode ser "file" ou "url"
  final dynamic valor; // Caminho do arquivo (File) ou URL
  final int indice;
  Imagem(this.tipo, this.valor, this.indice);
}
