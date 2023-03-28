import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const Plan());

class Plan extends StatelessWidget {
  const Plan({Key? key}) : super(key:key);

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
        ],
      ),
    );
  }
}