import 'package:loumar/models/roteiro/roteiro_base_model.dart';

class RoteiroHospedagem extends RoteiroItem {
  final String nomeHotel;
  final String endereco;
  final bool isCheckIn; // true = Check-in, false = Check-out

  RoteiroHospedagem({
    required String id,
    required DateTime dataHora,
    required this.nomeHotel,
    required this.endereco,
    required this.isCheckIn,
  }) : super(
          id: id,
          dataHora: dataHora,
          tipo: RoteiroTipo.hospedagem,
          titulo: isCheckIn ? "Check-in: $nomeHotel" : "Check-out: $nomeHotel",
        );
}