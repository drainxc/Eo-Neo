import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  late List planArr = [];
  List<TextEditingController> textController = [TextEditingController()];
  bool showModal = false;

  _getPlan() async {
    final url = Uri.parse('http://10.0.2.2:8080/user/plan');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("accessToken")}'
    });

    return json.decode(utf8.decode(response.bodyBytes));
  }

  _postPlan(str) async {
    final url = Uri.parse('http://10.0.2.2:8080/user/plan');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await http.post(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('accessToken')}',
      "Content-Type": "application/json"
    },
      body: jsonEncode({
        'plan': str
      })
    );
  }

  @override
  void initState() {
    super.initState();
    _getPlan().then((res) {
      setState(() {
        planArr = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

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
                      itemCount: planArr.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Container(
                              padding: const EdgeInsets.all(20),
                              width: width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xfff6f6f6),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Step${planArr.length - index}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Text(
                                        '',
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
                                          children: List.generate(
                                            planArr[planArr.length - index - 1].length,
                                                (i) {
                                              return SizedBox(
                                                width: width * 0.7,
                                                child:
                                                Text('• ${planArr[planArr.length - index - 1][i]}'),
                                              );
                                            },
                                          ),
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
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () => {
                  setState(() {
                    showModal = true;
                  })
                },
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(37.5),
                      color: const Color(0xfff6f6f6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        )
                      ]),
                  child: const Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                          color: Color(0xffFBC00A),
                          fontSize: 61,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 0,
              left: 0,
              child: showModal ? Container(
                width: width,
                height: height,
                color: const Color(0x33000000),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    width: width * 0.85,
                    color: const Color(0xfff6f6f6),
                    height: height * 0.6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [                              InkWell(
                                onTap: () => {
                                  setState(() {
                                    showModal = false;
                                  })
                                },
                                child: const Text(
                                  '×',
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Plan',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(10),
                            height: height * 0.32,
                            decoration: BoxDecoration(
                              color: Color(0xfff6f6f6),
                              border: Border.all(
                                color: const Color(0x88888888),
                                //                   <--- border color
                                width: 1.0,
                              ),
                            ),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: <Widget>[
                                ...List.generate(
                                  textController.length,
                                      (index) =>
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: TextFormField(
                                          controller: textController[index],
                                          decoration: const InputDecoration(
                                            hintText: '계획을 입력해주세요.',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0x88888888))),
                                            focusedBorder: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  ButtonBar(
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color(0xff72B42C),
                                          foregroundColor:
                                          const Color(0xfff6f6f6),
                                          minimumSize: Size.zero,
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                        ),
                                        child: const Text(
                                          '+',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            textController
                                                .add(TextEditingController());
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color(0xffE4101E),
                                          foregroundColor:
                                          const Color(0xfff6f6f6),
                                          minimumSize: Size.zero,
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                        ),
                                        child: const Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            textController.removeLast();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(
                                          width * 0.15, 10, 0, 0),
                                      child: InkWell(
                                        onTap: () => {
                                          setState(() {
                                            List<String> request = [];
                                            for (TextEditingController element in textController) {
                                              request.add(element.text);
                                            }
                                            _postPlan("[${request.join(',')}]");
                                            planArr.add(request);
                                            showModal = false;
                                            textController = [TextEditingController()];
                                          })
                                        },
                                        child: const Text(
                                          '추가',
                                          style: TextStyle(
                                            color: Color(0xff72B42C),
                                          ),
                                        ),
                                      ))
                                ],
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              ) : const SizedBox())
        ],
      ),
    );
  }
}
