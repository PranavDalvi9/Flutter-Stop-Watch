import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_application/infrastructure/provider/provider_registration.dart';
import 'package:stop_watch_application/screens/buttons.dart';
import 'package:stop_watch_application/screens/clock_widget.dart';
import 'package:stop_watch_application/screens/display_laps.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(homeProvider)
        .setTimer(Timer.periodic(const Duration(seconds: 1), (Timer t) => ref.read(homeProvider).convertTime()));
    ref.read(homeProvider).getDataFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const ClockWidget(),
            const SizedBox(height: 50),
            const Buttons(),
            const SizedBox(height: 40),
            if (homeProviderWatch.lapHistory.isNotEmpty)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sr no",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Actual",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Difference",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            DisplayLaps(
              lapHistory: homeProviderWatch.lapHistory,
              differenceHistory: homeProviderWatch.differenceHistory,
            ),
          ],
        ),
      ),
    );
  }
}
