import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tokei/common/setting_provider.dart';

class ClockPage extends ConsumerStatefulWidget {
  const ClockPage({super.key});

  @override
  ConsumerState<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends ConsumerState<ClockPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      ref.read(currentTimeProvider.notifier).state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = ref.watch(currentTimeProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimeUnit(
                context, 
                settings.hourColor1, 
                getHourFirst(currentTime), 
                'hour1', 
                Alignment.centerRight, 
                fit: BoxFit.fill, 
                alpha: 0.7,
                angle: -2,
              ),
              buildTimeUnit(
                context, 
                settings.hourColor2, 
                getHourSecond(currentTime), 
                'hour2', 
                Alignment.centerRight, 
                fit: BoxFit.fill, 
                alpha: 0.8,
                angle: 2,
              ),
              buildTimeUnit(
                context, 
                settings.colonColor, 
                ':', 
                'colon', 
                Alignment.center, 
                fit: BoxFit.fill, 
                alpha: 0.6,
              ),
              buildTimeUnit(
                context, 
                settings.minuteColor1, 
                getMinuteFirst(currentTime), 
                'minute1', 
                Alignment.centerLeft, 
                fit: BoxFit.fill, 
                alpha: 0.7,
                angle: -2,
              ),
              buildTimeUnit(
                context, 
                settings.minuteColor2, 
                getMinuteSecond(currentTime), 
                'minute2', 
                Alignment.centerLeft, 
                fit: BoxFit.fill, 
                alpha: 0.8,
                angle: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getHourFirst(DateTime currentTime) {
    if (currentTime.hour < 10) {
      return '';
    }

    return DateFormat('H').format(currentTime).substring(0, 1);
  }

  String getHourSecond(DateTime currentTime) {
    final h2 = DateFormat('H').format(currentTime).substring(currentTime.hour >= 10 ? 1 : 0);
    return int.parse(h2) > 0 ? h2 : '0';
  }

  String getMinuteFirst(DateTime currentTime) {
    return DateFormat('m').format(currentTime).padLeft(2, '0').substring(0, 1);
  }

  String getMinuteSecond(DateTime currentTime) {
    return DateFormat('m').format(currentTime).padLeft(2, '0').substring(1);
  }

  Widget buildTimeUnit(
    BuildContext context, 
    Color color, 
    String text, 
    String type, 
    Alignment alignment, 
    {BoxFit fit = BoxFit.fill, double alpha = 1, double angle = 0}
  ) {
    return GestureDetector(
      onLongPress: () {
        showColorSheet(context, type, color);
      },
      child: Transform(
        alignment: alignment,
        transform: Matrix4.rotationZ(-pi / 180 * angle),
        child: FittedBox(
          fit: fit,
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: getTextStyle(color, alpha: alpha),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showColorSheet(BuildContext context, String type, Color currentColor) {
    const defaultColros = [
      Colors.white,
      Colors.blue,
      Colors.blueGrey,
      Colors.brown,
      Colors.cyan,
      Colors.green,
      Colors.grey,
      Colors.indigo,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.yellow,
    ];
    return showModalBottomSheet(
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: Colors.white70,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final color in defaultColros)
              GestureDetector(
                onTap: () {
                  ref.read(settingsProvider.notifier).updateColor(type, color);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38, 
                      width: 1
                    ),
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextStyle getTextStyle(Color color, {double alpha = 1}) {
    final fontSize = MediaQuery.of(context).size.width / 2.5;
    return TextStyle(
      fontFamily: 'Jua',
      color: color.withValues(alpha: alpha),
      fontSize: fontSize,
      letterSpacing: -fontSize * 0.1,
    );
  }
}
