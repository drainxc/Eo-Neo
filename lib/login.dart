import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/nav.dart';
import 'package:untitled1/signup.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = "Login";

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
  Map<String, TextEditingController> loginRequest = {
    "accountId": TextEditingController(),
    "password": TextEditingController()
  };


  _PostLogin(request) async {
    final res = await http.post(Uri.parse('http://10.0.2.2:8080/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request));

    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("accessToken", jsonDecode(res.body)["accessToken"]);
    pref.setString("refreshToken", jsonDecode(res.body)["refreshToken"]);
  }

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
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                      height: height * 0.2,
                      width: width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InputBox("Login", const Icon(Icons.person),
                              loginRequest["accountId"]),
                          InputBox("Password", const Icon(Icons.lock),
                              loginRequest["password"]),
                        ],
                      )),
                  Hero(
                    tag: 'rg_btn',
                    child: Material(
                      child: InkWell(
                        onTap: () => {
                          if (!([
                            loginRequest["accountId"]?.text,
                            loginRequest["password"]?.text
                          ].contains("")))
                            {
                              _PostLogin({
                                "accountId": loginRequest["accountId"]?.text,
                                "password": loginRequest["password"]?.text
                              }).then((res) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()))
                                  })
                            }
                        },
                        child: Container(
                          width: width * 0.55,
                          height: height * 0.065,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff98E843)),
                          child: const Center(
                              child: Text(
                            'Login',
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Create Account",
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
