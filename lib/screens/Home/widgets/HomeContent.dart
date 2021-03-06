import 'package:flutter/material.dart';
import 'package:minimal_adhan/extensions.dart';
import 'package:minimal_adhan/helpers/gps_location_helper.dart';
import 'package:minimal_adhan/helpers/notification/notifiers.dart';
import 'package:minimal_adhan/prviders/TasbihProvider.dart';
import 'package:minimal_adhan/prviders/dependencies/DuaDependencyProvider.dart';
import 'package:minimal_adhan/prviders/locationProvider.dart';
import 'package:minimal_adhan/screens/Home/widgets/NavigationCards.dart';
import 'package:minimal_adhan/screens/Home/widgets/NavigationPanel.dart';
import 'package:minimal_adhan/screens/adhan/adhanScreen.dart';
import 'package:minimal_adhan/screens/dua/duaScreen.dart';
import 'package:minimal_adhan/screens/feedback/feedbackTaker.dart';
import 'package:minimal_adhan/screens/qibla/qiblaScreen.dart';
import 'package:minimal_adhan/screens/settings/settingsScreen.dart';
import 'package:minimal_adhan/screens/tasbih/tasbihScreen.dart';
import 'package:minimal_adhan/widgets/dashBoard.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  final void Function(String, [bool?]) toggleDrawer;
  final AnimationController drawerController;
  final void Function(Widget, int)? onNavigate;

  const HomeContent(this.toggleDrawer, this.drawerController,
      {required this.onNavigate});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 20;
      });
    });
    super.initState();
  }

  void navigate(BuildContext context, Widget child, int index) {
    if (widget.onNavigate == null) {
      context.push(child);
    } else {
      widget.onNavigate?.call(child, index);
    }
  }

  bool closeTopContainer = false;

  @override
  Widget build(BuildContext context) {
    final appLocale = context.appLocale;
    final locationProvider = context.read<LocationProvider>();

    return GestureDetector(
      onPanUpdate: context.isLargeScreen
          ? null
          : (details) {
              if (details.delta.dx > 0) {
                widget.toggleDrawer(context.appLocale.text_direction, true);
              }

              if (details.delta.dx < 0) {
                widget.toggleDrawer(context.appLocale.text_direction, false);
              }
            },
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: closeTopContainer ? 0 : 1,
            child: DashBoard(),
          ),
          NavigationPanel.build(
            controller: controller,
            children: [
              NavigationCard(
                label: appLocale.adhan,
                imageURI: 'ic_azan',
                onPressed: () => navigate(context, const AdhanScreen(), 0),
              ),
              NavigationCard(
                label: appLocale.qibla,
                imageURI: 'ic_qibla',
                onPressed: () => navigate(context, const QiblaScreen(), 1),
              ),
              NavigationCard(
                label: appLocale.dua,
                imageURI: 'ic_hadith',
                onPressed: () => navigate(
                  context,
                  ChangeNotifierProvider(
                    create: (_) => DuaDependencyProvider(),
                    child: DuaScreen(),
                  ),
                  2,
                ),
              ),
              NavigationCard(
                label: context.appLocale.tasbih,
                imageURI: 'ic_tasbih',
                onPressed: () => navigate(
                  context,
                  ChangeNotifierProvider(
                    create: (_) => TasbihProvider(),
                    child: const TasbihScreen(),
                  ),
                  3,
                ),
              ),
              NavigationCard(
                label: appLocale.nearby,
                imageURI: 'nearby',
                onPressed: () =>
                    locationProvider.locationState is LocationAvailable
                        ? navigate(
                            context,
                            FeedbackTaker(
                              'Nearby Mosque',
                              'https://www.google.com/maps/search/mosque+near+me/@${(locationProvider.locationState as LocationAvailable).locationInfo.latitude},${(locationProvider.locationState as LocationAvailable).locationInfo.longitude}',
                            ),
                            4)
                        : context.showSnackBar(appLocale.no_location_available),
              ),
              NavigationCard(
                label: appLocale.settings,
                imageURI: 'ic_settings',
                onPressed: () {
                 //createNotification();
                  //scheduleNotification(preDefined: DateTime.now().add(Duration(seconds: 5)),showNowIfPersistent: true);
                  //return;
                  navigate(
                    context,
                    ChangeNotifierProvider(
                      create: (_) => DuaDependencyProvider(),
                      child: const SettingsScreen(),
                    ),
                    5,
                  );
                }
              ),
            ],
          ),
          if (!context.isLargeScreen && context.appLocale.text_direction == 'ltr')
            AnimatedOpacity(
              opacity: closeTopContainer ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: closeTopContainer
                  ? null
                  : IconButton(
                      onPressed: () =>
                          widget.toggleDrawer(context.appLocale.text_direction),
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_arrow,
                        progress: widget.drawerController,
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
