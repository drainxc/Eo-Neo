import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:untitled1/Home.dart';

void main() => runApp(const Plan());

class Plan extends StatelessWidget {
  const Plan({Key? key}) : super(key: key);

  static const String _title = "Plan";

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<String> entries = <String>['A', 'B', 'C'];
    final List planArr = [
      {
        "id": 0,
        "plan": ["asdasd", 'sdfsdf', 'dfgdfg'],
        "success": [false, false, false],
      },
      {
        "id": 1,
        "plan": ["asdasd", 'sdfsdf', 'dfgdfg'],
        "success": [false, false, false],
      },
    ];


    return Scaffold(
      backgroundColor: Color(0xffFBC00A),
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
                color: Color(0xfff6f6f6),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Column(children: [
              Container(
                width: width * 0.9,
                height: 50,
                child: Text('Plan',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff6f6f6),
                    )),
              ),
              Container(
                width: width * 1,
                height: height * 0.74,
                child: SafeArea(
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: Container(
                                width: width * 1,
                                height: 100,
                                color: Color(0xfff6f6f6),
                              )
                          );
                        },
                      ),
                    ),
                )
              ),
            ]),
          )
        ],
      ),
    );
  }
}
