import 'package:intl/intl.dart';

class RoteiroDateUtils {
  // Ex: "Sexta-feira, dia 15/09"
  static String formatarCabecalho(DateTime data) {
    // Certifique-se de ter configurado o locale 'pt_BR' no seu main.dart
    final diaSemana = DateFormat('EEEE', 'pt_BR').format(data); 
    final diaMes = DateFormat('dd/MM', 'pt_BR').format(data);
    
    // Capitaliza a primeira letra (Sexta-feira)
    final diaSemanaCap = diaSemana[0].toUpperCase() + diaSemana.substring(1);
    
    return "$diaSemanaCap, dia $diaMes";
  }

  // Ex: "08:00"
  static String formatarHora(DateTime data) {
    return DateFormat('HH:mm').format(data);
  }
}