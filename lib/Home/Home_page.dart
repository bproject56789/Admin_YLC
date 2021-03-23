import 'package:admin/pages/Suspended.dart';
import 'package:admin/pages/advocate.dart';
import 'package:admin/pages/all.dart';
import 'package:admin/pages/member.dart';
import 'package:admin/pages/questions_module/screens/questions_page.dart';
import 'package:admin/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List pages = [
    // Statistics(),
    Admin(),
    Member(),
    Advocate(),
    Suspended(),
    QuestionsPage(),
  ];

  final List appBarTitle = [
    // 'Statistics',
    'All',
    'Member',
    'Advocate',
    'Suspended',
    'Questions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          appBarTitle[currentIndex],
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
      ),
      drawer: CDrawer(
        onPageChanged: (int index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
              print(index);
            });
          }
        },
      ),
      body: pages[currentIndex],
    );
  }
}
