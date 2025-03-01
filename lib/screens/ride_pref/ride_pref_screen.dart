import 'package:flutter/material.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';
import '../../utils/animations_util.dart';
import '../ride/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String appHomeImagePath = 'assets/images/blabla_home.png';

///
/// Screen for managing ride preferences
/// Users can enter new preferences or select from history
///
class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  
  void _handleRidePrefSelection(RidePref selectedPref) {
    // Navigate with custom animation from bottom to top
    Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute(
        RidesScreen(initialRidePref: selectedPref)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        _BackgroundImage(),

        // Main content
        Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 100),
            Container(
              margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ride preference input form
                  RidePrefForm(initRidePref: RidePrefService.currentRidePref),
                  SizedBox(height: BlaSpacings.m),

                  // History list
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: RidePrefService.ridePrefsHistory.length,
                      itemBuilder: (ctx, index) => RidePrefHistoryTile(
                        ridePref: RidePrefService.ridePrefsHistory[index],
                        onPressed: () => _handleRidePrefSelection(
                          RidePrefService.ridePrefsHistory[index]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        appHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}