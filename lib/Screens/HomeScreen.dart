import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<dynamic> reports = [];
  @override
  @override
  void initState() {
    super.initState();
    fetch_rep_user();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 20),
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
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
                    floor: 7,
                    done: bool.parse(report["done"]),
                    admin: false);
                //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetch_rep_user,
        child: Icon(Icons.replay_outlined),
      ),
    );
  }

  void fetch_rep_user() async {
    print(name.value);
    try {
      final url =
          Uri.parse("http://192.168.1.104:8000/report/${user_id.value}");
      final response = await http.get(url);
      final body = response.bodyBytes;
      final json = jsonDecode(utf8.decode(body));
      setState(() {
        reports = json;
      });
      print(reports);
    } catch (e) {
      print(e);
    }
  }
}
