import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';

class Adminhomescreen extends StatefulWidget {
  const Adminhomescreen({super.key});

  @override
  State<Adminhomescreen> createState() => _AdminhomescreenState();
}

class _AdminhomescreenState extends State<Adminhomescreen> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                    'آخر البلاغات',
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
                name: "كامل الرفاعي",
                floor: 3,
                desc: "الانترنت لا يعمل في قسم ال IT",
                onTap1: () {},
                onTap2: () {},
                section: "قسم البرمجة",
                type: "الانترنت في الهاتف و اللابتوب",
                done: false,
                admin: false,
              ),
              SizedBox(
                height: 40,
              ),
              AdminCard(
                name: "نهاد الصوفي",
                floor: 10,
                desc: "التلفون الرئيسي لا يعمل",
                onTap1: () {},
                onTap2: () {},
                section: "الاستقبال",
                type: "تلفون",
                done: true,
                admin: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
