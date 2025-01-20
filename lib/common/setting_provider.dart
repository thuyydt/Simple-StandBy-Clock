import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokei/common/setting_model.dart';
import 'package:tokei/common/setting_notifier.dart';

final currentTimeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier();
});