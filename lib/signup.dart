import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled1/login.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const Signup());

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  static const String _title = "Signup";

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

_PostSignup(request) async {
  return await http.post(Uri.parse('http://10.0.2.2:8080/auth/signup'),
      headers: {"Content-Type": "application/json"}, body: jsonEncode(request));
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Map<String, TextEditingController> controllers = {
    "accountId": TextEditingController(),
    "nickName": TextEditingController(),
    "password": TextEditingController()
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: (Stack(
      children: <Widget>[
        SizedBox(
          width: width,
          height: height,
          child: const Image(
              fit: BoxFit.fill,
              image: NetworkImage(
                  "https://cdn.discordapp.com/attachments/1071077149605384262/1090090076685488178/image.png")),
        ),
        Center(
          child: SingleChildScrollView(
            child: Container(
              width: width * 0.8,
              height: height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xfff6f6f6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 40),
                          width: width * 0.3,
                          height: width * 0.3,
                          child: const Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://cdn.discordapp.com/attachments/1071077149605384262/1110037748783529984/image.png")))
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 35),
                      height: height * 0.25,
                      width: width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InputBox(
                              "Nickname",
                              const Icon(Icons.drive_file_rename_outline),
                              controllers["nickName"]),
                          InputBox("AccountID", const Icon(Icons.person),
                              controllers["accountId"]),
                          InputBox("Password", const Icon(Icons.lock),
                              controllers["password"]),
                        ],
                      )),
                  Hero(
                    tag: 'rg_btn',
                    child: Material(
                      child: InkWell(
                        onTap: () => {
                          if (!([
                            controllers['accountId']?.text,
                            controllers['password']?.text,
                            controllers['nickName']?.text
                          ].contains('')))
                            {
                              _PostSignup({
                                "accountId": controllers['accountId']?.text,
                                'nickName': controllers['password']?.text,
                                'password': controllers['nickName']?.text
                              }).then((res) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()))
                                  })
                            }
                          else
                            {print('내용을 모두 입력해주세요!ㅁ')}
                          // print(controllers['accountId']?.text)
                        },
                        child: Container(
                          width: width * 0.55,
                          height: height * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff98E843)),
                          child: const Center(
                              child: Text(
                            'Signup',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffffffff)),
                          )),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()))
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "to Login Page",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    )));
  }

  Container InputBox(String text, icon, controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: icon,
          prefixIconColor: Colors.grey,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2, //<-- SEE HERE
              color: Colors.grey,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2, //<-- SEE HERE
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
