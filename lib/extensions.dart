import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension contextHelper on BuildContext {
  void push(Widget child) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => child));
  }

  void pop<T extends Object>([T? res]){
    Navigator.pop(this, res);
  }

  void showSnackBar(String txt) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(txt),
    ));
  }
}

extension LocalizeHelper on AppLocalizations {
  String getAdhanName(int i, [bool isJummah = false]) {
    return [
      this.adhan_fajr,
      this.adhan_sunrise,
      if (isJummah) '${this.adhan_jummah} - $adhan_dhuhr' else this.adhan_dhuhr,
      this.adhan_asr,
      this.adhan_magrib,
      this.adhan_isha,
      this.adhan_midnight,
      this.adhan_third_night
    ][i];
  }

  List<String> get themeModes {
    return [this.follow_system, this.always_light, this.always_dark];
  }
}

extension Helper on BuildContext {
  Color get primaryColor {
    return Theme.of(this).primaryColor;
  }


  Color get accentColor {
    return Theme.of(this).accentColor;
  }

  Color get darkPrimary {
    return Theme.of(this).primaryColorDark;
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  double get width {
    return MediaQuery.of(this).size.width;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  double get smallerBetweenHeightAndWidth {
    if (this.width < this.height) {
      return this.width;
    } else {
      return this.height;
    }
  }

  AppLocalizations get appLocale {
    return AppLocalizations.of(this)!;
  }
}

extension BoolParsing on String {
  bool toBool() {
    return this.toLowerCase() == 'true';
  }
}

extension DateHelper on DateTime {
  bool get isToday {
    var today = DateTime.now();

    return (this.year == today.year &&
        this.month == today.month &&
        this.day == today.day);
  }

  bool get isJummahToday {
    return weekday == 5;
  }
}
