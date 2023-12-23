import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

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
  final homeController = Get.find<HomeController>();

  CountdownTimerWidget({Key? key, required this.targetDate}) : super(key: key);

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
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  homeController.homeModel.value.nearestEvent?.name ?? "",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                homeController.homeModel.value.nearestEvent != null
                    ? Container(
                        margin: const EdgeInsets.all(8.0),
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          image: homeController
                                      .homeModel.value.nearestEvent?.imageUrl !=
                                  null
                              ? DecorationImage(
                                  image: NetworkImage(homeController
                                      .homeModel.value.nearestEvent!.imageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      )
                    : const CardItemShimmer(),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      children: <TextSpan>[
                        homeController.homeModel.value.nearestEvent != null
                            ? const TextSpan(
                                text: "Berlokasi di ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : const TextSpan(text: ""),
                        TextSpan(
                          text: homeController
                                  .homeModel.value.nearestEvent?.location ??
                              "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextSpan(
                          text:
                              "\n\n\t\t\t\t\t ${homeController.homeModel.value.nearestEvent?.description ?? ""}",
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: Container(
                        padding: const EdgeInsets.all(17.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF8C00), Color(0xFFFF2D55)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: homeController.homeModel.value.nearestEvent !=
                                null
                            ? CountdownTimer(
                                targetDate: DateTime.fromMillisecondsSinceEpoch(
                                    homeController
                                            .homeModel.value.nearestEventTime! *
                                        1000,
                                    isUtc: true),
                              )
                            : CountdownTimer(targetDate: targetDate),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(12, 74),
                          backgroundColor: const Color(0XFF10A7E8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(6.0),
                        ),
                        child: const Text(
                          "JOIN\nnow!",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
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
  HomeController homeController = Get.find<HomeController>();
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
      if (homeController.homeModel.value.nearestEvent == null) return;

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
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10.0,
      runSpacing: 10.0,
      children: [
        CountdownPart("Days", _countdownTime.days.toString()),
        const CountdownSeparator(),
        CountdownPart("Hours", _countdownTime.hours.toString()),
        const CountdownSeparator(),
        CountdownPart("Minutes", _countdownTime.minutes.toString()),
        const CountdownSeparator(),
        CountdownPart("Seconds", _countdownTime.seconds.toString()),
      ],
    );
  }
}

class CountdownSeparator extends StatelessWidget {
  const CountdownSeparator();

  @override
  Widget build(BuildContext context) {
    return const Text(
      ":",
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
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

// make card item shimmer from above code card
class CardItemShimmer extends StatelessWidget {
  const CardItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          height: 180.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
