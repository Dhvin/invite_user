import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invite_user/theme/theme.dart' as theme;
import 'package:invite_user/widgets/all_users.dart';
import 'package:invite_user/widgets/new_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _currentIndex = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const Center(
        child: AllUser(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        iconSize: 24,
        selectedIconTheme:
            IconThemeData(color: theme.HexColor('#0CABDF'), size: 25),
        unselectedIconTheme: IconThemeData(color: theme.iconPrimary, size: 20),
        selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontFamily: 'Noto Sans',
            color: theme.iconPrimary),
        unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontFamily: 'Noto Sans',
            color: Colors.red),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_rounded,
            ),
            label: 'Loans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Chats',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InviteUser()),
          );
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AllUser()));
      }
    });
  }
}
