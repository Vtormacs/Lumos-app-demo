import 'package:flutter/material.dart';
import '../models/roteiro/roteiro_base_model.dart';

class RoteiroController {
  // Notifiers para a tela ouvir as mudanças
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<String?> error = ValueNotifier<String?>(null);
  
  // O estado principal: Um mapa onde a Chave é a Data (sem hora) e o Valor é a lista de itens
  final ValueNotifier<Map<DateTime, List<RoteiroItem>>> roteiroAgrupado = ValueNotifier({});

  // Variável para guardar o dia selecionado (para a tela "Roteiro do Dia")
  final ValueNotifier<DateTime?> diaSelecionado = ValueNotifier(null);

  RoteiroController() {
    // Carrega os dados assim que a controller é criada (opcional)
    carregarRoteiro();
  }

  Future<void> carregarRoteiro() async {
    isLoading.value = true;
    error.value = null;

    try {
      // 1. Busca os dados brutos do Service (Ingressos, Transfers, Hoteis misturados)
      final List<RoteiroItem> listaBruta = await MockRoteiroService.getRoteiroCompleto();

      // 2. Garante a ordenação cronológica (do mais cedo para o mais tarde)
      listaBruta.sort((a, b) => a.dataHora.compareTo(b.dataHora));

      // 3. Agrupa os itens por dia (Lógica crucial para o seu layout)
      final Map<DateTime, List<RoteiroItem>> mapaTemporario = {};

      for (var item in listaBruta) {
        // Normaliza a data para zerar a hora (ex: 2025-12-15 14:00 vira 2025-12-15 00:00)
        // Isso serve para agrupar tudo do mesmo dia na mesma chave
        final dataSemHora = DateTime(item.dataHora.year, item.dataHora.month, item.dataHora.day);

        if (!mapaTemporario.containsKey(dataSemHora)) {
          mapaTemporario[dataSemHora] = [];
        }
        mapaTemporario[dataSemHora]!.add(item);
      }

      // 4. Atualiza a tela com o mapa pronto
      roteiroAgrupado.value = mapaTemporario;

      // Define o primeiro dia como selecionado por padrão (se houver dados)
      if (mapaTemporario.isNotEmpty && diaSelecionado.value == null) {
        diaSelecionado.value = mapaTemporario.keys.first;
      }

    } catch (e) {
      error.value = "Erro ao carregar roteiro: $e";
    } finally {
      isLoading.value = false;
    }
  }

  // Função auxiliar para pegar itens apenas do dia selecionado (Útil para a tela 'Roteiro do Dia')
  List<RoteiroItem> get itensDoDiaSelecionado {
    if (diaSelecionado.value == null) return [];
    return roteiroAgrupado.value[diaSelecionado.value] ?? [];
  }

  // Função para mudar o dia selecionado
  void selecionarDia(DateTime dia) {
    diaSelecionado.value = dia;
  }
}