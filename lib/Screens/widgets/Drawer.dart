import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ZoomDrawer(
        menuScreen: Column(
          children: [Container()],
        ),
        mainScreen: Homescreen(),
      ),
    );
  }
}
