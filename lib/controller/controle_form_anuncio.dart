import 'package:app_alug_imovel/model/model_form_anuncio.dart';
import 'package:mobx/mobx.dart';
part 'controle_form_anuncio.g.dart';

class ControleFormAnuncio = _ControleFormAnuncioBase with _$ControleFormAnuncio;

abstract class _ControleFormAnuncioBase with Store {
  var anuncio = ModelFormAnuncio();

  @computed
  bool get validaFormAnuncio =>
      validaTituloAnuncio() == null &&
      validaValor() == null &&
      validaDescricao() == null;

  String? validaTituloAnuncio() {
    if (anuncio.tituloAnuncio != null) {
      if (anuncio.tituloAnuncio.isEmpty) {
        return 'Campo Obrigatório';
      } else {
        return null;
      }
    } else {
      return 'Campo Obrigatório';
    }
  }

  String extractCurrencyValue(String input) {
    // Encontrar o padrão de valor em reais na string
    RegExp regExp = RegExp(r'R\$?\s?(\d{1,3}(\.\d{3})*,\d{2})');
    String? valueWithCurrency = regExp.stringMatch(input);

    if (valueWithCurrency != null) {
      // Extrair somente o valor numérico da string
      String valueWithoutCurrency =
          valueWithCurrency.replaceAll(RegExp(r'[^\d,]'), '');

      // Substituir a vírgula por ponto para formatar como double
      String valueFormatted = valueWithoutCurrency.replaceAll(',', '.');

      return valueFormatted;
    }

    return '0.00';
  }

  String? validaValor() {
    if (anuncio.valor != null) {
      String valorExtraidoString = extractCurrencyValue(anuncio.valor);
      if (double.parse(valorExtraidoString) == 0.0) {
        return 'Infome o valor';
      } else {
        return null;
      }
    } else {
      return 'Informe o valor';
    }
  }

  String? validaDescricao() {
    if (anuncio.descricao != null) {
      if (anuncio.descricao.isEmpty) {
        return 'Campo Obrigatório';
      } else {
        return null;
      }
    } else {
      return 'Campo Obrigatório';
    }
  }
}
