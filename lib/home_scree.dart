import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String hours = "00";
  String minutes = "00";
  String seconds = "00";
  late Timer timer;
  bool isTimerStart = false;
  int sec = 0;
  String textButton = "Play";
  late int lapSec;
  int lapCount = 0;
  List<String> lapHistory = [];
  List<String> beforeHistory = [];

  void convertTime() {
    setState(() {
      if (isTimerStart == true) {
        sec++;
        hours = ((sec / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
        minutes = ((sec / 60) % 60).floor().toString().padLeft(2, '0');
        seconds = (sec % 60).floor().toString().padLeft(2, '0');
      }
    });
  }

  void handleTimerStartStop() {
    setState(() {
      if (!isTimerStart) {
        isTimerStart = true;
        // textButton = "Stop";
      } else {
        isTimerStart = false;
        // textButton = "Play";
      }
    });
  }

  void lapBefore() {
    String temp;
    int temp2;
    if (lapCount == 0) {
      temp = "+ $hours:$minutes:$seconds";
    } else {
      temp2 = sec - lapSec;
      temp =
          "+ ${((temp2 / (60 * 60)) % 60).floor().toString().padLeft(2, '0')}:${((temp2 / 60) % 60).floor().toString().padLeft(2, '0')}:${(temp2 % 60).floor().toString().padLeft(2, '0')}";
    }
    lapSec = sec;
    beforeHistory.add(temp);
  }

  void lap() {
    String temp;
    setState(() {
      lapBefore();
      temp = "${(lapCount).toString().padLeft(2, '0')}     ${beforeHistory[lapCount]}     $hours:$minutes:$seconds";
      lapHistory.add(temp);
      lapCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => convertTime());
  }

  void reset() {
    setState(() {
      hours = "00";
      minutes = "00";
      seconds = "00";
      isTimerStart = false;
      sec = 0;
      textButton = "Play";
      lapSec = 0;
      lapCount = 0;
      lapHistory = [];
      beforeHistory = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                hours,
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
                minutes,
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
                seconds,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isTimerStart) {
                      lap();
                    } else if (!isTimerStart && lapHistory.isNotEmpty) {
                      reset();
                    }
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isTimerStart ? const Color.fromARGB(255, 139, 139, 139) : const Color.fromARGB(255, 213, 213, 213),
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                        color: const Color.fromARGB(255, 139, 139, 139),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isTimerStart
                            ? 'Lap'
                            : !isTimerStart && lapHistory.isNotEmpty
                                ? "Reset"
                                : "Lap",
                        style: TextStyle(
                          fontSize: 20,
                          color: isTimerStart ? Colors.white : const Color.fromARGB(255, 92, 92, 92),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    handleTimerStartStop();
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: !isTimerStart ? const Color.fromARGB(255, 241, 135, 127) : const Color.fromARGB(255, 151, 225, 153),
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                        color: !isTimerStart ? const Color.fromARGB(255, 167, 12, 1) : const Color.fromARGB(255, 19, 164, 23),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isTimerStart ? "Stop" : "Play",
                        style: TextStyle(
                          fontSize: 20,
                          color: !isTimerStart ? const Color.fromARGB(255, 167, 12, 1) : const Color.fromARGB(255, 19, 164, 23),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (lapHistory.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sr no"),
                  Text("Started From            "),
                  Text("Actual"),
                ],
              ),
            ),
          Expanded(
            child: ListView(
                children: lapHistory.map((String value) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(value, style: const TextStyle(fontSize: 25, color: Colors.black54)),
              );
            }).toList()),
          ),
        ],
      ),
    );
  }
}
