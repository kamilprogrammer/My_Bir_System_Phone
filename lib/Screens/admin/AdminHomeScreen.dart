import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen2.dart';
import 'package:http/http.dart' as http;

import 'package:rjd_app/Screens/widgets/Card.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/widgets/Full-Admin-Card.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Adminhomescreen extends StatefulWidget {
  const Adminhomescreen({super.key});

  @override
  State<Adminhomescreen> createState() => _AdminhomescreenState();
}

class _AdminhomescreenState extends State<Adminhomescreen> {
  @override
  @override
  void initState() {
    super.initState();
    fetchEmployees();
    fetchReports("All", "All");
  }

  List reports = [];
  List employees = [];

  @override
  Widget build(BuildContext context) {
    String user = "All";
    String date = "All";

    int index = 0;
    int inedxClicked = 0;
    double width = MediaQuery.of(context).size.width;
    String? val = "";
    return admin1.value == 'true'
        ? PopScope(
            canPop: false,
            child: Scaffold(
              drawer: const MyDrawer(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const AdminHomeScreen2()));
                },
                child: const Icon(
                  Icons.next_plan,
                  color: Color(0xFF323751),
                ).animate().rotate(),
              ).animate().scaleXY(),
              appBar: AppBar(
                actions: [
                  DropdownButton(
                    iconEnabledColor: Colors.black,
                    underline: const SizedBox(
                      height: 0,
                    ),
                    padding: const EdgeInsets.all(10),
                    iconSize: 30.0,
                    style: const TextStyle(
                      color: Colors.white,
                      //backgroundColor: Color(0xFF2B3185),
                    ),
                    onChanged: (String? newval) {
                      setState(() {
                        val = newval;
                      });
                      if (val == "Today") {
                        setState(() {
                          date = DateFormat("yyyy-MM-dd")
                              .format(DateTime.now())
                              .toString();
                        });
                        fetchReports(date, user);
                      } else if (val == "Yesterday") {
                        setState(() {
                          date = DateFormat("yyyy-MM-dd")
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 1)))
                              .toString();
                        });
                        fetchReports(date, user);
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: "All",
                        onTap: () {
                          fetchEmployees();
                          fetchReports("All", "All");
                        },
                        child: Container(
                            child: const Text(
                          '',
                          style: TextStyle(
                            color: Color(0xFF2B3185),
                            fontFamily: "font1",
                          ),
                        )),
                      ),
                      DropdownMenuItem(
                        value: "Today",
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              'اليوم',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B3185),
                                fontFamily: "font1",
                              ),
                            )),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Yesterday",
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              'البارحة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B3185),
                                fontFamily: "font1",
                              ),
                            )),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "None",
                        onTap: () {
                          fetchEmployees();
                          fetchReports("All", "All");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF2B3185),
                                fontFamily: "font1",
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                    //value: val,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                  ),
                ],
                toolbarHeight: 50.0,
                title: const Text(
                  'آخر البلاغات',
                  style: TextStyle(
                      fontFamily: 'font1',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                centerTitle: true,
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 8,
                              ),
                              itemCount: employees.length,
                              itemBuilder: (context, index) {
                                final employee = employees[index];
                                return GestureDetector(
                                  onTap: () {
                                    if (employee['username'] !=
                                        "جميع الحسابات") {
                                      setState(() {
                                        employees = employees.where((test) {
                                          return test['username'] ==
                                              employee['username'];
                                        }).toList();
                                        employees.insert(
                                            0, {"username": "جميع الحسابات"});

                                        inedxClicked = index;
                                        user = employee['username'];
                                      });
                                      fetchReports(date, user);
                                    } else {
                                      fetchReports("All", "All");
                                      fetchEmployees();
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF323751),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${employee['username']}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontFamily: "font1",
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                                .animate(
                                    delay: const Duration(milliseconds: 50))
                                .fade()
                                .slideY(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: RefreshIndicator(
                            color: Colors.blueAccent,
                            onRefresh: () {
                              return fetchReports(user, date);
                            },
                            child: reports.isEmpty
                                ? False(
                                    text: worker.value == 'true'
                                        ? "لايوجد أي طلب صيانة محوّل إليك"
                                        : "لا يوجد أي طلبات صيانة")
                                : ListView.builder(
                                    itemCount: reports.length,
                                    itemBuilder: (context, index) {
                                      final report = reports[index];

                                      return GestureDetector(
                                        onTap: () {
                                          if (admin1.value == "true") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Full_Admin_Card(
                                                  card: report,
                                                  index: index,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: StatusCard(
                                          notes: report['notes'],
                                          title: report['name'],
                                          section: report['place'],
                                          desc: report['desc'],
                                          done: bool.parse(report["done"]),
                                          index: index,
                                        ).animate().fade().slide(),
                                      );
                                    },
                                  ).animate().fade().flip()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const False(text: "حدث خطأ في النظام"),
              ),
            ],
          );
  }

  Future<void> fetchReports(date, user) async {
    final url = Uri.parse("http://192.168.0.100:3666/reports");
    final response = await http.get(url);
    final body = response.bodyBytes;
    final finalJson = jsonDecode(utf8.decode(body));
    if (date == "All" && user == "All") {
      setState(() {
        reports = finalJson;
        reports = reports.where((test) {
          return test['done'] == "false";
        }).toList();
      });
    } else if (date != "All") {
      setState(() {
        reports = finalJson;
        reports = reports
            .where((report) {
              return report['date'] == date;
            })
            .toList()
            .where((test) {
              return test['done'] == "false";
            })
            .toList();
      });
      print(reports);
    } else if (user != "All") {
      setState(() {
        reports = finalJson;
        reports = reports
            .where((report) {
              return report['name'] == user.toString();
            })
            .toList()
            .where((test) {
              return test['done'] == "false";
            })
            .toList();
      });
    }
  }

  Future<void> fetchEmployees() async {
    final url = Uri.parse("http://192.168.0.100:3666/employees");
    final response = await http.get(url);
    final body = response.bodyBytes;
    final json = jsonDecode(utf8.decode(body));
    setState(() {
      employees = json;
      employees.insert(0, {'username': 'جميع الحسابات'});
    });
  }

  /*void View_Share(int status) async {
    //final reportShared = reports[status];
    //int reportId = reportShared['id'];
    print(reportId);

    showDialog(
        context: context,
        builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width - 60,
              child: ShareWidget(
                report_id: reportId,
              ),
            ));
  }*/
}
