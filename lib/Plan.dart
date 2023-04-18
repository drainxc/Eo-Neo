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
      backgroundColor: const Color(0xffFBC00A),
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
            child: Column(children: [
              SizedBox(
                width: width * 0.9,
                height: 50,
                child: const Text('Plan',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff6f6f6),
                    )),
              ),
              SizedBox(
                  width: width * 1,
                  height: height * 0.74,
                  child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Container(
                          padding: const EdgeInsets.all(20),
                          width: width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xffC3C625).withOpacity(0.7),
                                blurRadius: 20,
                              )
                            ],
                            color: const Color(0xfff6f6f6),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Step${20 - index}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Text(
                                    '삭제',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffE4101E)),
                                  )
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: width * 0.75,
                                          child: const Text(
                                            '• 수량명사, 형식명사, 합성명사 차이 공부하기',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.75,
                                          child: const Text(
                                            '• 존경어와 겸양어',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                      },
                    ),
                  )),
            ]),
          )
        ],
      ),
    );
  }
}
