import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_application/infrastructure/sharedprefs/shared_pref_helper.dart';

class HomeProvider extends ChangeNotifier {
  late ChangeNotifierProviderRef<HomeProvider> ref;
  HomeProvider(this.ref);

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

  void setTimer(value) {
    timer = value;
  }

  void convertTime() {
    if (isTimerStart == true) {
      sec++;
      hours = ((sec / (60 * 60)) % 60).floor().toString().padLeft(2, '0'); // calculates the total number of hours
      minutes = ((sec / 60) % 60).floor().toString().padLeft(2, '0'); // calculates the total number of minutes
      seconds = (sec % 60).floor().toString().padLeft(2, '0'); // Calculates the seconds

// convert the data to object to store in sharedpreference
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
    notifyListeners();
  }

  void handleTimerStartStop() {
    notifyListeners();

    if (!isTimerStart) {
      isTimerStart = true;
    } else {
      isTimerStart = false;
    }
  }

// calculates the time difference between the current time and the last recorded lap time and stores the formatted difference in the differenceHistory list
  void differenceCalulate() {
    notifyListeners();
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

// calls the function to calculate the difference and stores the list
  void lap() {
    String temp;
    differenceCalulate();
    temp = "$hours:$minutes:$seconds";
    lapHistory.add(temp);
    lapCount++;
    SharedPrefHelper().setLapHistory(json.encode(lapHistory));
    notifyListeners();
  }

// get the data from shared sharedpreference
  void getDataFromSharedPref() async {
    // notifyListeners();
    String getDataHistory = await SharedPrefHelper().getDataHistory;
    String getDifferenceHistory = await SharedPrefHelper().getDifferenceHistory;
    String getLapHistory = await SharedPrefHelper().getLapHistory;
    if (getDataHistory.isNotEmpty) {
      var getDataHistoryList = json.decode(getDataHistory);
      List getDifferenceHistoryList = getDifferenceHistory.isNotEmpty ? json.decode(getDifferenceHistory) : [];
      List getLapHistoryList = getLapHistory.isNotEmpty ? json.decode(getLapHistory) : [];

// value obtained from sharedpreference is stored in local variables
      hours = getDataHistoryList['hours'];
      minutes = getDataHistoryList['minutes'];
      seconds = getDataHistoryList['seconds'];
      sec = getDataHistoryList['sec'];
      lapSec = getDataHistoryList['lapSec'];
      lapCount = getDataHistoryList['lapCount'];
      lapHistory = getLapHistoryList;
      differenceHistory = getDifferenceHistoryList;
    }
  }

  // resets the value
  void reset() {
    notifyListeners();
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
  }
}
