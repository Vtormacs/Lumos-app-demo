
// 1. MODELO DO PAGAMENTO (Para a aba Dados de Pagamento)
class PagamentoModel {
  final String id;
  final DateTime data;
  final String metodo; // Ex: "PIX PAGARME-DESTINO" ou "Link de Pagamento..."
  final double valor;

  PagamentoModel({
    required this.id,
    required this.data,
    required this.metodo,
    required this.valor,
  });
}

// 2. MODELO DO ITEM DA COMPRA (Para a aba Detalhes de Compra)
enum TipoItem { hotel, transporte, aviao, ingresso, generico }

class ItemCompraModel {
  final String titulo;
  final TipoItem tipo; // Para decidir qual ícone mostrar (Cama, Avião, Van)
  final String status; // Ex: "Ativo"
  final double valor;

  ItemCompraModel({
    required this.titulo,
    required this.tipo,
    required this.status,
    required this.valor,
  });
}

// 3. MODELO DA COMPRA (O Pai)
class CompraModel {
  final String codCompra;
  final String id; // Ex: #861323
  final String nomeTitular;
  final DateTime dataCompra;
  
  // Totais e Resumos (Header)
  final double valorTotal;
  final String formaPagamentoResumo; // Ex: "Múltiplos" ou "Cartão..."
  
  // Listas (O segredo está aqui)
  final List<ItemCompraModel> itens;
  final List<PagamentoModel> pagamentos;

  // Campos extras que sobraram (se forem gerais da compra)
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
      valorTotal: 45000.00, // Soma dos itens
      formaPagamentoResumo: "Cartão de Crédito **** 26952",
      loumarKey: "862939",
      tarifaTipo: "Padrão",
      
      // Lista de Itens (Aba 1)
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

      // Lista de Pagamentos (Aba 2)
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