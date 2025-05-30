import 'package:flutter_riverpod/flutter_riverpod.dart';

final reloadProvider = StateNotifierProvider<reloadStateNotifier, bool>((ref) {
  return reloadStateNotifier();
});

class reloadStateNotifier extends StateNotifier<bool> {
  reloadStateNotifier() : super(true);

  reloading(bool load) {
    state = load;
  }
}
