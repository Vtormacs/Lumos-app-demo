import 'package:loumar/models/ingresso_models.dart';
import 'package:loumar/models/roteiro/passagem_roteiro.dart';
import 'package:loumar/models/roteiro/hospedagem_roteiro.dart';
import 'package:loumar/models/roteiro/locacao_roteiro.dart';
import 'package:loumar/models/roteiro/passerio_roteiro.dart';
import 'package:loumar/models/roteiro/transporte_roteiro.dart';

enum RoteiroTipo{
  passeio,
  transporte,
  hospedagem,
  passagem,
  refeicao,
  locacao,
  outro,
}

abstract class RoteiroItem {
  final String id;
  final DateTime dataHora;
  final RoteiroTipo tipo;
  final String titulo;

  RoteiroItem({
    required this.id,
    required this.dataHora,
    required this.tipo,
    required this.titulo,
  });
}

class MockRoteiroService {
  
  static Future<List<RoteiroItem>> getRoteiroCompleto() async {
    
    // Simulando delay de API
    await Future.delayed(const Duration(seconds: 1));

    List<RoteiroItem> listaGeral = [];

    listaGeral.add(RoteiroPassagem(
      titulo: "Voo LM1234 (IGU > GRU)",
      id: "voo_01",
      dataHora: DateTime(2025, 12, 15, 09, 30), 
      localizador: "LM1234",
      passageiro: "João da Silva",
      ida: ["2025-12-15T09:30", "2025-12-15T11:30"],
      volta: ["2025-12-20T18:00", "2025-12-20T20:00"],
      additionalInfo: [
        "Bagagem despachada incluída;",
        "Check-in online disponível 24h antes do voo.",
      ],
    ));

    listaGeral.add(RoteiroTransporte(
      id: "trans_01",
      dataHora: DateTime(2025, 12, 15, 11, 00),
      titulo: "Receptivo Aeroporto",
      subtitulo: "Aeroporto x Hotel",
      origem: "Aeroporto IGU",
      destino: "Hotel Recanto Cataratas",
      veiculo: "Van Executiva - Placa ABC-1234",
      localizador: "TR-9988",
      additionalInfo: [
        "Atrasos podem ocorrer, este transporte é compartilhado;",
        "Levar documento com foto.",
      ],
    ));

    listaGeral.add(RoteiroLocacao(
      id: "loc_01",
      dataDoUso: DateTime(2025, 12, 15, 12, 00),
      titulo: "Locação de Carro - SUV",
      local: "Localiza Rent a Car",
      chaveLoumar: "LC-2025SUV",
      tarifa: "R\$ 250,00 por dia",
      endereco: "Av. das Cataratas, 1234",
      categoria: CategoriaLocacao.carro,
      status: StatusLocacao.aretirar,
      additionalInfo: [
        "Combustível não incluso;",
        "Seguro total incluso no valor;",
        "Levar CNH válida e cartão de crédito.",
      ],
    ));

    listaGeral.add(RoteiroHospedagem(
      id: "hotel_01",
      dataHora: DateTime(2025, 12, 15, 14, 00),
      nomeHotel: "Recanto Cataratas Thermas Resort",
      endereco: "Av. Costa e Silva, 3500",
      checkin: DateTime(2025, 12, 15, 14, 00),
      checkiout: DateTime(2025, 12, 20, 12, 00),
      titulo: "Recanto Cataratas Thermas Resort",
      titular: "João da Silva",
      tipoQuarto: "Suíte Luxo Familiar",
      hospedes: [
        "João da Silva",
        "Maria Silva",
        "Pedro Silva",
      ],
      obrservacoes: [
        "Café da manhã incluso;",
        "Acesso ao parque aquático do hotel;",
        "Check-in antecipado solicitado.",
      ],
    ));

    var ingressosExistentes = MockData.getIngressos();
    if (ingressosExistentes.isNotEmpty) {
      listaGeral.add(RoteiroPasseio(
        ingresso: ingressosExistentes[0],
      ));
    }

    listaGeral.add(RoteiroTransporte(
      id: "trans_02",
      dataHora: DateTime(2025, 12, 15, 19, 00), 
      titulo: "Transfer para Jantar",
      subtitulo: "Hotel x Madero Tango",
      origem: "Hotel Recanto Cataratas",
      destino: "Madero Tango",
      veiculo: "Carro Privativo",
      motorista: "Carlos Silva",
      localizador: "TR-7766",
      additionalInfo: [
        "Atrasos podem ocorrer, este transporte é compartilhado;",
        "Levar documento com foto.",
      ],
    ));

    listaGeral.add(RoteiroTransporte(
      id: "trans_03",
      dataHora: DateTime(2025, 12, 16, 08, 00), 
      titulo: "Transporte Parque das Aves",
      subtitulo: "Hotel x Parque",
      origem: "Hotel Recanto Cataratas",
      destino: "Parque das Aves",
      veiculo: "Van Compartilhada",
      localizador: "TR-5544",
      additionalInfo: [
        "Atrasos podem ocorrer, este transporte é compartilhado;",
        "Levar documento com foto.",
      ],
    ));

    if (ingressosExistentes.length > 1) {
      listaGeral.add(RoteiroPasseio(
        ingresso: ingressosExistentes[1], 
      ));
    }

    // Passo crucial: Ordenar tudo por dataHora para aparecer certo na timeline
    listaGeral.sort((a, b) => a.dataHora.compareTo(b.dataHora));

    return listaGeral;
  }
}