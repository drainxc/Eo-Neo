import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const Setting());

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

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
      backgroundColor: const Color(0xff72B42C),
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
              top: 100,
              left: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: width * 0.9,
                    height: 50,
                    child: const Text('Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff6f6f6),
                        )),
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.9,
                          height: 300,
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f6f6),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xaa8AFFB2),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: width * 0.8,
                                height: 70,
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                    ),
                                    Text('Lee Dong Hyeon'),
                                  ],
                                ),
                              ),
                              DividerHr(width),
                              SizedBox(
                                width: width * 0.8,
                                height: 70,
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Icon(
                                        Icons.person_off,
                                        size: 30,
                                      ),
                                    ),
                                    Text('Delete Account'),
                                  ],
                                ),
                              ),
                              DividerHr(width),
                              SizedBox(
                                width: width * 0.8,
                                height: 70,
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Icon(
                                        Icons.delete,
                                        size: 30,
                                      ),
                                    ),
                                    Text('Lee Dong Hyeon'),
                                  ],
                                ),
                              ),
                              DividerHr(width),
                              SizedBox(
                                width: width * 0.8,
                                height: 70,
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Icon(
                                        Icons.logout,
                                        size: 30,
                                      ),
                                    ),
                                    Text('Lee Dong Hyeon'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // ignore: prefer_const_constructors
                    margin: EdgeInsets.only(top: 30),
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.9,
                          height: 60,
                          child: Row(
                            children: const [
                              Text('Develop',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfff6f6f6),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.9,
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f6f6),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xaa8AFFB2),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: width * 0.8,
                                height: 70,
                                child: Row(
                                  children: const [
                                    SizedBox(
                                      width: 52,
                                      height: 52,
                                      child: Icon(
                                        Icons.code,
                                        size: 30,
                                      ),
                                    ),
                                    Text('https://github.com/eastcopper/jang'),
                                  ],
                                ),
                              ),
                              DividerHr(width),
                              SizedBox(
                                width: width * 0.8,
                                height: 70,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 52,
                                      height: 52,
                                      child: const Icon(
                                        Icons.email_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    const Text('Email: ldh7228@gmail.com'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget DividerHr(width) {
    return Container(
      height: 2,
      width: width * 0.8,
      color: const Color(0xff72B42C),
    );
  }
}
