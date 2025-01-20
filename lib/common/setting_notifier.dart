import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokei/common/setting_model.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings(
    hourColor1: Colors.blue,
    hourColor2: Colors.blue,
    colonColor: Colors.white,
    minuteColor1: Colors.blue,
    minuteColor2: Colors.blue,
  )) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = Settings(
      hourColor1: prefs.getInt('hourColor1') == null
          ? Colors.blue
          : Color(prefs.getInt('hourColor1')!),
      hourColor2: prefs.getInt('hourColor2') == null
          ? Colors.blue
          : Color(prefs.getInt('hourColor2')!),
      colonColor: prefs.getInt('colonColor') == null
          ? Colors.white
          : Color(prefs.getInt('colonColor')!),
      minuteColor1: prefs.getInt('minuteColor1') == null
          ? Colors.blue
          : Color(prefs.getInt('minuteColor1')!),
      minuteColor2: prefs.getInt('minuteColor2') == null
          ? Colors.blue : Color(prefs.getInt('minuteColor2')!),
    );
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('hourColor1', state.hourColor1.value);
    prefs.setInt('hourColor2', state.hourColor2.value);
    prefs.setInt('colonColor', state.colonColor.value);
    prefs.setInt('minuteColor1', state.minuteColor1.value);
    prefs.setInt('minuteColor2', state.minuteColor2.value);
  }

  // updateColor
  void updateColor(String colorOption, Color newColor) {
    switch (colorOption) {
      case 'hour1':
        state = state.copyWith(hourColor1: newColor);
        break;

      case 'hour2':
        state = state.copyWith(hourColor2: newColor);
        break;

      case 'colon':
        state = state.copyWith(colonColor: newColor);
        break;

      case 'minute1':
        state = state.copyWith(minuteColor1: newColor);
        break;

      case 'minute2':
        state = state.copyWith(minuteColor2: newColor);
        break;

      default:
        break;
    }
    _saveSettings();
  }
}
