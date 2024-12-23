import 'package:mobx/mobx.dart';
part 'model_cadastro_compl.g.dart';

class ModelCadastroCompl = _ModelCadastroComplBase with _$ModelCadastroCompl;

abstract class _ModelCadastroComplBase with Store {
  _ModelCadastroComplBase({
    this.nome = '',
    this.contato = '',
  });

  @observable
  String nome = '';
  @action
  alterarNome(String nomeInformado) => nome = nomeInformado;

  @observable
  String contato = '';
  @action
  alterarContato(String contatoInformado) => contato = contatoInformado;
}
