import 'package:loumar/models/roteiro/roteiro_base_model.dart';

class RoteiroPassagem extends RoteiroItem {
  final String localizador;
  final String passageiro;
  final List<String> ida;
  final List<String> volta;
  final List<String> additionalInfo;

  RoteiroPassagem({
     required String titulo,
    required String id,
    required DateTime dataHora,
    required this.localizador,
    required this.passageiro,
    required this.ida,
    required this.volta,
    required this.additionalInfo,
  }) : super(
          id: id,
          dataHora: dataHora,
          tipo: RoteiroTipo.passagem,
          titulo: titulo,
        );
}