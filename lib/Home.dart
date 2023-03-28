import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: Color(0xffE4101E),
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
              child: Container(
                child: Column(
                  children: [Text('data')],
                ),
                width: width * 1,
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(65),
                      topLeft: Radius.circular(65),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffFF8A8A).withOpacity(0.4),
                      blurRadius: 50,
                    )
                  ],
                  color: Color(0xfff6f6f6),
                ),
              ))
        ],
      ),
    );
  }
}
