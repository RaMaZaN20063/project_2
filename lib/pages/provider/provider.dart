import 'package:flutter/material.dart';
import 'package:realization_project/pages/model/taxi.dart';


class RideProvider with ChangeNotifier {
  List<CompletedRide> _completedRides = [];

  List<CompletedRide> get completedRides => _completedRides;

  void addCompletedRide(CompletedRide ride) {
    _completedRides.add(ride);
    notifyListeners();
  }
}