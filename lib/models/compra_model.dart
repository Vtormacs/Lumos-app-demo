

class CompraModel {
  final String codCompra;
  final String pagamento;
  final String valor;
  final String id;
  final String nomeTitular;
  final String type;
  final DateTime dataDoUso;
  final String loumarKey;
  final String rateType;
  final String agentName;
  final String voucherCode;
  final String qrCodeImageUrl;

  CompraModel({
    required this.codCompra,
    required this.pagamento,
    required this.valor,
    required this.id,
    required this.nomeTitular,
    required this.type,
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
  static List<CompraModel> getCompras() {
    

    return [
      CompraModel(
        codCompra: "C123456",
        pagamento: "Cartão de Crédito",
        valor: "R\$ 120,00",
        id: "#863132",
        nomeTitular: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862939",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419614",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
            CompraModel(
        codCompra: "C123457",
        pagamento: "Boleto Bancário",
        valor: "R\$ 60,00",
        id: "#863132",
        nomeTitular: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862939",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419614",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      CompraModel(
        codCompra: "C123458",
        pagamento: "Pix",
        valor: "R\$ 60,00",
        id: "#863133",
        nomeTitular: "Alberto Duarte oijfekf niojsoifjs",
        type: "Meia",
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
        loumarKey: "862940",
        rateType: "VIP",
        agentName: "João Silva",
        voucherCode: "556516658419999",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      CompraModel(
        codCompra: "C123459",
        pagamento: "Cartão de Crédito",
          valor: "R\$ 120,00",
        id: "#863133",
        nomeTitular: "Alberto Duarte",
        type: "Inteira (Adulto)",
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
        loumarKey: "862941",
        rateType: "Padrão",
        agentName: "Maria Klaus",
        voucherCode: "556516658419000",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
      CompraModel(
        codCompra: "C123460",
        pagamento: "Boleto Bancário",
        valor: "R\$ 80,00",
        id: "#863133",
        nomeTitular: "Alberto Duarte",
        type: "Inteira (Adulto)",
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
        loumarKey: "862942",
        rateType: "VIP",
        agentName: "João Silva",
        voucherCode: "556516658419111",
        qrCodeImageUrl: "https://i.sstatic.net/O6PbK.png",
      ),
    ];
  }
}
