import 'package:flutter/material.dart';

class DisplayLaps extends StatelessWidget {
  final List lapHistory;
  final List differenceHistory;

  const DisplayLaps({super.key, required this.lapHistory, required this.differenceHistory});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: lapHistory.length,
        itemBuilder: (BuildContext context, int index) {
          var value = lapHistory[index];
          var calculatedDifference = differenceHistory[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((index + 1).toString().padLeft(2, '0'), style: const TextStyle(fontSize: 25, color: Colors.black54)),
              Text(value, style: const TextStyle(fontSize: 25, color: Colors.black54)),
              Text(calculatedDifference, style: const TextStyle(fontSize: 25, color: Colors.black54)),
            ],
          );
        },
      ),
    );
  }
}
