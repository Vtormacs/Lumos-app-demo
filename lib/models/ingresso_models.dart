
enum TicketStatus {
  digital, // Visualizar ingresso (Azul claro)
  instructions, // Conferir instruções (Verde/Outline)
  printed, // Ingesso impresso
  notPrinted, // Ingresso não impresso
}

class EventoModel {
  final String title;
  final String imageUrl;
  final DateTime date;
  final String venueName;
  final String venueAddress;
  final List<String> about;
  final List<String> additionalInfo;

  EventoModel({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.venueName,
    required this.venueAddress,
    required this.about,
    required this.additionalInfo,
  });
}

class IngressoModel {
  final String id;
  final String beneficiaryName;
  final String type;
  final TicketStatus status;
  final EventoModel event;
  final DateTime dataDoUso;
  final String loumarKey;
  final String rateType;
  final String agentName;
  final String voucherCode;
  final String qrCodeImageUrl;

  IngressoModel({
    required this.id,
    required this.beneficiaryName,
    required this.type,
    required this.status,
    required this.event,
    required this.dataDoUso,
    required this.loumarKey,
    required this.rateType,
    required this.agentName,
    required this.voucherCode,
    required this.qrCodeImageUrl,
  });
}

// --- DADOS MOCK
class MockData {
  static List<IngressoModel> getIngressos() {
    final event1 = EventoModel(
      title: "Madero Tango Iguazu - Jantar Show VIP",
      imageUrl:
          "https://www.novohamburgo.rs.gov.br/sites/pmnh/files/evento_destaque/2020-03/BN%201200x1600%20px%20-%20Em%20Breve.JPG",
      date: DateTime(2025, 12, 15, 13, 45),
      venueName: "Madero Tango Iguazu",
      venueAddress: "Rod. das Cataras, 12450 - KM",
      about: [
        "Executado somente com o passeio Circuito Iguazu;",
        "Jantar não está incluso.",
      ],
      additionalInfo: [
        "Atrasos podem ocorrer, este transporte é compartilhado;",
        "Levar documento com foto.",
      ],
    );

    final event2 = EventoModel(
      title: "Evento Exemplo 2",
      imageUrl:
          "https://www.novohamburgo.rs.gov.br/sites/pmnh/files/evento_destaque/2020-03/BN%201200x1600%20px%20-%20Em%20Breve.JPG",
      date: DateTime(2025, 12, 18, 13, 45),
      venueName: "Parque das Aves",
      venueAddress: "Rod. das Cataratas, 12450 - KM",
      about: [
        "Entrada direta no portão;",
        "Válido apenas para a data selecionada.",
      ],
      additionalInfo: [
        "Proibido alimentar os animais;",
        "Uso de flash não é permitido.",
      ],
    );

    return [
      IngressoModel(
        id: "#863132",
        beneficiaryName: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        status: TicketStatus.printed,
        event: event1,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862939",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419614",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
            IngressoModel(
        id: "#863132",
        beneficiaryName: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        status: TicketStatus.printed,
        event: event1,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862939",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419614",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      IngressoModel(
        id: "#863133",
        beneficiaryName: "Alberto Duarte oijfekf niojsoifjs",
        type: "Meia",
        status: TicketStatus.notPrinted,
        event: event1,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862940",
        rateType: "VIP",
        agentName: "João Silva",
        voucherCode: "556516658419999",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      IngressoModel(
        id: "#863133",
        beneficiaryName: "Alberto Duarte",
        type: "Inteira (Adulto)",
        status: TicketStatus.instructions,
        event: event1,
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
        loumarKey: "862941",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419000",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      IngressoModel(
        id: "#863133",
        beneficiaryName: "Alberto Duarte",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event1,
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
        loumarKey: "862942",
        rateType: "VIP",
        agentName: "João Silva",
        voucherCode: "556516658419111",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      IngressoModel(
        id: "#999111",
        beneficiaryName: "Michelle Duarte de Almeida",    
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event2,
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
        loumarKey: "862943",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419222",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      IngressoModel(
        id: "#999111",
        beneficiaryName: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event2,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862944",
        rateType: "VIP",
        agentName: "João Silva",
        voucherCode: "556516658419333",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
    ];
  }
}
