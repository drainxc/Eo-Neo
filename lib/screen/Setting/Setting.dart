import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:untitled1/screen/Auth/Login/login.dart';
import 'package:untitled1/screen/Nav/nav.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Map<String, dynamic> _userInfo = {};
  _getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final url = Uri.parse('http://10.0.2.2:8080/user');
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
      'Bearer ${pref.getString("accessToken")}',
    });
    return json.decode(response.body);
  }

  _putClearLog() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final url = Uri.parse("http://10.0.2.2:8080/user/clear/log");
    await http.put(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("accessToken")}'
    });
  }

  _deleteUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final url = Uri.parse("http://10.0.2.2:8080/user/delete");
    await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${pref.getString('accessToken')}"
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser().then((res) {
      setState(() {
        _userInfo = res;
      });
    });
  }

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
                                color: Color(0x558AFFB2),
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Box(
                                  width,
                                  "${_userInfo["nickName"]}",
                                  const Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                  () {}),
                              DividerHr(width),
                              Box(
                                  width,
                                  "Delete account",
                                  const Icon(
                                    Icons.person_off,
                                    size: 30,
                                  ), () {
                                _deleteUser().then(() => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()))
                                    });
                              }),
                              DividerHr(width),
                              Box(
                                  width,
                                  "Clear log",
                                  const Icon(
                                    Icons.delete,
                                    size: 30,
                                  ), () {
                                _putClearLog().then(() => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const HomeScreen()))
                                    });
                              }),
                              DividerHr(width),
                              Box(
                                  width,
                                  "Log out",
                                  const Icon(
                                    Icons.logout,
                                    size: 30,
                                  ), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              })
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
                              Box(
                                  width,
                                  "https://github.com/eastcopper/jang",
                                  const Icon(
                                    Icons.code,
                                    size: 30,
                                  ),
                                  () {}),
                              DividerHr(width),
                              Box(
                                  width,
                                  "Email: ldh7228@gmail.com",
                                  const Icon(
                                    Icons.mail_outline,
                                    size: 30,
                                  ),
                                  () {}),
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

  Widget Box(width, String text, icon, tapFunc) {
    return InkWell(
      onTap: tapFunc,
      child: SizedBox(
        width: width * 0.8,
        height: 70,
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              child: icon,
            ),
            Text('$text'),
          ],
        ),
      ),
    );
  }
}
