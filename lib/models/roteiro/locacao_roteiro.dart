import 'package:loumar/models/roteiro/roteiro_base_model.dart';

enum CategoriaLocacao {
  carro,
  moto,
  bicicleta,
  van,
  onibus,
  cortesia,
  outros,
}

enum StatusLocacao {
  aretirar,
  retirado,
  cancelado,
}

class RoteiroLocacao extends RoteiroItem {
  final String chaveLoumar;
  final String tarifa;
  final String local;
  final String endereco;
  final CategoriaLocacao categoria;
  final StatusLocacao status;
  final List<String> additionalInfo;

  RoteiroLocacao({
    required String id,
    required DateTime dataDoUso,
    required String titulo,
    required this.local,
    required this.chaveLoumar,
    required this.tarifa,
    required this.endereco,
    required this.categoria,
    required this.status,
    required this.additionalInfo,
  }) : super(
          id: id,
          dataHora: dataDoUso,
          tipo: RoteiroTipo.locacao,
          titulo: titulo,
        );
}