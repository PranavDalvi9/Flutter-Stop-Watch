import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_application/infrastructure/provider/provider_registration.dart';

class ClockWidget extends ConsumerStatefulWidget {
  const ClockWidget({super.key});

  @override
  ConsumerState<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends ConsumerState<ClockWidget> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          homeProviderWatch.hours,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          ":",
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          homeProviderWatch.minutes,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          ":",
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          homeProviderWatch.seconds,
          style: const TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
