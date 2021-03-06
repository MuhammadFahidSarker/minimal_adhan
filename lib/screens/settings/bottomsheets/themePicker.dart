import 'package:flutter/material.dart';
import 'package:minimal_adhan/prviders/dependencies/GlobalDependencyProvider.dart';
import 'package:provider/provider.dart';
import 'package:minimal_adhan/extensions.dart';
import 'Chooser.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocale = context.appLocale;
    final globalConfig = context.watch<GlobalDependencyProvider>();
    return choosingContainer(
        context: context,
        title: appLocale.theme,
        titles: appLocale.themeModes,
        subtitles: [],
        selected: (i) => globalConfig.themeModeIndex == i,
        onChoosen: globalConfig.updateThemeMode,
        percentageUpto: 0.9
    );
  }
}
