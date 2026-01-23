import 'package:loumar/models/ingresso_models.dart';
import 'package:loumar/models/roteiro/roteiro_base_model.dart';

class RoteiroPasseio extends RoteiroItem {
  final IngressoModel ingresso; 

  RoteiroPasseio({
    required this.ingresso,
  }) : super(
          id: ingresso.id,
          dataHora: ingresso.dataDoUso, 
          tipo: RoteiroTipo.passeio,
          titulo: ingresso.event.title,
        );
}