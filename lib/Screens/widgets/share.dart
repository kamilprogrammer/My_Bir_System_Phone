import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;

class ShareWidget extends StatefulWidget {
  const ShareWidget({super.key, required this.report_id});
  final report_id;

  @override
  State<ShareWidget> createState() => _ShareState();
}

class _ShareState extends State<ShareWidget> {
  List<dynamic> workers = [];

  int share1 = 0;
  int share2 = 0;

  List<bool> workers_select = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    reload();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 400,
      width: MediaQuery.of(context).size.width - 60,
      child: Dialog(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تحويل المهمة",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'font1',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RefreshIndicator(
                child: SizedBox(
                  height: (80 * (workers.length < 3 ? workers.length : 3))
                      .toDouble(),
                  width: MediaQuery.of(context).size.width - 80,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemCount: workers.length,
                    itemBuilder: (context, index) {
                      final worker = workers[index];

                      return ListTile(
                        selected: workers_select[index],
                        selectedTileColor: Color.fromARGB(56, 78, 78, 78),
                        tileColor: workers_select[index] == false
                            ? Colors.white24
                            : Colors.amber,
                        onLongPress: () {
                          if (workers_select[index] == true) {
                            if (share1 == index + 1) {
                              setState(() {
                                share1 = 0;
                                workers_select[index] = false;
                              });
                            } else if (share2 == index + 1) {
                              setState(() {
                                share2 = 0;
                                workers_select[index] = false;
                              });
                            } else {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context).pop();
                              });
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context).pop();
                              });
                              showDialog(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              40,
                                      child:
                                          False(text: "يوجد مشكلة في النظام"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            if (share1 == 0) {
                              setState(() {
                                share1 = index + 1;
                                workers_select[index] = true;
                              });
                            } else {
                              setState(() {
                                share2 = index + 1;
                                workers_select[index] = true;
                              });
                            }
                          }
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                        title: Text(
                          worker['username'],
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          worker['section'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color.fromARGB(211, 0, 0, 0),
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                      //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
                    },
                  ),
                ),
                onRefresh: () => reload(),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 108) / 2,
                      decoration: ShapeDecoration(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "إلغاء",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width - 108) / 2,
                      decoration: ShapeDecoration(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          Share();
                        },
                        child: Text(
                          "تحويل",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'font1',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> reload() async {
    try {
      final url =
          Uri.parse("http://192.168.1.159:8000/report/${widget.report_id + 1}");
      final response = await http.post(url);
      final body = response.bodyBytes;

      final json = jsonDecode(utf8.decode(body)) as Map<String, dynamic>;

      if (json['done_by'] != '0' && json['done_by2'] != '0') {
        setState(() {
          workers_select[int.parse(json['done_by']) - 1] = true;
          share1 = int.parse(json['done_by']);

          workers_select[int.parse(json['done_by2']) - 1] = true;
          share2 = int.parse(json['done_by2']);
        });
      } else if (json['done_by'] != '0') {
        setState(() {
          workers_select[int.parse(json['done_by']) - 1] = true;
          share1 = int.parse(json['done_by']);
        });
      } else if (json['done_by2'] != '0') {
        setState(() {
          workers_select[int.parse(json['done_by2']) - 1] = true;
          share2 = int.parse(json['done_by2']);
        });
      }
    } catch (e) {
      print(e);
    }
    try {
      final url = Uri.parse("http://192.168.1.159:8000/workers");
      final response = await http.get(url);
      final body = response.bodyBytes;
      final json = jsonDecode(utf8.decode(body));
      print(name.value);
      setState(() {
        workers = json;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> Share() async {
    if (share1 == 0 && share2 == 0) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: MediaQuery.of(context).size.width - 40,
              child: False(text: "لم يتم اختيار أي شخص"),
            ),
          ],
        ),
      );
    } else {
      final request = await http.put(Uri.parse(
          "http://192.168.1.159:8000/share/${widget.report_id + 1}/${share1}/${share2}"));

      if (request.statusCode == 200) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: True(text: "تم تحويل المهمة"),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: False(text: "حدث خطأ ما"),
              ),
            ],
          ),
        );
      }
    }
  }
}
