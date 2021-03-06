import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:minimal_adhan/extensions.dart';
import 'package:minimal_adhan/helpers/gps_location_helper.dart';
import 'package:minimal_adhan/models/Adhan.dart';
import 'package:minimal_adhan/prviders/adhanProvider.dart';
import 'package:minimal_adhan/prviders/dependencies/AdhanDependencyProvider.dart';
import 'package:minimal_adhan/prviders/locationProvider.dart';
import 'package:provider/provider.dart';

const DASHBOARD_TOP_HEIGHT = 236.0;

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationProvider>().locationState;
    final adhanDependency = context.watch<AdhanDependencyProvider>();

    final appLocale = context.appLocale;

    final adhanProvider = locationState is LocationAvailable
        ? AdhanProvider(adhanDependency, locationState.locationInfo, appLocale)
        : null;

    final currentAdhan = adhanProvider?.currentAdhan;
    final nextAdhan = adhanProvider?.nextAdhan;

    final headingStyle = context.textTheme.headline1
        ?.copyWith(color: context.textTheme.headline6?.color);

    return SizedBox(
      height: DASHBOARD_TOP_HEIGHT,
      child: Padding(
        padding: const EdgeInsets.only(left: 32, bottom: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: _buildLayout(
            context: context,
            adhanDependencyProvider: adhanDependency,
            locationState: locationState,
            currentAdhan: currentAdhan,
            nextAdhan: nextAdhan,
            headingStyle: headingStyle,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLayout({
    required BuildContext context,
    required AdhanDependencyProvider adhanDependencyProvider,
    required LocationState locationState,
    required Adhan? currentAdhan,
    required Adhan? nextAdhan,
    TextStyle? headingStyle,
  }) {
    final appLocale = context.appLocale;
    return [
      if (currentAdhan != null)
        Row(
          children: [
            Image.asset(
              currentAdhan.imageLocation,
              width: 72,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    currentAdhan.title,
                    style: context.textTheme.headline2
                        ?.copyWith(color: context.theme.colorScheme.onBackground),
                    maxLines: 2,
                  ),
                  Text(
                    '${currentAdhan.startTime.localizeTimeTo(appLocale)} - ${currentAdhan.endTime.localizeTimeTo(appLocale)}',
                    style: context.textTheme.headline6
                        ?.copyWith(color: context.theme.colorScheme.onBackground),
                  ),
                ],
              )
            )
          ],
        )
      else
        Text(
          appLocale.adhan,
          style: context.textTheme.headline2?.copyWith(color: context.theme.colorScheme.onBackground),
        ),
      SizedBox(height: 16,),
      if (nextAdhan != null)
        Text(
          '${appLocale.next}: ${nextAdhan.title} (${nextAdhan.startTime.localizeTimeTo(appLocale)} - ${nextAdhan.endTime.localizeTimeTo(appLocale)})',
          style: context.textTheme.bodyText1,
        ),
      if (locationState is LocationAvailable)
        _buildLocationRow(
          context,
          Icons.my_location,
          locationState.locationAddressOfLength(25),
        )
    ];
  }

  Widget _buildLocationRow(
    BuildContext context,
    IconData iconData,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          iconData,
          color: context.primaryColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(color: context.primaryColor),
        )
      ],
    );
  }
}
