import 'package:loumar/models/roteiro/roteiro_base_model.dart';

class RoteiroTransporte extends RoteiroItem {
  final String subtitulo; 
  final String origem;
  final String destino;
  final String veiculo;  
  final String motorista;
  final String localizador;
  final List<String> additionalInfo;

  RoteiroTransporte({
    required String id,
    required DateTime dataHora,
    required String titulo,
    required this.subtitulo,
    required this.origem,
    required this.destino,
    required this.veiculo,
    this.motorista = "A definir",
    required this.localizador,
    required this.additionalInfo,
  }) : super(
          id: id,
          dataHora: dataHora,
          tipo: RoteiroTipo.transporte,
          titulo: titulo,
        );
}