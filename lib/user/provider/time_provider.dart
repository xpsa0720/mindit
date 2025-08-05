import 'package:flutter_riverpod/flutter_riverpod.dart';

final TimeStateNotifierProvider =
    StateNotifierProvider<TimeStateNotifier, DateTime>((ref) {
      return TimeStateNotifier();
    });

class TimeStateNotifier extends StateNotifier<DateTime> {
  TimeStateNotifier() : super(DateTime(0000, 0, 0));

  UpdateTime() {
    state = DateTime.now();
  }

  TestUpdateTime() {
    state = DateTime.now().subtract(Duration(days: 1));
  }
}
