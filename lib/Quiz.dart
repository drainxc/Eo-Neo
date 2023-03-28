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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff37B0E5),
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
              bottom: 0,
              left: width * 0.1,
              child: Column(children: [
                Container(
                  child: Column(
                    children: [Text('data')],
                  ),
                  width: width * 0.8,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffFF8A8A).withOpacity(0.4),
                        blurRadius: 50,
                      )
                    ],
                    color: Color(0xfff6f6f6),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    width: width * 0.4,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff98E843),
                    ),
                    child: Center(
                      child: Text("Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xfff6f6f6)
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
}
