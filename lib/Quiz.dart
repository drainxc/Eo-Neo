import 'dart:async';

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
  List<Map<String, dynamic>> problem = [
    {
      "problem": "Hello,\nwhat ____ your name?",
      "answer": ["is", "are", "am", "be"],
      "correct": "is"
    },
    {
      "problem": "Hello,\nwhat ____ your name?",
      "answer": ["isa", "are", "am", "be"],
      "correct": "is"
    },
  ];

  int _selectedIndex = 0;
  List _select = List<bool>.filled(4, false, growable: true);
  bool _fail = false;

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
                                Text(
                                  "Q${_selectedIndex + 1}",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 50,
                                  child: Text(
                                    "${problem[_selectedIndex]["problem"]}",
                                    style: const TextStyle(
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
                            box('A', 0),
                            box('B', 1),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            box('C', 2),
                            box('D', 3),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () => {
                      setState(() {
                        if (_select.contains(true)) {
                          if (problem[_selectedIndex]["answer"]
                          [_select.indexOf(true)] ==
                              problem[_selectedIndex]["correct"]) {
                            _selectedIndex += 1;
                          } else {
                            _fail = true;
                            Timer(
                                const Duration(seconds: 1),
                                    () => setState(() {
                                  _fail = false;
                                }));
                          }
                          _select = List<bool>.filled(4, false, growable: true);
                        }
                      })
                    },
                    child: AnimatedContainer(
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                      width: width * 0.4,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _fail
                            ? const Color(0xffE4101E)
                            : _select.contains(true)
                                ? const Color(0xff98E843)
                                : const Color(0xffbbbbbb),
                      ),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
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
                  ),
                )
              ])),
        ],
      ),
    );
  }

  Widget box(String q, int n) {
    return InkWell(
        onTap: () => {
              setState(() {
                _select = List<bool>.filled(4, false, growable: true);
                _select[n] = true;
              })
            },
        child: AnimatedContainer(
          margin: const EdgeInsets.only(top: 15),
          width: 130,
          height: 120,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          decoration: _select[n]
              ? BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.125),
                    ),
                    BoxShadow(
                      color: Color(0xfff6f6f6),
                      spreadRadius: -4.0,
                      blurRadius: 4.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                )
              : BoxDecoration(
                  color: const Color(0xfff6f6f6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 5.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  q,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              Center(
                child: Text(
                  '${problem[_selectedIndex]["answer"][n]}',
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ));
  }


}
