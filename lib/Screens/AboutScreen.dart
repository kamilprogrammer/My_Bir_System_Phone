import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [],
          title: Text(
            "عن التطبيق",
            style: TextStyle(fontFamily: "font1"),
          ),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Homescreen()));
            },
          )),
      body: Container(
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
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bir.jpg"),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x7F000000),
                        blurRadius: 10,
                        offset: Offset(4, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Albir-complaints-App',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7599999904632568),
                fontSize: 18,
                fontFamily: 'Janna LT',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'version: 1.0.0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Janna LT',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
