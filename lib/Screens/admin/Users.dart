import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/User.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/main.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<dynamic> users = [];
  @override
  @override
  void initState() {
    super.initState();
    fetchUsers();
    print("kmr");
  }

  Widget build(BuildContext context) {
    return admin1.value == 'true'
        ? Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              toolbarHeight: 50.0,
              title: Text(
                "جميع الحسابات",
                style: TextStyle(
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              centerTitle: true,
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                );
              }),
            ),
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
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
                    Container(
                      height: users.length * 70,
                      child: RefreshIndicator(
                        onRefresh: fetchUsers,
                        color: Colors.blueAccent,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 6,
                          ),
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            Future Update(int status, String admin) async {
                              if (name.value == user['username']) {
                                showDialog(
                                  context: context,
                                  builder: (context) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        height:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: False(
                                            text:
                                                "لا يمكن تعديل بيانات الحساب الحالي"),
                                      ),
                                    ],
                                  ),
                                );
                                fetchUsers();
                              } else {
                                if (admin == "false") {
                                  print('false');
                                  final updated_user = users[status];
                                  print("asas");
                                  final real_index = updated_user['id'];
                                  final req = await http.put(Uri.parse(
                                      "http://192.168.1.155:8000/admin/${real_index}"));

                                  if (req.statusCode == 200) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child:
                                                True(text: "تم تحديث البيانات"),
                                          ),
                                        ],
                                      ),
                                    );
                                    fetchUsers();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      80,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      40,
                                                  child:
                                                      False(text: "حدث خطأ ما"),
                                                ),
                                              ],
                                            ));
                                  }
                                } else {
                                  print('true');
                                  final updated_user = users[status];
                                  print("asas");
                                  final real_index = updated_user['id'];
                                  final req = await http.put(Uri.parse(
                                      "http://192.168.1.155:8000/not_admin/${real_index}"));

                                  if (req.statusCode == 200) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child:
                                                True(text: "تم تحديث البيانات"),
                                          ),
                                        ],
                                      ),
                                    );
                                    fetchUsers();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child: False(text: "حدث خطأ ما"),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              }
                            }

                            Delete(int status) async {
                              final response = await http.post(Uri.parse(
                                  "http://192.168.1.155:8000/user/${user_id.value}"));

                              if (response.statusCode == 200) {
                                final result =
                                    jsonDecode(utf8.decode(response.bodyBytes))
                                        as Map<String, dynamic>;
                                print(result['username']);
                                print(user['username']);
                                if (result['username'] == user['username']) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: False(
                                              text:
                                                  "لا يمكن حذف بيانات الحساب الحالي"),
                                        ),
                                      ],
                                    ),
                                  );
                                  fetchUsers();
                                } else {
                                  final updated_report = users[status];
                                  print("asas");
                                  final real_index = updated_report['id'];
                                  final req = await http.delete(Uri.parse(
                                      "http://192.168.1.155:8000/del_user/${real_index}"));

                                  if (req.statusCode == 200) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child: True(text: "تم حذف الحساب"),
                                          ),
                                        ],
                                      ),
                                    );
                                    fetchUsers();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      80,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      40,
                                                  child:
                                                      False(text: "حدث خطأ ما"),
                                                ),
                                              ],
                                            ));
                                  }
                                  print('else');
                                }
                              }
                            }

                            return Dismissible(
                              background: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: ShapeDecoration(
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person_pin_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                            user['admin'] == 'true'
                                                ? Text(
                                                    "مستخدم",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'font1',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : Text(
                                                    "أدمن",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'font1',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: ShapeDecoration(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              Text(
                                                "حذف",
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
                                  ),
                                ],
                              ),
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {
                                  Delete(index);
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  Update(index, user['admin'].toString());
                                }
                              },
                              child: Container(
                                  height: 70,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: user['admin'] == 'true'
                                          ? Color(0xFF2B3185)
                                          : Colors.teal,
                                      borderRadius: BorderRadius.circular(20),
                                      border: user['username'] == name.value
                                          ? Border.all(
                                              width: 2,
                                              color: Colors.white,
                                            )
                                          : Border.all(width: 0)),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => User(
                                              inedx: index + 1,
                                              name12: user['username'],
                                              onTap1: () {
                                                Delete(index);
                                              },
                                              onTap2: () {
                                                Update(
                                                  index,
                                                  user['admin'].toString(),
                                                );
                                              },
                                              admin_user:
                                                  user['admin'].toString(),
                                              floor: (index + 1).toString(),
                                              desc: user['floor'],
                                              type: user['section'],
                                              section: user['section']),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    user['username'],
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            229, 255, 255, 255),
                                                        fontFamily: 'font1',
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Text(
                                                    user['section'],
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontFamily: 'font1',
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: ShapeDecoration(
                                              color: Colors.black12,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: Icon(
                                            Icons.person,
                                            color:
                                                user['username'] == name.value
                                                    ? Colors.white
                                                    : user['admin'] == 'true'
                                                        ? Colors.white
                                                        : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                            //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
                          },
                        ),
                      ),
                    ),

                    ///ListView.builder(itemCount: ,),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2B3185),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Text(
                                    "=> مستخدم أدمن",
                                    style: TextStyle(
                                        fontFamily: 'font1',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Text(
                                    "=> مستخدم عادي",
                                    style: TextStyle(
                                        fontFamily: 'font1',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 40,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2B3185),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2.0, color: Colors.white),
                                    ),
                                  ),
                                  Text(
                                    "=>  المستخدم الحالي",
                                    style: TextStyle(
                                        fontFamily: 'font1',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              toolbarHeight: 50.0,
              title: Text(
                "جميع الحسابات",
                style: TextStyle(
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              centerTitle: true,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  );
                },
              ),
            ),
            body: Column(
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

  Future<void> fetchUsers() async {
    try {
      final url = Uri.parse("http://192.168.1.155:8000/users");
      final response = await http.get(url);
      final body = response.bodyBytes;
      final json = jsonDecode(utf8.decode(body));
      print(name.value);
      setState(() {
        users = json;
      });

      print(users);
    } catch (e) {
      print(e);
    }
  }
}
