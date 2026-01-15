import 'package:flutter/material.dart';

// Enum para controlar o estado do botão (Azul ou Verde/Outline)
enum TicketStatus {
  digital, // Visualizar ingresso (Azul claro)
  instructions // Conferir instruções (Verde/Outline)
}

class EventoModel {
  final String title;
  final String imageUrl;
  final DateTime date;

  EventoModel({
    required this.title,
    required this.imageUrl,
    required this.date,
  });
}

class IngressoModel {
  final String id;
  final String beneficiaryName;
  final String type;
  final TicketStatus status;
  final EventoModel event;
  final DateTime dataDoUso;

  IngressoModel({
    required this.id,
    required this.beneficiaryName,
    required this.type,
    required this.status,
    required this.event,
    required this.dataDoUso,
  });
}

// --- DADOS MOCK (Simulando sua API) ---
class MockData {
  static List<IngressoModel> getIngressos() {
    // Evento 1: Madero Tango
    final event1 = EventoModel(
      title: "Madero Tango Iguazu - Jantar Show VIP",
      imageUrl: "https://www.novohamburgo.rs.gov.br/sites/pmnh/files/evento_destaque/2020-03/BN%201200x1600%20px%20-%20Em%20Breve.JPG", // URL de exemplo
      date: DateTime(2025, 12, 15, 13, 45),
    );

    final event2 = EventoModel(
      title: "Evento Exemplo 2",
      imageUrl: "https://www.novohamburgo.rs.gov.br/sites/pmnh/files/evento_destaque/2020-03/BN%201200x1600%20px%20-%20Em%20Breve.JPG",
      date: DateTime(2025, 12, 18, 13, 45),
    );

    return [
      IngressoModel(
        id: "#863132",
        beneficiaryName: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        status: TicketStatus.instructions,
        event: event1,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
      ),
      IngressoModel(
        id: "#863133",
        beneficiaryName: "Alberto Duarte oijfekf niojsoifjs",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event1,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
      ),
      IngressoModel(
        id: "#863133",
        beneficiaryName: "Alberto Duarte",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event1,
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
      ),
      IngressoModel(
        id: "#863133",
        beneficiaryName: "Alberto Duarte",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event1,
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
      ),
       IngressoModel(
        id: "#999111",
        beneficiaryName: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event2,
        dataDoUso: DateTime(2025, 12, 16, 20, 00),
      ),
      IngressoModel(
        id: "#999111",
        beneficiaryName: "Michelle Duarte de Almeida",
        type: "Inteira (Adulto)",
        status: TicketStatus.digital,
        event: event2,
        dataDoUso: DateTime(2025, 12, 15, 13, 45),
      ),
    ];
  }
}