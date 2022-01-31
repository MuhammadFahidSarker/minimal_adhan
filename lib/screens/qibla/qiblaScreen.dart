import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minimal_adhan/extensions.dart';
import 'package:minimal_adhan/helpers/GPS_location_helper.dart';
import 'package:minimal_adhan/prviders/dependencies/AdhanDependencyProvider.dart';
import 'package:minimal_adhan/screens/qibla/qiblaAvailableScreen.dart';
import 'package:provider/provider.dart';

import '../locationFindingScreen.dart';
import '../locationNotAvailableScreen.dart';
import '../unknownErrorScreen.dart';


class QiblaScreen extends StatelessWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocale = context.appLocale;

    final locationState = context.watch<AdhanDependencyProvider>().locationState;
    return Scaffold(
      appBar: AppBar(title: Text(appLocale.qibla), elevation: 0,),

      body: SafeArea(
        child: (locationState is LocationAvailable)
            ? QiblaAvailableScreen(locationState.locationInfo)
            : (locationState is LocationFinding)
            ? LocationFindingScreen()
            : (locationState is LocationNotAvailable)
            ? LocationNotAvailableScreen(locationState)
            : UnknownErrorScreen(),
      ),
    );
  }
}
