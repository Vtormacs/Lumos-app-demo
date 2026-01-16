
enum RoteiroType {
  partida,    // Avião saindo
  chegada,    // Hotel/Check-in
  passeio,    // Cataratas/Natureza
  compras,    // Sacolas/Compras
  ultimoDia   // Avião voltando/Malas
}

class RoteiroItemModel {
  final String title;
  final String description;
  final String dayLabel; 
  final RoteiroType type;

  RoteiroItemModel({
    required this.title,
    required this.description,
    required this.dayLabel,
    required this.type,
  });
}

// DADOS MOCK (Para teste) 
class MockRoteiroData {
  static List<RoteiroItemModel> getRoteiro() {
    return [
      RoteiroItemModel(
        title: "Partida para Foz do Iguaçu",
        description: "Prepare-se para iniciar sua viagem e chegue ao aeroporto com antecedência.",
        dayLabel: "Dia 01",
        type: RoteiroType.partida,
      ),
      RoteiroItemModel(
        title: "Chegada em Foz e Check-in",
        description: "Ao desembarcar, seu transporte estará aguardando. Faça o check-in no hotel e aproveite o restante do dia.",
        dayLabel: "Dia 02",
        type: RoteiroType.chegada,
      ),
      RoteiroItemModel(
        title: "Cataratas do Iguaçu – Lado Brasileiro",
        description: "Visite a grandiosa usina de Itaipu pela manhã e aproveite a tarde para compras em Ciudad del Este.",
        dayLabel: "Dia 03",
        type: RoteiroType.passeio,
      ),
      RoteiroItemModel(
        title: "Passeio por Itaipu + Compras no Paraguai",
        description: "Visite a grandiosa usina de Itaipu pela manhã e aproveite a tarde para compras em Ciudad del Este.",
        dayLabel: "Dia 04",
        type: RoteiroType.compras,
      ),
      RoteiroItemModel(
        title: "Último Dia Na Terra das Cataratas",
        description: "Finalize sua estadia no hotel, organize seus pertences e prepare-se para o embarque de retorno.",
        dayLabel: "Dia 05",
        type: RoteiroType.ultimoDia,
      ),
    ];
  }
}