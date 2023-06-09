import 'package:flutter/material.dart';
import 'package:untitled1/page/Home/Home.dart';
import 'package:untitled1/page/Plan/Plan.dart';
import 'package:untitled1/page/Quiz/Quiz.dart';
import 'package:untitled1/page/Setting/Setting.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Quiz(),
    Plan(),
    Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.5, color: Color(0xfff6f6f6)),
            ),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color.fromRGBO(228, 16, 30, 1),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Study',
                backgroundColor: Color.fromRGBO(55, 176, 229, 1),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note),
                label: 'Plan',
                backgroundColor: Color.fromRGBO(251, 192, 10, 1),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Color.fromRGBO(114, 180, 44, 1),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            // selectedItemColor: Colors.amber[800],
          ),
        ));
  }
}

// Row(
//   children: [
//     Expanded(
//       flex: 1,
//       child: Container(
//         height: 100,
//         color: Colors.black,
//         child: Center(
//           child: Text('hello world',
//           style: TextStyle(
//             color: Colors.white
//           ),),
//         ),
//       ),
//     ),
//     Expanded(
//       flex: 1,
//       child: Container(
//         height: 100,
//         color: Colors.blue,
//       ),
//     )
//   ],
// ),
