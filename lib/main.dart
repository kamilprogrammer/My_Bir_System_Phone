import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';

import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/LoginScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/test.dart';
import 'package:rjd_app/Screens/widgets/MenuPage.dart';
import 'package:rjd_app/Screens/widgets/menu_item.dart';

class MenuItems {
  static const home = MenuItem("الصفحة الرئيسية", Icons.home_outlined);
  static const add =
      MenuItem("ابلاغ عن مشكلة", Icons.add_circle_outline_outlined);
  static const info = MenuItem("عن التطبيق", Icons.info_outline_rounded);

  static const all = <MenuItem>[home, add, info];
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MenuItem current = MenuItems.home;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ZoomDrawer(
        style: DrawerStyle.defaultStyle,
        angle: 5,
        menuBackgroundColor: Colors.white,
        mainScreenTapClose: true,
        overlayBlur: 2.0,
        menuScreen: Builder(
          builder: (context) => Menupage(
            current: current,
            onselect: (item) {
              setState(() {
                current = item;
              });
              ZoomDrawer.of(context)!.close();
            },
          ),
        ),
        mainScreen: getScreen(),
      ),
    );
  }

  Widget getScreen() {
    switch (current) {
      case MenuItems.home:
        return Homescreen();

      case MenuItems.add:
        return ReportScreen();

      case MenuItems.info:
      default:
        return AboutScreen();
    }
  }
}

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'assets/bir.jpg',
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80000000),
                        offset: Offset(4, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 172,
                    height: 172,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              'Al-bir complaints application',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF5B4F4F),
                fontSize: 16,
                fontFamily: 'font1',
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              child: const Text(
                'version: 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5B5050),
                  fontSize: 16,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 174,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 52,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.00, -0.04),
                  end: Alignment(1, 0.04),
                  colors: [Color(0xFFA6FAFF), Color(0xFF1CE0EC)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'التالي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
