import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTime {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  CountdownTime({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}

CountdownTime _calculateCountdownTime(Duration duration) {
  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return CountdownTime(
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

class CountdownTimerWidget extends StatelessWidget {
  final DateTime targetDate;

  const CountdownTimerWidget({Key? key, required this.targetDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 12.0),
          child: Text(
            "Nearest Event",
            style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
                fontSize: 17.0,
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Breakfast Of Champions",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  height: 210.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPKALbf7w7ejN7njlOstHMOd7fWuguriCssA&usqp=CAU'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Text.rich(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const TextSpan(
                    text:
                        "\t\t\t\tDeskripsi ini dapat berupa gambaran visual, karakteristik fisik, atau detail-detail lain yang dapat membantu pembaca memahami secara lebih baik.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Berlokasi di ",
                      ),
                      TextSpan(
                        text: "Universitas Teknokrat Indonesia",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\n\n\t\t\t\t\tHal ini memungkinkan pengembang untuk membuat antarmuka pengguna yang estetis dan informatif.",
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(17.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8C00), Color(0xFFFF2D55)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: CountdownTimer(
                      targetDate: targetDate,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(12, 74),
                      backgroundColor: const Color(0XFF10A7E8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(6.0),
                    ),
                    child: const Text(
                      "JOIN\nnow!",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;

  CountdownTimer({required this.targetDate});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  CountdownTime _countdownTime =
      CountdownTime(days: 0, hours: 0, minutes: 0, seconds: 0);

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _countdownTime =
          _calculateCountdownTime(widget.targetDate.difference(DateTime.now()));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownPart("Days", _countdownTime.days.toString()),
        const SizedBox(width: 10),
        const Text(
          ":",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        const SizedBox(width: 10),
        CountdownPart("Hours", _countdownTime.hours.toString()),
        const SizedBox(width: 10),
        const Text(
          ":",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        const SizedBox(width: 10),
        CountdownPart("Minutes", _countdownTime.minutes.toString()),
        const SizedBox(width: 10),
        const Text(
          ":",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        const SizedBox(width: 10),
        CountdownPart("Seconds", _countdownTime.seconds.toString()),
      ],
    );
  }
}

class CountdownPart extends StatelessWidget {
  final String label;
  final String value;

  CountdownPart(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
      ],
    );
  }
}
