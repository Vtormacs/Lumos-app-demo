import 'package:loumar/models/roteiro/roteiro_base_model.dart';

class RoteiroAereo extends RoteiroItem {
  final String ciaAerea;
  final String codigoVoo;
  final String aeroportoOrigem;
  final String aeroportoDestino;

  RoteiroAereo({
    required String id,
    required DateTime dataHora,
    required this.ciaAerea,
    required this.codigoVoo,
    required this.aeroportoOrigem,
    required this.aeroportoDestino,
  }) : super(
          id: id,
          dataHora: dataHora,
          tipo: RoteiroTipo.aereo,
          titulo: "Voo $codigoVoo ($aeroportoOrigem > $aeroportoDestino)",
        );
}