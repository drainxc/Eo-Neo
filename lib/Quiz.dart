import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const Quiz());

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var array = [
    {
      "problem": "Hello,\nwhat ____ your name?",
      "answer": ["is", "are", "am", "be"],
      "correct": "is"
    },
    {"a": "asd"},
    {"a": "asd"},
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff37B0E5),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 250,
            top: -100,
            child: Transform.rotate(
              angle: -30 * math.pi / 180,
              child: Container(
                width: 120,
                height: 700,
                color: const Color(0xfff6f6f6),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: width * 0.1,
              child: Column(children: [
                Container(
                  width: width * 0.8,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff8ABDFF).withOpacity(0.4),
                        blurRadius: 50,
                      )
                    ],
                    color: const Color(0xfff6f6f6),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '문법',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff888888)),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Q1',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    'Hello,\nwhat ____ your name?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xfff6f6f6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "is",
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xfff6f6f6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Text(
                                      "B",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "are",
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xfff6f6f6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Text(
                                      "C",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "am",
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 130,
                              height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xfff6f6f6),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 5.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Text(
                                      "D",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      "be",
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    width: width * 0.4,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff98E843),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xfff6f6f6)),
                      ),
                    ),
                  ),
                )
              ])),
        ],
      ),
    );
  }
}
