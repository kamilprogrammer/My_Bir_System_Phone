import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';

class Adminhomescreen extends StatefulWidget {
  const Adminhomescreen({super.key});

  @override
  State<Adminhomescreen> createState() => _AdminhomescreenState();
}

class _AdminhomescreenState extends State<Adminhomescreen> {
  List<dynamic> reports = [];
  @override
  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  void fetchReports() async {
    try {
      final url = Uri.parse("http://192.168.1.104:8000/reports");
      final response = await http.get(url);
      final body = response.bodyBytes;
      final json = jsonDecode(utf8.decode(body));
      print(name.value);
      setState(() {
        reports = json;
      });

      print(reports);
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    int _index = 0;
    double width = MediaQuery.of(context).size.width;

    return admin1.value == 'true'
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'آخر البلاغات',
                style: TextStyle(
                  fontFamily: 'font1',
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final report = reports[index];

                          return AdminCard(
                              name: report['name'],
                              onTap1: () {},
                              onTap2: () {},
                              section: report['place'],
                              type: report['kind'],
                              desc: report['desc'],
                              floor: index + 1,
                              done: bool.parse(report["done"]),
                              admin: true);
                          //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
                        },
                      ),
                    ),

                    ///ListView.builder(itemCount: ,),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: fetchReports,
              child: Icon(Icons.replay_outlined),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: False(text: "حدث خطأ ما"),
              ),
            ],
          );
  }
}
