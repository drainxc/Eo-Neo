import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/provider/select.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Map<String, dynamic>> problem = [];

  Map<String, dynamic> _selectedIndex = {
    "correctBasic": 0,
    "correctLanguage": 0,
    "correctConversation": 0,
    "correctWord": 0
  };
  List _select = List<bool>.filled(4, false, growable: true);
  List _showAnswer = List<String>.filled(4, "none", growable: true);
  bool _fail = false;
  List kindList = ["BASIC", "LANGUAGE", "CONVERSATION", "WORD"];
  final correctKindList = [
    "correctBasic",
    "correctLanguage",
    "correctConversation",
    "correctWord"
  ];

  _getUser() async {
    final url = Uri.parse('http://10.0.2.2:8080/user');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${pref.getString("accessToken")}',
    });

    return json.decode(response.body);
  }

  _getQuiz(kind) async {
    final url = Uri.parse('http://10.0.2.2:8080/quiz/$kind');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<Map<String, dynamic>> problemList = jsonList.map((json) {
        return <String, dynamic>{
          'problem': json['problem'] as String,
          'answer': List<String>.from(json['answer']),
          'correct': json['correct'] as String
        };
      }).toList();

      return problemList;
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  _putCorrect(kind) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final url = Uri.parse("http://10.0.2.2:8080/quiz/${kindList[kind]}");
    await http.put(url, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${pref.getString("accessToken")}',
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getUser().then((res) {
        setState(() {
          _selectedIndex = res;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int kind = Provider.of<SelectProvider>(context).select.indexOf(true);

    _getQuiz(kindList[kind]).then((value) {
      setState(() {
        problem = value;
      });
    });

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
                          Text(
                            '${kindList[kind]}',
                            style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff888888)),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedIndex[correctKindList[kind]] < 5
                                        ? "Q${_selectedIndex[correctKindList[kind]] + 1}"
                                        : "축하드립니다!",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: 50,
                                    child: Text(
                                      _selectedIndex[correctKindList[kind]] < 5
                                          ? "${problem.isNotEmpty ? problem[_selectedIndex[correctKindList[kind]]]["problem"] : ""}"
                                          : '문제를 모두 맞추셨습니다!',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Column(
                            children: [
                              _selectedIndex[correctKindList[kind]] < 5
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            box('A', 0, kind, width, height),
                                            box('B', 1, kind, width, height),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            box('C', 2, kind, width, height),
                                            box('D', 3, kind, width, height),
                                          ],
                                        )
                                      ],
                                    )
                                  : Container(
                                      height: height * 0.35,
                                      child: const Center(
                                        child: Text(
                                          "Congratulation",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                            ],
                          )
                        ]),
                  ),
                ),
                Center(
                  child: _selectedIndex[correctKindList[kind]] < 5
                      ? InkWell(
                          onTap: () => {
                            setState(() {
                              if (_select.contains(true)) {
                                if (problem[_selectedIndex[
                                            correctKindList[kind]]]["answer"]
                                        [_select.indexOf(true)] ==
                                    problem[_selectedIndex[
                                        correctKindList[kind]]]["correct"]) {
                                  _showAnswer[_select.indexOf(true)] =
                                      "success";
                                  Timer(
                                      const Duration(seconds: 1),
                                      () => setState(() {
                                            _selectedIndex[
                                                correctKindList[kind]] += 1;
                                            _showAnswer = List<String>.filled(
                                                4, "none",
                                                growable: true);
                                          }));
                                  _putCorrect(kind);
                                } else {
                                  _fail = true;
                                  _showAnswer[_select.indexOf(true)] = "fail";
                                  Timer(
                                      const Duration(seconds: 1),
                                      () => setState(() {
                                            _fail = false;
                                          }));
                                }
                                _select =
                                    List<bool>.filled(4, false, growable: true);
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
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                          height: height * 0.06),
                )
              ])),
        ],
      ),
    );
  }

  Widget box(String q, int n, kind, width, height) {
    return InkWell(
        onTap: () => {
              setState(() {
                _select = List<bool>.filled(4, false, growable: true);
                _select[n] = true;
              })
            },
        child: AnimatedContainer(
          margin: const EdgeInsets.only(top: 15),
          width: width * 0.33,
          height: height * 0.165,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          decoration: _select[n]
              ? BoxDecoration(
                  boxShadow: [BoxShadow(
                      color: _showAnswer[n] == "none"
                          ? Color.fromRGBO(0, 0, 0, 0.125)
                          : _showAnswer[n] == "fail"
                          ? const Color(0xffFAE0E0)
                          : const Color(0xffDEF1DE),
                    ),
                    BoxShadow(
                      color: _showAnswer[n] == "none"
                          ? const Color(0xfff6f6f6)
                          : _showAnswer[n] == "fail"
                              ? const Color(0xffFAE0E0)
                              : const Color(0xffDEF1DE),
                      spreadRadius: -4.0,
                      blurRadius: 4.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                )
              : BoxDecoration(
                  color: _showAnswer[n] == "none"
                      ? const Color(0xfff6f6f6)
                      : _showAnswer[n] == "fail"
                          ? const Color(0xffFAE0E0)
                          : const Color(0xffDEF1DE),
                  boxShadow: [
                    BoxShadow(
                      color:_showAnswer[n] == "none"
                          ?  const Color.fromRGBO(0, 0, 0, 0.25)
                          : _showAnswer[n] == "fail"
                          ? const Color(0xffFAE0E0)
                          : const Color(0xffDEF1DE),
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
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: Center(
                  child: Text(
                    '${problem.isNotEmpty ? problem[_selectedIndex[correctKindList[kind]]]["answer"][n] : ""}',
                    style: TextStyle(
                        fontSize: problem.isNotEmpty
                            ? problem[_selectedIndex[correctKindList[kind]]]
                                            ["answer"][n]
                                        .length >=
                                    15
                                ? 14
                                : 23
                            : 0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
