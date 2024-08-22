import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:rjd_app/main.dart';

class Adminhomescreen extends StatefulWidget {
  const Adminhomescreen({super.key});

  @override
  State<Adminhomescreen> createState() => _AdminhomescreenState();
}

class _AdminhomescreenState extends State<Adminhomescreen> {
  List<dynamic> reports = [];

  bool done_reports = false;
  bool reports_done = false;
  @override
  @override
  void initState() {
    super.initState();
    fetchReports(done_reports);
  }

  Future<void> fetchReports(bool done_reports) async {
    if (done_reports == true) {
      try {
        final url = Uri.parse("http://192.168.1.155:8000/reports");
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
    } else {
      try {
        final url = Uri.parse("http://192.168.1.155:8000/reports");
        final response = await http.get(url);
        final body = response.bodyBytes;
        final json = jsonDecode(utf8.decode(body));
        print(name.value);
        setState(() {
          reports = json;
          reports = reports.where((test) {
            print("The test['done] is :" + test['done'].toString());
            return (test['done'].toString().toLowerCase().contains('false'));
          }).toList();
        });

        print(reports);
      } catch (e) {
        print(e);
      }
    }
  }

  void Delete(int status) async {
    final updated_report = reports[status];
    print("asas");
    final real_index = updated_report['id'];
    final req = await http
        .delete(Uri.parse("http://192.168.1.155:8000/delete/${real_index}"));

    if (req.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: MediaQuery.of(context).size.width - 40,
              child: True(text: "تم حذف البلاغ"),
            ),
          ],
        ),
      );
      fetchReports(done_reports);
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
              ));
    }
  }

  void Update(int status) async {
    final updated_report = reports[status];
    print("asas");
    final real_index = updated_report['id'];
    final req = await http
        .put(Uri.parse("http://192.168.1.155:8000/done/${real_index}"));

    if (req.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: MediaQuery.of(context).size.width - 40,
              child: True(text: "تم تحديث البيانات"),
            ),
          ],
        ),
      );
      fetchReports(done_reports);
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
              ));
    }
  }

  void NotYet(int status) async {
    final updated_report = reports[status];
    print("asas");
    final real_index = updated_report['id'];
    final req = await http
        .put(Uri.parse("http://192.168.1.155:8000/notyet/${real_index}"));

    if (req.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: MediaQuery.of(context).size.width - 40,
              child: True(text: "تم تحديث البيانات"),
            ),
          ],
        ),
      );
      fetchReports(done_reports);
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
              ));
    }
  }

  Widget build(BuildContext context) {
    int _index = 0;
    double width = MediaQuery.of(context).size.width;

    return admin1.value == 'true'
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF2B3185),
              onPressed: () {
                if (done_reports == false) {
                  setState(() {
                    done_reports = true;
                    reports_done = true;

                    if_reports_done_is_none();
                  });
                } else {
                  setState(() {
                    done_reports = false;
                    reports_done = false;

                    if_reports_done_is_none();
                  });
                }
                fetchReports(done_reports);
              },
              child: Icon(
                  done_reports == true ? Icons.remove_done : Icons.done_all),
              foregroundColor: Colors.white,
            ),
            drawer: MyDrawer(),
            appBar: AppBar(
              toolbarHeight: 50.0,
              title: Text(
                'آخر البلاغات',
                style: TextStyle(
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              centerTitle: true,
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu),
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
                        child: if_reports_done_is_none()),

                    ///ListView.builder(itemCount: ,),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
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

  if_reports_done_is_none() {
    List reports_not_done = reports.where((test) {
      print("The test['done] is :" + test['done'].toString());
      return (test['done'].toString().toLowerCase().contains('false'));
    }).toList();
    if (reports.isEmpty) {
      return Column(
        children: [False(text: "لا يوجد أي بلاغات")],
      );
    }
    if (reports_not_done.isEmpty && reports_done == false) {
      return Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
                iconColor: Colors.white, backgroundColor: Color(0xFF2B3185)),
            onPressed: () {
              if_reports_done_is_none();
              fetchReports(done_reports);
            },
            child: Icon(done_reports == true ? Icons.refresh : Icons.refresh),
          ),
          False(text: "لا يوجد بلاغات غير محلولة حتى الان"),
        ],
      );
    } else {
      return RefreshIndicator(
          onRefresh: () {
            return fetchReports(done_reports);
          },
          color: Colors.blueAccent,
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];

                print(done_reports);

                return done_reports == true
                    ? Dismissible(
                        background: Container(
                          decoration: ShapeDecoration(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        Text(
                                          "حذف البلاغ نهائياً",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        Text(
                                          "حذف البلاغ نهائياً",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          Future<bool> showAlertDialog(
                              BuildContext context, String message) async {
                            // set up the buttons
                            Widget cancelButton = ElevatedButton(
                              child: Text(
                                "لا",
                                style: TextStyle(
                                    fontFamily: 'font1',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              onPressed: () {
                                // returnValue = false;
                                Navigator.of(context).pop(false);
                              },
                            );
                            Widget continueButton = ElevatedButton(
                              child: Text(
                                "نعم",
                                style: TextStyle(
                                    fontFamily: 'font1',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.red),
                              ),
                              onPressed: () {
                                // returnValue = true;
                                Navigator.of(context).pop(true);
                              },
                            ); // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text(
                                "هل أنت متأكد؟",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: 'font1',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              content: Text(
                                message,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: 'font1',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            ); // show the dialog
                            final result = await showDialog<bool?>(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                            return result ?? false;
                          }

                          showAlertDialog(
                                  context, "الضغط على نعم سيقوم بحذف البلاغ")
                              .then((bool1) {
                            if (bool1 == true) {
                              Delete(index);
                              if_reports_done_is_none();
                              fetchReports(done_reports);
                            } else {
                              if_reports_done_is_none();
                              fetchReports(done_reports);
                            }
                          });
                        },
                        child: AdminCard(
                          name: report['name'],
                          onTap1: () {
                            Update(index);
                          },
                          onTap2: () {
                            NotYet(index);
                            if_reports_done_is_none();
                            fetchReports(done_reports);
                          },
                          section: report['place'],
                          type: report['kind'],
                          desc: report['desc'],
                          floor: index + 1,
                          done: bool.parse(report["done"]),
                          admin: true,
                          user: false,
                        ),
                      )
                    : report['done'] == 'false'
                        ? Dismissible(
                            background: Container(
                              decoration: ShapeDecoration(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            Text(
                                              "حذف البلاغ نهائياً",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'font1',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            Text(
                                              "حذف البلاغ نهائياً",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'font1',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              Delete(index);
                            },
                            child: AdminCard(
                              name: report['name'],
                              onTap1: () {
                                Update(index);
                              },
                              onTap2: () {
                                NotYet(index);
                              },
                              section: report['place'],
                              type: report['kind'],
                              desc: report['desc'],
                              floor: index + 1,
                              done: bool.parse(report["done"]),
                              admin: true,
                              user: false,
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          );

                //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
              }));
    }
  }
}
