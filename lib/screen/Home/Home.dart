import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/provider/select.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SelectProvider _selectProvider;
  Map<String, dynamic> _userInfo = {
    "correctBasic":0,
    "correctLanguage":0,
    "correctConversation":0,
    "correctWord":0,
  };
  final List<String> _categoryList = [
    "correctBasic",
    "correctLanguage",
    "correctConversation",
    "correctWord"
  ];
  List<Map<String, dynamic>> kind = [
    {
      "icon": Icons.feed,
      "title": "Basic",
      "color": const Color(0xffFBC00A),
    },
    {
      "icon": Icons.language,
      "title": "Language",
      "color": const Color(0xffE4101E),
    },
    {
      "icon": Icons.message,
      "title": "Conversation",
      "color": const Color(0xff37B0E5),
    },
    {
      "icon": Icons.hdr_auto_sharp,
      "title": "Word",
      "color": const Color(0xff72B42C),
    }
  ];

  _getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final url = Uri.parse('http://10.0.2.2:8080/user');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${pref.getString("accessToken")}',
    });
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    _selectProvider = Provider.of<SelectProvider>(context, listen: false);
    double width = MediaQuery
        .of(context)
        .size
        .width;

    _getUser().then((res) {
      setState(() {
        _userInfo = res;
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xffE4101E),
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
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                width: width * 1,
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(65),
                    topLeft: Radius.circular(65),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffFF8A8A).withOpacity(0.4),
                      blurRadius: 50,
                    )
                  ],
                  color: const Color(0xfff6f6f6),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: width * 0.8,
                        height: 210,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xfff6f6f6),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                blurRadius: 5.0,
                                spreadRadius: 0.0,
                              )
                            ]),
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.6,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: const Text(
                                    "Hi, Lee Dong Hyeon",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: width * 0.6,
                                  color: Colors.grey,
                                ),
                                Container(
                                  width: width * 0.6,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "오늘 하루도 힘내세요!\n개발자는 당신을 응원합니다!",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Box(width, 0),
                        Box(width, 1),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Box(width, 2),
                        Box(width, 3),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Box(width, int n) {
    return InkWell(
      onTap: () {
        _selectProvider.changeState(n);
      },
      child: Container(
        width: width * 0.37,
        height: width * 0.35,
        decoration: BoxDecoration(
          color: const Color(0xfff6f6f6),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            )
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
              margin: const EdgeInsets.only(top: 15),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Provider
                    .of<SelectProvider>(context)
                    .select[n]
                    ? kind[n]["color"]
                    : const Color(0xfff6f6f6),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                kind[n]["icon"],
                color: Provider
                    .of<SelectProvider>(context)
                    .select[n]
                    ? const Color(0xfff6f6f6)
                    : kind[n]["color"],
                size: 30,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    "${kind[n]["title"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    child: Text(
                      "${_userInfo[_categoryList[n]]}/5",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        width: width * 0.3,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xffdddddd),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        width: width * _userInfo[_categoryList[n]] * 0.06,
                        height: 8,
                        decoration: BoxDecoration(
                          color: kind[n]["color"],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
