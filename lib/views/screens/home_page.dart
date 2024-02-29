import 'dart:math';
import 'package:clock_app/views/components/clock_option_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime d = DateTime.now();
  bool _Analog = true;
  bool _isStrap = true;
  void startClock() {
    Future.delayed(const Duration(seconds: 1), () {
      d = DateTime.now();
      setState(() {});
      startClock();
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
        title: const Text("Clock App"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Darshan"),
              accountEmail: Text("darshan@gmail.com"),
            ),
            clockOptionTile(
                title: ("Analog"),
                val: _Analog,
                onChanged: (val) => _Analog = !_Analog),
            clockOptionTile(
                title: ("Strap"),
                val: _isStrap,
                onChanged: (val) => _isStrap = !_isStrap)
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: _Analog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(
                    60,
                    (index) => Transform.rotate(
                      angle: index * (pi * 2) / 60,
                      child: Divider(
                        endIndent: index % 5 == 0
                            ? size.width * 0.88
                            : size.width * 0.9,
                        thickness: 2,
                        color: index % 5 == 0 ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.hour * (pi * 2) / 12,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 4,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.minute * (pi * 2) / 60,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: d.second * (pi * 2) / 60,
                      child: Divider(
                        indent: 50,
                        endIndent: size.width * 0.5 - 16,
                        color: Colors.red,
                        thickness: 2,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 10,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isStrap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: 8,
                    child: CircularProgressIndicator(
                      value: d.hour * (pi * 2) / 12,
                      strokeWidth: 1,
                    ),
                  ),
                  Transform.scale(
                    scale: 6,
                    child: CircularProgressIndicator(
                      value: d.minute * (pi * 2) / 60,
                      strokeWidth: 1,
                    ),
                  ),
                  Transform.scale(
                    scale: 4,
                    child: CircularProgressIndicator(
                      value: d.second * (pi * 2) / 60,
                      strokeWidth: 1,
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
