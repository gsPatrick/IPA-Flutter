class FormDataID {
  String gerarIdAnuncio() {
    DateTime date = DateTime.now();
    int ano = date.year - 2000;
    String idAnuncio =
        '$ano${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}';
    return idAnuncio;
  }
}
