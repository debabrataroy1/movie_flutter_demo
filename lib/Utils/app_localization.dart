import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_flutter_demo/Constants/app_data.dart';

class AppLocalization {
  late AppLocalizations keys;
  static final AppLocalization instance = AppLocalization._();
  factory AppLocalization() => instance;
  AppLocalization._() {
    keys = lookupAppLocalizations(AppData.locale);
  }
}
