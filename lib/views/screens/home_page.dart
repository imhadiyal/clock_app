import 'dart:async';
import 'package:analog_clock/analog_clock.dart';
import 'package:clock_app/views/components/clock_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime d = DateTime.now();
  Timer? timer;
  bool started = true;
  List laps = [];
  bool Analog = true;
  bool isStrap = false;
  bool digital = false;
  bool img = false;
  bool stopwatch = false;
  int sec = 0;
  int min = 0;
  int hou = 0;
  String sSec = "00";
  String sMin = "00";
  String sHou = "00";
  void start() {
    started = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        sec++;
        if (sec > 59) {
          if (min > 59) {
            hou++;
            min = 0;
          } else {
            min++;
            sec = 0;
          }
        }
        setState(
          () {
            min = min;
            hou = hou;

            sSec = (sec >= 10) ? "$sec" : "0$sec";
            sHou = (sec >= 10) ? "$hou" : "0$hou";
            sMin = (min >= 10) ? "$min" : "0$min";
          },
        );
      },
    );
  }

  //Lap Process
  void addLaps() {
    String lap = "$sHou:$sMin:$sSec";
    setState(() {
      laps.add(lap);
    });
  }

  void resetStopWatch() {
    timer!.cancel();
    setState(() {
      started = false;
      sec = 0;
      min = 0;
      hou = 0;

      sSec = "00";
      sMin = "00";
      sHou = "00";
      started = false;
    });
  }

  String bgImage = "";
  List allimagurl = [
    "https://images.pexels.com/photos/235985/pexels-photo-235985.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTEyL3Jhd3BpeGVsX29mZmljZV8yM193YXRlcmNvbG9yX2lsbHVzdHJhdGlvbl9vZl9ncmVlbl9wYXN0ZWxfYmFja181Zjg4YmIwZS0xNWZkLTRkNGItYTNlNS0zZDYyOTdiNjk3NDdfMS5qcGc.jpg",
    "https://i.pinimg.com/736x/5e/4d/3d/5e4d3d3e9d3ca61cf288c25fac5cd590.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO6ivajcK0jdi5wcH5uE4fORAdH2oxPyt6spGqCJGxnmX0ekgdQhT7jTff7304vlsW00w&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjqkv1AqEZdDzuNtjbasddA6C4dMp7lQvEmM5Lx7ohhrAzLz2ZbzhL6iKGvpIzu-sqwwQ&usqp=CAU",
    "https://e1.pxfuel.com/desktop-wallpaper/111/132/desktop-wallpaper-cb-backgrounds-green-cb-background.jpg",
    "https://images.freecreatives.com/wp-content/uploads/2016/04/Beautiful-Green-Plain-Background-.jpg",
    "https://i.pinimg.com/originals/b6/78/a2/b678a2998e02da50413b35f061e9d09a.jpg",
    "https://images.template.net/wp-content/uploads/2015/11/25190806/Free-Download-Brown-Plain-Wood-Background.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs4iYEe6Zn2YSHgaqexNj2HtdNgQzSDlDAiw&usqp=CAU",
  ];

  void startClock() async {
    await Future.delayed(const Duration(seconds: 1), () {
      d = DateTime.now();
      startClock();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    startClock();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: const Text("Clock App"),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(),
              accountName: Text("Darshan"),
              accountEmail: Text("darshan@gmail.com"),
            ),
            clockOptionTile(
                title: ("Analog"),
                val: Analog,
                onChanged: (val) => Analog = !Analog),
            clockOptionTile(
                title: ("Strap"),
                val: isStrap,
                onChanged: (val) => isStrap = !isStrap),
            clockOptionTile(
                title: ("Digital"),
                val: digital,
                onChanged: (val) => digital = !digital),
            clockOptionTile(
                title: ("Stop Watch"),
                val: stopwatch,
                onChanged: (val) => stopwatch = !stopwatch),
            clockOptionTile(
                title: ("image"), val: img, onChanged: (val) => img = !img),
            Visibility(
              visible: img,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: allimagurl
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              bgImage = e;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: size.height * 0.15,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(5, 5),
                                    blurRadius: 5,
                                  )
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(e), fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: img
                  ? NetworkImage(bgImage)
                  : const NetworkImage(
                      "https://i.pinimg.com/1200x/84/2a/d6/842ad68b315b0f586c30b465221da609.jpg",
                    ),
              fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            //Analog
            Visibility(
              visible: Analog,
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  AnalogClock(
                    width: 400,
                    showDigitalClock: false,
                    showAllNumbers: true,
                    showSecondHand: true,
                    showTicks: true,
                    tickColor: Colors.black,
                  ),
                ],
              ),
            ),

            //Strap
            Visibility(
              visible: isStrap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 7,
                    child: CircularProgressIndicator(
                      value: d.hour / 12,
                      strokeWidth: 1,
                    ),
                  ),
                  Transform.scale(
                    scale: 5,
                    child: CircularProgressIndicator(
                      value: d.minute / 60,
                      strokeWidth: 1,
                    ),
                  ),
                  Transform.scale(
                    scale: 3,
                    child: CircularProgressIndicator(
                      value: d.second / 60,
                      strokeWidth: 1,
                    ),
                  ),
                ],
              ),
            ),
            //Digital
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Visibility(
                    visible: digital,
                    child: Transform.scale(
                      scale: 5,
                      child: DigitalClock(
                        secondDigitTextStyle:
                            const TextStyle(fontSize: 8, color: Colors.black),
                        hourMinuteDigitTextStyle:
                            const TextStyle(fontSize: 10, color: Colors.black),
                        amPmDigitTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 5,
                          fontWeight: FontWeight.bold,
                        ),
                        is24HourTimeFormat: false,
                        showSecondsDigit: true,
                      ),
                    ),
                  ),
                  //stopwatch
                  Visibility(
                    visible: stopwatch,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$sHou : $sMin : $sSec",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 56,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            start();
                          },
                          child: Text(
                            started ? "Started" : "Start",
                            style: (TextStyle(fontSize: 18)),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            resetStopWatch();
                          },
                          child: const Text(
                            "Reset",
                            style: (TextStyle(fontSize: 18)),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            addLaps();
                          },
                          icon: const Icon(
                            Icons.flag,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: laps.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Lap ${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      " ${laps[index]}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
