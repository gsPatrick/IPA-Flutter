class IndicesAnuncios {
  List<String> categorias = ['Casa', 'Apartamento', 'Flat', 'Quarto', 'Kitnet'];
  List<String> opcoesValores = ['Valor Mensal', 'Valor por Dia', 'Valor Único'];
  final List<int> numeros = [1, 2, 3, 4, 5];
  List<AdicionaisCheckBoxItem> itens = [
    AdicionaisCheckBoxItem(nome: 'Garagem'),
    AdicionaisCheckBoxItem(nome: 'Piscina'),
    AdicionaisCheckBoxItem(nome: 'Área de lazer'),
    AdicionaisCheckBoxItem(nome: 'Condomínio incluso'),
    AdicionaisCheckBoxItem(nome: 'IPTU Incluso'),
    AdicionaisCheckBoxItem(nome: 'Próximo a Praia'),
    AdicionaisCheckBoxItem(nome: 'Portaria'),
  ];
}

class AdicionaisCheckBoxItem {
  final String nome;
  bool foiSelecionado;
  AdicionaisCheckBoxItem({
    required this.nome,
    this.foiSelecionado = false,
  });
}
