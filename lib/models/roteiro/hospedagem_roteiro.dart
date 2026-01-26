import 'package:loumar/models/roteiro/roteiro_base_model.dart';

class RoteiroHospedagem extends RoteiroItem {
  final String titular;
  final String nomeHotel;
  final String endereco;
  final DateTime checkin;
  final DateTime checkiout;
  final String tipoQuarto;
  final List<String> hospedes;
  final List<String> obrservacoes;

  RoteiroHospedagem({
    required String id,
    required DateTime dataHora,
    required String titulo,
    required this.titular,
    required this.tipoQuarto,
    required this.nomeHotel,
    required this.checkin,
    required this.checkiout,
    required this.endereco,
    required this.hospedes,
    required this.obrservacoes,
  }) : super(
          id: id,
          dataHora: dataHora,
          tipo: RoteiroTipo.hospedagem,
          titulo: titulo,
        );
}