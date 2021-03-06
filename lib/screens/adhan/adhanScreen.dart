import 'package:flutter/material.dart';
import 'package:minimal_adhan/extensions.dart';
import 'package:minimal_adhan/helpers/gps_location_helper.dart';
import 'package:minimal_adhan/prviders/adhanProvider.dart';
import 'package:minimal_adhan/prviders/dependencies/AdhanDependencyProvider.dart';
import 'package:minimal_adhan/prviders/locationProvider.dart';
import 'package:minimal_adhan/screens/adhan/widgets/AdhanAvailableScreen.dart';
import 'package:minimal_adhan/screens/locationFindingScreen.dart';
import 'package:minimal_adhan/screens/locationNotAvailableScreen.dart';
import 'package:minimal_adhan/screens/unknownErrorScreen.dart';
import 'package:provider/provider.dart';

class AdhanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adhanDep = context.watch<AdhanDependencyProvider>();
    final locationState = context.watch<LocationProvider>().locationState;

    return Scaffold(
      body: SafeArea(
        child: (locationState is LocationAvailable)
            ? ChangeNotifierProvider(
                create: (_) => AdhanProvider(
                    adhanDep, locationState.locationInfo, context.appLocale),
                child: AdhanAvailableScreen(locationState.locationInfo))
            : (locationState is LocationFinding)
                ? const LocationFindingScreen()
                : (locationState is LocationNotAvailable)
                    ? LocationNotAvailableScreen(locationState)
                    : const UnknownErrorScreen(),
      ),
    );
  }

  const AdhanScreen();
}
