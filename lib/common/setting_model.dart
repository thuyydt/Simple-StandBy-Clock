import 'package:flutter/material.dart';

class Settings {
  final Color hourColor1;
  final Color hourColor2;
  final Color colonColor;
  final Color minuteColor1;
  final Color minuteColor2;
  

  Settings({
    required this.hourColor1,
    required this.hourColor2,
    required this.colonColor,
    required this.minuteColor1,
    required this.minuteColor2,
  });

  Settings copyWith({
    Color? hourColor1,
    Color? hourColor2,
    Color? colonColor,
    Color? minuteColor1,
    Color? minuteColor2,
  }) {
    return Settings(
      hourColor1: hourColor1 ?? this.hourColor1,
      hourColor2: hourColor2 ?? this.hourColor2,
      colonColor: colonColor ?? this.colonColor,
      minuteColor1: minuteColor1 ?? this.minuteColor1,
      minuteColor2: minuteColor2 ?? this.minuteColor2,
    );
  }
}
