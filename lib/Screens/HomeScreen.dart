import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/MenuWidget.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.21, 0.98),
              end: Alignment(-0.21, -0.98),
              colors: [
                Color(0xFF17161C),
                Color(0xFF323751),
                Color(0x6F3949A1),
                Color(0x000026FF)
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اخر البلاغات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'font1',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              AdminCard(
                name: "name",
                onTap1: () {},
                onTap2: () {},
                section: "section",
                type: "type",
                desc: "desc",
                floor: 9,
                done: true,
                admin: false,
              ),
              SizedBox(
                height: 20,
              ),
              AdminCard(
                name: "name2",
                onTap1: () {},
                onTap2: () {},
                section: "section2",
                type: "type2",
                desc: "desc2",
                floor: 8,
                done: false,
                admin: false,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
