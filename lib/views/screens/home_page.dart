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
  bool _isStrap = false;
  bool _digital = false;
  bool _img = false;
  String bgImage = "";
  List allimage = [
    "https://i.pinimg.com/564x/6a/aa/ab/6aaaab354709ef2fa16fbd72299c8f55.jpg",
    "https://thumbs.dreamstime.com/b/tile-floor-brick-wall-background-lights-night-hd-image-large-resolution-can-be-used-as-desktop-wallpaper-real-zise-184215885.jpg",
    "https://i.pinimg.com/736x/5e/4d/3d/5e4d3d3e9d3ca61cf288c25fac5cd590.jpg",
    "https://images.unsplash.com/photo-1483232539664-d89822fb5d3e?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGhvdG8lMjBiYWNrZ3JvdW5kfGVufDB8fDB8fHww",
    "https://i.pinimg.com/originals/eb/ac/70/ebac7025c4b0278ffd4bf23462611545.jpg",
    "https://e1.pxfuel.com/desktop-wallpaper/111/132/desktop-wallpaper-cb-backgrounds-green-cb-background.jpg",
    "https://t4.ftcdn.net/jpg/03/59/98/31/360_F_359983118_OUEqWt9VPKM2rysrc0S9AeQ2vP1VrkZ6.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ50Brdwt97TqhP2cEco0mMxlPPhrgNH_oDFg&usqp=CAU",
    "https://img.freepik.com/free-vector/geometric-shapes-neon-lights-background_23-2148445830.jpg?q=10&h=200",
    "https://images.pexels.com/photos/253905/pexels-photo-253905.jpeg?cs=srgb&dl=pexels-juraj-masar-253905.jpg&fm=jpg",
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
                onChanged: (val) => _isStrap = !_isStrap),
            clockOptionTile(
                title: ("Digital"),
                val: _digital,
                onChanged: (val) => _digital = !_digital),
            clockOptionTile(
                title: ("image"), val: _img, onChanged: (val) => _img = !_img),
            Visibility(
              visible: _img,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: allimage
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              bgImage = e;
                              setState(() {});
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              height: size.height * 0.1,
                              width: size.width * 0.2,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(5, 5),
                                    blurRadius: 7,
                                  ),
                                ],
                              ),
                              child: Image.network(
                                e,
                                fit: BoxFit.cover,
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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: _img
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
                        endIndent: size.width * 0.4 - 16,
                        color: Colors.red,
                        thickness: 2.5,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                  ),
                ],
              ),
            ),

            //Strap
            Visibility(
              visible: _isStrap,
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
            Visibility(
              visible: _digital,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        height: size.height * 0.1,
                        width: size.width * 0.17,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(3, 3),
                                  blurRadius: 7)
                            ],
                            color: Colors.white),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            d.hour.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                      const Text(
                        ":",
                        style: TextStyle(fontSize: 40),
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        height: size.height * 0.1,
                        width: size.width * 0.17,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(3, 3),
                                  blurRadius: 7)
                            ],
                            color: Colors.white),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            d.minute.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                      const Text(
                        ":",
                        style: TextStyle(fontSize: 40),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        height: size.height * 0.1,
                        width: size.width * 0.17,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(3, 3),
                                  blurRadius: 7)
                            ],
                            color: Colors.white),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            d.second.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    height: size.height * 0.1,
                    width: size.width * 0.55,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(3, 3),
                              blurRadius: 7)
                        ],
                        color: Colors.white),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        (d.day, d.month, d.year).toString(),
                        style: const TextStyle(fontSize: 40),
                      ),
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
