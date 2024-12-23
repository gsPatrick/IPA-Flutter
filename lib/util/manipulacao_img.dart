import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ManipulacaoImg {
  Future<List<String>> uploadImgs(
      List<File> fotos, String idAnunciante, String idAnuncio) async {
    List<String> urls = [];
    try {
      await Firebase.initializeApp();

      for (int i = 0; i < fotos.length; i++) {
        String url = await uploadImgAnuncio(fotos[i], idAnunciante, idAnuncio);
        urls.add(url);
      }

      return urls;
    } catch (e) {
      print('Erro ao realizar upload de imagens: $e');
      return [];
    }
  }

  Future<void> excluirImgs(
      List<String> urlsExcluidas, String idAnunciante, String idAnuncio) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    // ListResult result =
    //     await storage.ref('anuncio/$idAnunciante/$idAnuncio').listAll();

    for (String fileName in urlsExcluidas) {
      String filePath = 'anuncio/$idAnunciante/$idAnuncio/$fileName';
      print('caminho do arquivo eh : ${filePath}');
      try {
        await storage.ref().child(filePath).delete();
        print("Imagem deletada com sucesso: $filePath");
      } catch (e) {
        print("Erro ao deletar imagem $filePath: $e");
      }
    }
  }

  Future<List<String>> substituirTodasFotosAnuncio(
      List<String> listaAtualUrlsImg,
      List<String> urlsFotosExcluidas,
      List<File> novasFotos,
      String idAnunciante,
      String idAnuncio) async {
    List<String> novaLista = [];
    try {
      // print('entrou na funcao');
      // // Listar todos os arquivos existentes na pasta do anúncio
      // print('idAnunciante : |$idAnunciante| e o idAnuncio eh : |$idAnuncio|');

      List<String> arquivosExcluidos = [];

      // novaLista.addAll(listaAtualUrlsImg);

      for (String url in urlsFotosExcluidas) {
        List<String> partesUrl = url.split('/');
        String nomeArquivoEncoded = partesUrl.last.split('?').first;
        String nomeArquivoDecoded = Uri.decodeComponent(nomeArquivoEncoded);
        String teste = nomeArquivoDecoded.split('/').last;
        arquivosExcluidos.add(teste);
        listaAtualUrlsImg.remove(url);
      }
      await excluirImgs(arquivosExcluidos, idAnunciante, idAnuncio);
      novaLista = await uploadImgs(novasFotos, idAnunciante, idAnuncio);
      listaAtualUrlsImg.addAll(novaLista);
      //  uploadImgs(novasFotos, idAnunciante, idAnuncio);

      print(
          "Arquivos a serem excluídos: |${arquivosExcluidos}| arquivos que nao foram excluidos : |$listaAtualUrlsImg|  ");

      print('entrou na funcao2');
      // print('Todas as fotos foram substituídas com sucesso.');
    } catch (e) {
      print('Erro ao substituir as fotos: $e');
    }
    return listaAtualUrlsImg;
  }

// result.items.forEach((element) {
  //   print('fotos : ${element.getDownloadURL()}');
  // });

  // Deletar todos os arquivos existentes na pasta
  // await Future.forEach(result.items, (Reference ref) async {
  //   await ref.delete();
  // });

  // Fazer o upload das novas fotos para a pasta
  // for (int i = 0; i < novasFotos.length; i++) {
  //   String segundo = DateTime.now().second.toString();
  //   String minuto = DateTime.now().minute.toString();
  //   final String novoNomeArquivo = '$idAnuncio$i$minuto$segundo';
  //   Reference storageReferenceNova = FirebaseStorage.instance
  //       .ref()
  //       .child('anuncio/$idAnunciante/$idAnuncio/$novoNomeArquivo.jpg');
  //   await storageReferenceNova.putFile(novasFotos[i]);
  // }
  Future<String> uploadImgAnuncio(
      File imgAnuncio, String idAnunciante, String idAnuncio) async {
    String urlFoto = '';
    String segundo = DateTime.now().second.toString();
    String minuto = DateTime.now().minute.toString();
    final String nomeArquivo = '$idAnuncio$minuto$segundo';
    try {
      print('1 upload');
      // await Firebase.initializeApp();
      print('2 upload');
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('anuncio/$idAnunciante/$idAnuncio/$nomeArquivo.jpg');
      print('3 upload');
      await storageReference.putFile(imgAnuncio);

      urlFoto = await storageReference.getDownloadURL();
      print('url do novo arquivo: $urlFoto');

      // print('Arquivo enviado com sucesso para o Firebase Storage.');
    } catch (e) {
      // print('Erro ao enviar o arquivo: $e');
    }

    // return Future.value(urlFoto);
    return urlFoto;
  }

  // Future<File> baixarImg() async {
  //   return File('d');
  // }
}
