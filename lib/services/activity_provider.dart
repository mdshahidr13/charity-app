import 'package:flutter/material.dart';
import '../models/activity.dart';

class ActivityProvider extends ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> get activities => List.unmodifiable(_activities);

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  List<Activity> filterByType(String type) {
    if (type == 'All') return activities;
    return _activities.where((a) => a.type == type).toList();
  }
} 