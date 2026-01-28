// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get welcome => 'Boas vindas,';

  @override
  String get defaultUser => 'Usuário';

  @override
  String get quickActions => 'Ações Rápidas';

  @override
  String get travelerGuide => 'Guia do\nViajante';

  @override
  String get loremIpsum => 'Lorem\nIpsum';

  @override
  String get searchParaguay => 'Busca\nParaguai';

  @override
  String get myPurchases => 'Minhas\nCompras';

  @override
  String get myTickets => 'Meus Ingressos';

  @override
  String get myItineraries => 'Meus Roteiros';

  @override
  String get backToTop => 'Voltar para o topo';

  @override
  String linkError(Object link) {
    return 'Não foi possível abrir o link: $link';
  }

  @override
  String get navHome => 'Início';

  @override
  String get navTickets => 'Ingressos';

  @override
  String get navItineraries => 'Roteiros';

  @override
  String get navMap => 'Mapa';

  @override
  String get navProfile => 'Perfil';
}
