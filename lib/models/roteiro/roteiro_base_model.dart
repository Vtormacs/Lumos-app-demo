import 'package:flutter/material.dart';
import 'package:loumar/models/ingresso_models.dart';
import 'package:loumar/models/roteiro/aereo_roteiro.dart';
import 'package:loumar/models/roteiro/hospedagem_roteiro.dart';
import 'package:loumar/models/roteiro/passerio_roteiro.dart';
import 'package:loumar/models/roteiro/transporte_roteiro.dart';

enum RoteiroTipo{
  passeio,
  transporte,
  hospedagem,
  aereo,
  refeicao,
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
  
  // Função principal que a sua Tela vai chamar
  static Future<List<RoteiroItem>> getRoteiroCompleto() async {
    
    // Simulando delay de API
    await Future.delayed(const Duration(seconds: 1));

    List<RoteiroItem> listaGeral = [];

    // 1. Adicionando Voos
    listaGeral.add(RoteiroAereo(
      id: "voo_01",
      dataHora: DateTime(2025, 12, 15, 09, 30), // Dia 15, manhã
      ciaAerea: "Latam",
      codigoVoo: "LA3042",
      aeroportoOrigem: "GRU",
      aeroportoDestino: "IGU",
    ));

    // 2. Adicionando Transporte (Aeroporto -> Hotel)
    listaGeral.add(RoteiroTransporte(
      id: "trans_01",
      dataHora: DateTime(2025, 12, 15, 11, 00), // Dia 15, logo após voo
      titulo: "Receptivo Aeroporto",
      subtitulo: "Aeroporto x Hotel",
      origem: "Aeroporto IGU",
      destino: "Hotel Recanto Cataratas",
      veiculo: "Van Executiva - Placa ABC-1234",
      localizador: "TR-9988",
    ));

    // 3. Adicionando Hospedagem (Check-in)
    listaGeral.add(RoteiroHospedagem(
      id: "hotel_01",
      dataHora: DateTime(2025, 12, 15, 14, 00), // Dia 15, tarde
      nomeHotel: "Recanto Cataratas Thermas Resort",
      endereco: "Av. Costa e Silva, 3500",
      isCheckIn: true,
    ));

    // 4. Adicionando um Ingresso (Pegando do seu MockData existente)
    // Vamos pegar o primeiro ingresso da sua lista mockada
    var ingressosExistentes = MockData.getIngressos();
    if (ingressosExistentes.isNotEmpty) {
      // Ingresso Madero Tango (Jantar)
      listaGeral.add(RoteiroPasseio(
        ingresso: ingressosExistentes[0], // Assumindo que o [0] é dia 15 a noite
      ));
    }

    // 5. Adicionando Transporte para o Passeio
    listaGeral.add(RoteiroTransporte(
      id: "trans_02",
      dataHora: DateTime(2025, 12, 15, 19, 00), // Antes do jantar
      titulo: "Transfer para Jantar",
      subtitulo: "Hotel x Madero Tango",
      origem: "Hotel Recanto Cataratas",
      destino: "Madero Tango",
      veiculo: "Carro Privativo",
      motorista: "Carlos Silva",
      localizador: "TR-7766",
    ));

    // --- DIA SEGUINTE ---

    listaGeral.add(RoteiroTransporte(
      id: "trans_03",
      dataHora: DateTime(2025, 12, 16, 08, 00), 
      titulo: "Transporte Parque das Aves",
      subtitulo: "Hotel x Parque",
      origem: "Hotel Recanto Cataratas",
      destino: "Parque das Aves",
      veiculo: "Van Compartilhada",
      localizador: "TR-5544",
    ));

    // Adiciona outro ingresso se houver
    if (ingressosExistentes.length > 1) {
      listaGeral.add(RoteiroPasseio(
        ingresso: ingressosExistentes[1], // Parque das aves
      ));
    }

    // --- ORDENAÇÃO ---
    // Passo crucial: Ordenar tudo por dataHora para aparecer certo na timeline
    listaGeral.sort((a, b) => a.dataHora.compareTo(b.dataHora));

    return listaGeral;
  }
}