import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_application/infrastructure/provider/provider_registration.dart';

class Buttons extends ConsumerStatefulWidget {
  const Buttons({super.key});

  @override
  ConsumerState<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends ConsumerState<Buttons> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (homeProviderWatch.isTimerStart) {
                homeProviderRead.lap();
              } else if (!homeProviderWatch.isTimerStart && homeProviderWatch.lapHistory.isNotEmpty) {
                homeProviderRead.reset();
              }
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: homeProviderWatch.isTimerStart
                    ? const Color.fromARGB(255, 139, 139, 139)
                    : const Color.fromARGB(255, 213, 213, 213),
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                  color: const Color.fromARGB(255, 139, 139, 139),
                ),
              ),
              child: Center(
                child: Text(
                  homeProviderWatch.isTimerStart
                      ? 'Lap'
                      : !homeProviderWatch.isTimerStart && homeProviderWatch.lapHistory.isNotEmpty
                          ? "Reset"
                          : "Lap",
                  style: TextStyle(
                    fontSize: 20,
                    color: homeProviderWatch.isTimerStart ? Colors.white : const Color.fromARGB(255, 92, 92, 92),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              homeProviderRead.handleTimerStartStop();
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: !homeProviderWatch.isTimerStart
                    ? const Color.fromARGB(255, 241, 135, 127)
                    : const Color.fromARGB(255, 151, 225, 153),
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                  color: !homeProviderWatch.isTimerStart
                      ? const Color.fromARGB(255, 167, 12, 1)
                      : const Color.fromARGB(255, 19, 164, 23),
                ),
              ),
              child: Center(
                child: Text(
                  homeProviderWatch.isTimerStart ? "Stop" : "Play",
                  style: TextStyle(
                    fontSize: 20,
                    color: !homeProviderWatch.isTimerStart
                        ? const Color.fromARGB(255, 167, 12, 1)
                        : const Color.fromARGB(255, 19, 164, 23),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
