import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarrosselFotosAnuncio extends StatefulWidget {
  final List<String> imagens;

  const CarrosselFotosAnuncio(this.imagens, {super.key});

  @override
  State<CarrosselFotosAnuncio> createState() => _CarrosselFotosAnuncioState();
}

class _CarrosselFotosAnuncioState extends State<CarrosselFotosAnuncio> {
  int _paginaAtual = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            aspectRatio: 1.4,
            viewportFraction: 0.99,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _paginaAtual = index;
              });
            },
          ),
          items: widget.imagens.map((imagem) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: MediaQuery.of(context).size.height * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imagem),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imagens.map((imagem) {
            int index = widget.imagens.indexOf(imagem);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _paginaAtual == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
