import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControleAuth with ChangeNotifier {
  String url = 'https://appalugvenda-default-rtdb.firebaseio.com';
  String? email, senha, idUsuario;
  String? nome = '';
  String? contato = '';
  String? urlFotoPerfil = '';
  bool ehAdmin = false;
  bool? ehAtivo;
  bool clienteLogado = false;
  bool anuncianteLogado = false;
  bool adminLogado = false;
  bool falhaAutenticacao = false;
  bool temFavorito = false;
  // SharedPreferences? prefsCliente, prefsAnunciante, prefsAdmin;
  SharedPreferences? prefs;
  bool? permissaoAnuncio;
  File? fotoPerfil;
  String? _token = '';

  final dio = Dio();
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token!.isNotEmpty) {
      return _token;
    } else {
      return null;
    }
  }

  // =============================***Cadastro****=============================

  Future<void> cadastrarCliente(
      String emailInformado, String senhaInformada) async {
    String idCliente =
        '${emailInformado.substring(0, 4)}${senhaInformada.substring(0, 4)}';

    final urlCadastro = '$url/cliente/$idCliente/.json';

    Map<String, dynamic> formRequisicao = {
      'idcliente': idCliente,
      'email': emailInformado,
      'senha': senhaInformada,
      'temfavorito': false,
    };

    final response = await dio.put(urlCadastro, data: formRequisicao);

    if (response.statusCode == 200) {
      if (!verificarCredenciais()) {
        salvarCredenciais(emailInformado, senhaInformada, idCliente, 'cliente');
      }
      _token = idCliente;
      idUsuario = idCliente;
      email = emailInformado;
      senha = senhaInformada;
    } else {}
  }

  Future<void> cadastrarAnunciante(
      String emailInformado, String senhaInformada) async {
    String idAnunciante =
        '${emailInformado.substring(0, 4)}${senhaInformada.substring(0, 4)}';

    final urlCadastro = '$url/anunciante/$idAnunciante/.json';

    Map<String, dynamic> formRequisicao = {
      'idAnunciante': idAnunciante,
      'email': emailInformado,
      'senha': senhaInformada,
      'permissaoanuncio': false,
      'ativado': false,
    };
    final response = await dio.put(urlCadastro, data: formRequisicao);
    if (response.statusCode == 200) {
      await autenticarAnunciante(emailInformado, senhaInformada);
      // _token = idAnunciante;
      // idUsuario = idAnunciante;
      // email = emailInformado;
      // senha = senhaInformada;
      // permissaoAnuncio = false;
    } else {}
    notifyListeners();
  }

  Future<void> cadastroComplementar(
      File fotoPerfil, String nomeAnunciante, String contatoAnunciante) async {
    String idAnunciante = '${email!.substring(0, 4)}${senha!.substring(0, 4)}';
    DateTime dataAtual = DateTime.now().add(const Duration(days: 30));
    int mesAtual = int.parse(dataAtual.month.toString().padLeft(2, '0'));
    int anoAtual = dataAtual.year;
    int diaAtual = int.parse(dataAtual.day.toString().padLeft(2, '0'));

    int dataInt = int.parse('$anoAtual$mesAtual$diaAtual');

    final urlLogin = '$url/anunciante/$idAnunciante/.json';

    String urlFotoAnunciante = await uploadFotoPerfil(fotoPerfil, idAnunciante);

    if (urlFotoAnunciante.isNotEmpty) {
      Map<String, dynamic> formRequisicao = {
        'nomeanunciante': nomeAnunciante,
        'contatoanunciante': contatoAnunciante,
        'permissaoanuncio': true,
        'urlfotoanunciante': urlFotoAnunciante,
        'ativado': true,
        'vencimento': '-',
        'dataint': dataInt
      };

      final response = await dio.patch(urlLogin, data: formRequisicao);

      if (response.statusCode == 200) {
        nome = nomeAnunciante;
        contato = contatoAnunciante;
        urlFotoPerfil = urlFotoAnunciante;
        permissaoAnuncio = true;
      } else {}
    } else {}
    notifyListeners();
  }

  Future<void> editarAnunciante(bool ehFotoUrl, File fotoFornecida,
      String nomeInformado, String contatoInformado) async {
    String idAnunciante = '${email!.substring(0, 4)}${senha!.substring(0, 4)}';
    final urlEdit = '$url/anunciante/$idAnunciante/.json';
    String urlFotoAnunciante = '';
    bool fotoAlterada = !ehFotoUrl;
    Map<String, dynamic> formRequisicao;
    if (fotoAlterada) {
      print('alterou a foto');
      // formRequisicao = {};
      urlFotoAnunciante = await uploadFotoPerfil(fotoFornecida, idAnunciante);
      formRequisicao = {
        'nomeanunciante': nomeInformado,
        'contatoanunciante': contatoInformado,
        'urlfotoanunciante': urlFotoAnunciante,
      };
    } else {
      print('nao alterou a foto');
      formRequisicao = {
        'nomeanunciante': nomeInformado,
        'contatoanunciante': contatoInformado,
      };
    }
    final response = await dio.patch(urlEdit, data: formRequisicao);
    if (response.statusCode == 200) {
      nome = nomeInformado;
      contato = contatoInformado;
      urlFotoPerfil = fotoAlterada ? urlFotoAnunciante : urlFotoPerfil;
      permissaoAnuncio = true;
    } else {}

    notifyListeners();
    return Future.value();
  }

// =============================***Autenticacao****=============================

  Future<void> autenticarCliente(
      String emailInformado, String senhaInformada) async {
    String idCliente =
        '${emailInformado.substring(0, 4)}${senhaInformada.substring(0, 4)}';

    final urlLogin = '$url/cliente/$idCliente/.json';

    final response = await dio.get(urlLogin);
    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;
      if (!verificarCredenciais()) {
        print(
            'email : $emailInformado senha : $senhaInformada id : $idCliente ');
        salvarCredenciais(emailInformado, senhaInformada, idCliente, 'cliente');
      }
      print('cliente : $emailInformado autenticado com sucesso');
      _token = idCliente;
      idUsuario = idCliente;
      email = emailInformado;
      senha = senhaInformada;
      clienteLogado = true;
      falhaAutenticacao = false;
      temFavorito = dados['temfavorito'];
    } else {
      falhaAutenticacao = true;
    }
    notifyListeners();
  }

  Future<void> autenticarAnunciante(
      String emailInformado, String senhaInformada) async {
    String idAnunciante =
        '${emailInformado.substring(0, 4)}${senhaInformada.substring(0, 4)}';
    final urlLogin = '$url/anunciante/$idAnunciante/.json';

    final response = await dio.get(urlLogin);

    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> dados = response.data as Map<String, dynamic>;

      if (!verificarCredenciais()) {
        salvarCredenciais(
            emailInformado, senhaInformada, idAnunciante, 'anunciante');
      }
      print('id do anunciante : $idAnunciante');
      _token = idAnunciante;
      idUsuario = idAnunciante;
      email = emailInformado;
      senha = senhaInformada;
      if (dados['permissaoanuncio']) {
        if (dados['ativado']) {
          urlFotoPerfil = dados['urlfotoanunciante'];
          nome = dados['nomeanunciante'];
          contato = dados['contatoanunciante'];
          permissaoAnuncio = dados['permissaoanuncio'];
          ehAtivo = dados['ativado'];
        } else {
          permissaoAnuncio = dados['permissaoanuncio'];
          ehAtivo = dados['ativado'];
          _token = '';
        }
      } else {
        permissaoAnuncio = false;
      }
      anuncianteLogado = true;
      falhaAutenticacao = false;
    } else {
      falhaAutenticacao = true;
    }
    notifyListeners();
  }

  Future<void> autenticarAdministrador(
      String emailInformado, String senhaInformada) async {
    String idAdmin =
        '${emailInformado.substring(0, 4)}${senhaInformada.substring(0, 4)}';
    final urlLogin = '$url/admin/$idAdmin/.json';

    final response = await dio.get(urlLogin);

    if (response.statusCode == 200 && response.data != null) {
      if (!verificarCredenciais()) {
        salvarCredenciais(emailInformado, senhaInformada, idAdmin, 'admin');
      }
      _token = idAdmin;
      idUsuario = idAdmin;
      email = emailInformado;
      senha = senhaInformada;
      adminLogado = true;
      ehAdmin = true;
      falhaAutenticacao = false;
    } else {
      falhaAutenticacao = true;
    }
    notifyListeners();
  }

  Future<String> uploadFotoPerfil(File fotoPerfil, String idAnunciante) async {
    String urlFoto = '';
    const String nomeArquivo = 'fotoperfil';
    try {
      await Firebase.initializeApp();
      // DateTime.now().millisecondsSinceEpoch.toString();
      // Obter a referência do Storage

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('anunciante/$idAnunciante/$nomeArquivo.jpg');

      // Fazer o upload do arquivo
      await storageReference.putFile(fotoPerfil);
      urlFoto = await storageReference.getDownloadURL();

      // print('Arquivo enviado com sucesso para o Firebase Storage.');
    } catch (e) {
      print('Erro ao enviar o arquivo: $e');
    }
    notifyListeners();

    return Future.value(urlFoto);
  }

  sairConta() async {
    _token = '';
    idUsuario = '';
    urlFotoPerfil = '';
    nome = '';
    contato = '';
    permissaoAnuncio = false;
    ehAdmin = false;
    clienteLogado = false;
    anuncianteLogado = false;
    adminLogado = false;
    await removerCredenciais();
    notifyListeners();
  }
  // =============================***Banco de dados e registro****=============================

  Future<void> iniciarBD() async {
    prefs = await SharedPreferences.getInstance();
    notifyListeners();
    return Future.value();
  }

  Future<void> salvarCredenciais(String emailInformado, String senhaInformada,
      String idInformado, String tipoUsuario) async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.setString('email', emailInformado);
    await prefs!.setString('senha', senhaInformada);
    await prefs!.setString('id', idInformado);
    await prefs!.setString('tipo', tipoUsuario);
    notifyListeners();
  }

  bool verificarCredenciais() {
    bool estaLogado = false;
    // print('prefs id : ${prefs!.containsKey('id')}');
    if (prefs!.containsKey('id')) {
      String? tipo = prefs!.getString('tipo');
      if (tipo == 'cliente') {
        clienteLogado = true;
        estaLogado = true;
      } else if (tipo == 'anunciante') {
        anuncianteLogado = true;
        estaLogado = true;
      } else if (tipo == 'admin') {
        adminLogado = true;
        estaLogado = true;
      } else {
        print('tipo nao encontrado');
      }
    }

    notifyListeners();
    return estaLogado;
  }

  Future<void> removerCredenciais() async {
    await prefs!.remove('email');
    await prefs!.remove('senha');
    await prefs!.remove('id');
    await prefs!.remove('tipo');
    notifyListeners();
  }
}
