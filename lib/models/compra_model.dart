class PagamentoModel {
  final String id;
  final DateTime data;
  final String metodo; 
  final double valor;

  PagamentoModel({
    required this.id,
    required this.data,
    required this.metodo,
    required this.valor,
  });
}

enum TipoItem { hotel, transporte, aviao, ingresso, generico }

class ItemCompraModel {
  final String titulo;
  final TipoItem tipo; 
  final String status; 
  final double valor;

  ItemCompraModel({
    required this.titulo,
    required this.tipo,
    required this.status,
    required this.valor,
  });
}

class CompraModel {
  final String codCompra;
  final String id;
  final String nomeTitular;
  final DateTime dataCompra;
  final double valorTotal;
  final String formaPagamentoResumo; 
  final List<ItemCompraModel> itens;
  final List<PagamentoModel> pagamentos;
  final String loumarKey;
  final String tarifaTipo;

  CompraModel({
    required this.codCompra,
    required this.id,
    required this.nomeTitular,
    required this.dataCompra,
    required this.valorTotal,
    required this.formaPagamentoResumo,
    required this.itens,
    required this.pagamentos,
    required this.loumarKey,
    required this.tarifaTipo,
  });
}

class MockData {
  static CompraModel getCompraDetalhada() {
    return CompraModel(
      codCompra: "C123456",
      id: "#861323",
      nomeTitular: "Michelle Duarte de Almeida",
      dataCompra: DateTime(2023, 05, 02),
      valorTotal: 45000.00, 
      formaPagamentoResumo: "Cartão de Crédito **** 26952",
      loumarKey: "862939",
      tarifaTipo: "Padrão",
      
      itens: [
        ItemCompraModel(
          titulo: "Check-in Hotel Bella Itália Solteiro",
          tipo: TipoItem.hotel,
          status: "Ativo",
          valor: 15000.00,
        ),
        ItemCompraModel(
          titulo: "Embarque - CNF -> IGU voo 403...",
          tipo: TipoItem.aviao,
          status: "Ativo",
          valor: 15000.00,
        ),
        ItemCompraModel(
          titulo: "Transfer Diurno Hotel x Cataratas",
          tipo: TipoItem.transporte,
          status: "Ativo",
          valor: 15000.00,
        ),
      ],

      pagamentos: [
        PagamentoModel(
          id: "1",
          data: DateTime(2023, 05, 02),
          metodo: "Link de Pagamento (URL) MASTERCARD - 10 Parcelas",
          valor: 15000.00,
        ),
        PagamentoModel(
          id: "2",
          data: DateTime(2023, 05, 02),
          metodo: "PIX PAGARME-DESTINO",
          valor: 15000.00,
        ),
        PagamentoModel(
          id: "3",
          data: DateTime(2023, 05, 02),
          metodo: "PIX PAGARME-DESTINO",
          valor: 15000.00,
        ),
      ],
    );
  }
}