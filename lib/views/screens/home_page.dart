import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime d = DateTime.now();
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
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(
              60,
              (index) => Transform.rotate(
                angle: index * (pi * 2) / 60,
                child: Divider(
                  endIndent:
                      index % 5 == 0 ? size.width * 0.88 : size.width * 0.9,
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
            )
          ],
        ),
      ),
    );
  }
}
