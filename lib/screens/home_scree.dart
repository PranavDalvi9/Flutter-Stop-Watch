import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stop_watch_application/infrastructure/sharedprefs/shared_pref_helper.dart';

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
  int lapSec = 0;
  int lapCount = 0;
  List lapHistory = []; // laps
  List differenceHistory = []; //differnece

  void convertTime() {
    setState(() {
      if (isTimerStart == true) {
        sec++;
        hours = ((sec / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
        minutes = ((sec / 60) % 60).floor().toString().padLeft(2, '0');
        seconds = (sec % 60).floor().toString().padLeft(2, '0');

        Map<String, dynamic> data = {
          'hours': hours,
          'minutes': minutes,
          'seconds': seconds,
          'sec': sec,
          'lapSec': lapSec,
          'lapCount': lapCount,
        };
        SharedPrefHelper().setDataHistory(json.encode(data));
      }
    });
  }

  void handleTimerStartStop() {
    setState(() {
      if (!isTimerStart) {
        isTimerStart = true;
      } else {
        isTimerStart = false;
      }
    });
  }

  void differenceCalulate() {
    String temp;
    int temp2;
    if (lapCount == 0) {
      temp = "$hours:$minutes:$seconds";
    } else {
      temp2 = sec - lapSec;
      temp =
          "${((temp2 / (60 * 60)) % 60).floor().toString().padLeft(2, '0')}:${((temp2 / 60) % 60).floor().toString().padLeft(2, '0')}:${(temp2 % 60).floor().toString().padLeft(2, '0')}";
    }
    lapSec = sec;
    differenceHistory.add(temp);
    SharedPrefHelper().setDifferenceHistory(json.encode(differenceHistory));
  }

  void lap() {
    String temp;
    setState(() {
      differenceCalulate();
      temp = "$hours:$minutes:$seconds";
      lapHistory.add(temp);
      lapCount++;
      SharedPrefHelper().setLapHistory(json.encode(lapHistory));
    });
  }

  void getDataFromSharedPref() async {
    String getDataHistory = await SharedPrefHelper().getDataHistory;
    String getDifferenceHistory = await SharedPrefHelper().getDifferenceHistory;
    String getLapHistory = await SharedPrefHelper().getLapHistory;
    if (getDataHistory.isNotEmpty) {
      var getDataHistoryList = json.decode(getDataHistory);
      List getDifferenceHistoryList = getDifferenceHistory.isNotEmpty ? json.decode(getDifferenceHistory) : [];
      List getLapHistoryList = getLapHistory.isNotEmpty ? json.decode(getLapHistory) : [];

      setState(() {
        hours = getDataHistoryList['hours'];
        minutes = getDataHistoryList['minutes'];
        seconds = getDataHistoryList['seconds'];
        sec = getDataHistoryList['sec'];
        lapSec = getDataHistoryList['lapSec'];
        lapCount = getDataHistoryList['lapCount'];
        lapHistory = getLapHistoryList;
        differenceHistory = getDifferenceHistoryList;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => convertTime());
    getDataFromSharedPref();
  }

  void reset() {
    setState(() {
      hours = "00";
      minutes = "00";
      seconds = "00";
      isTimerStart = false;
      sec = 0;
      lapSec = 0;
      lapCount = 0;
      lapHistory = [];
      differenceHistory = [];
      SharedPrefHelper().clearPref();
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Sr no"),
                Text("Actual"),
                Text("Difference"),
              ],
            ),
          Expanded(
            child: ListView.builder(
              itemCount: lapHistory.length,
              itemBuilder: (BuildContext context, int index) {
                var value = lapHistory[index];
                var calculatedDifference = differenceHistory[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text((index + 1).toString().padLeft(2, '0'), style: const TextStyle(fontSize: 25, color: Colors.black54)),
                    Text(value, style: const TextStyle(fontSize: 25, color: Colors.black54)),
                    Text(calculatedDifference, style: const TextStyle(fontSize: 25, color: Colors.black54)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
