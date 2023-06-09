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

  int _selectedIndex = 0;
  List _select = List<bool>.filled(4, false, growable: true);
  bool _fail = false;

  _getUser(kind) async {
    final url = Uri.parse('http://10.0.2.2:8080/user');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
          'Bearer ${pref.getString("accessToken")}',
    });

    final correctKindList = [
      "correctBasic",
      "correctLanguage",
      "correctConversation",
      "correctWord"
    ];

    return json.decode(response.body)[correctKindList[kind]] as int;
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
    final _categoryList = [
      "BASIC","LANGUEGE","CONVERSATION","WORD"
    ];
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final url = Uri.parse("http://10.0.2.2:8080/quiz/${_categoryList[kind]}");
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
      _getUser(0).then((res) {
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
    List kindList = ["BASIC", "LANGUAGE", "CONVERSATION", "WORD"];

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
                                      "${problem.isNotEmpty ? problem[_selectedIndex]["problem"] : ""}",
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
                        ]),
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
                            try {
                              problem[_selectedIndex + 1];
                              _selectedIndex += 1;
                              _putCorrect(kind);
                            } catch (e) {
                              print('문제 수 초과');
                            }
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
          height: 135,
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
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: Center(
                  child: Text(
                    '${problem.isNotEmpty ? problem[_selectedIndex]["answer"][n] : ""}',
                    style: TextStyle(
                        fontSize: problem.isNotEmpty
                            ? problem[_selectedIndex]["answer"][n].length >= 15
                                ? 15
                                : 25
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
