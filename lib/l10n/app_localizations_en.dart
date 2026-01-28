// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome,';

  @override
  String get defaultUser => 'User';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get travelerGuide => 'Traveler\'s\nGuide';

  @override
  String get loremIpsum => 'Lorem\nIpsum';

  @override
  String get searchParaguay => 'Search\nParaguay';

  @override
  String get myPurchases => 'My\nPurchases';

  @override
  String get myTickets => 'My Tickets';

  @override
  String get myItineraries => 'My Itineraries';

  @override
  String get backToTop => 'Back to top';

  @override
  String linkError(Object link) {
    return 'Could not open link: $link';
  }
}
