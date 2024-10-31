import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/User.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:http/http.dart' as http;
import 'package:rjd_app/main.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

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
  }

  @override
  Widget build(BuildContext context) {
    // Use a fixed 32-character key for 256-bit AES (must be exactly 32 characters long)
    final key = encrypt.Key.fromUtf8('#1bir.admin.hash.bir.admin.hash#');

    final iv = encrypt.IV.fromUtf8('#1bir.admin.app#');

    String decryptPassword(String encryptedPassword) {
      final encrypter = encrypt.Encrypter(encrypt.AES(key,
          mode: encrypt.AESMode.cbc)); // CBC mode with default PKCS7 padding
      final decrypted = encrypter.decrypt64(encryptedPassword, iv: iv);
      return decrypted;
    }

    return admin1.value == 'true'
        ? PopScope(
            canPop: false,
            child: Scaffold(
              drawer: const MyDrawer(),
              appBar: AppBar(
                toolbarHeight: 50.0,
                title: const Text(
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
                    icon: const Icon(Icons.menu),
                  );
                }),
              ),
              body: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.5),
                          child: SizedBox(
                            height: users.length * 90,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height - 180),
                              child: RefreshIndicator(
                                onRefresh: fetchUsers,
                                color: Colors.blueAccent,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 6,
                                  ),
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    final user = users[index];
                                    Future Update_worker(
                                        int status, String worker) async {
                                      if (name.value == user['username']) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40,
                                                child: const False(
                                                    text:
                                                        "لا يمكن تعديل بيانات الحساب الحالي"),
                                              ),
                                            ],
                                          ),
                                        );
                                        fetchUsers();
                                      } else {
                                        if (worker == "false") {
                                          final updatedUser = users[status];

                                          final realIndex = updatedUser['id'];
                                          final req = await http.put(Uri.parse(
                                              "http://172.20.121.203:8000/worker/$realIndex"));

                                          if (req.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text: "حدث خطأ ما"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          final updatedUser = users[status];
                                          print("asas");
                                          final realIndex = updatedUser['id'];
                                          final req = await http.put(Uri.parse(
                                              "http://172.20.121.203:8000/not_worker/$realIndex"));
                                          final req2 = await http.put(Uri.parse(
                                              "http://172.20.121.203:8000/not_admin/$realIndex"));

                                          if (req.statusCode == 200 &&
                                              req2.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
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
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text: "حدث خطأ ما"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    }

                                    Future Update(
                                        int status, String admin) async {
                                      if (name.value == user['username']) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40,
                                                child: const False(
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
                                          final updatedUser = users[status];
                                          print("asas");
                                          final realIndex = updatedUser['id'];
                                          final req = await http.put(Uri.parse(
                                              "http://172.20.121.203:8000/admin/$realIndex"));

                                          if (req.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text: "حدث خطأ ما"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          final updatedUser = users[status];

                                          final realIndex = updatedUser['id'];
                                          final req = await http.put(Uri.parse(
                                              "http://172.20.121.203:8000/not_admin/$realIndex"));
                                          final req2 = await http.put(Uri.parse(
                                              "http://172.20.121.203:8000/not_worker/$realIndex"));

                                          if (req.statusCode == 200 &&
                                              req2.statusCode == 200) {
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Users()));
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text:
                                                            "تم تحديث البيانات"),
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
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const False(
                                                        text: "حدث خطأ ما"),
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
                                          "http://172.20.121.203:8000/user/${user_id.value}"));

                                      if (response.statusCode == 200) {
                                        final result = jsonDecode(
                                                utf8.decode(response.bodyBytes))
                                            as Map<String, dynamic>;
                                        print(result['username']);
                                        print(user['username']);
                                        if (result['username'] ==
                                            user['username']) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      80,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      40,
                                                  child: const False(
                                                      text:
                                                          "لا يمكن حذف بيانات الحساب الحالي"),
                                                ),
                                              ],
                                            ),
                                          );
                                          fetchUsers();
                                        } else {
                                          final updatedReport = users[status];
                                          print("asas");
                                          final realIndex = updatedReport['id'];
                                          final req = await http.delete(Uri.parse(
                                              "http://172.20.121.203:8000/del_user/$realIndex"));

                                          if (req.statusCode == 200) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            40,
                                                    child: const True(
                                                        text: "تم حذف الحساب"),
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
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              80,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              40,
                                                          child: const False(
                                                              text:
                                                                  "حدث خطأ ما"),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                          print('else');
                                        }
                                      }
                                    }

                                    return Container(
                                        height: 70,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: user['admin'] == 'true'
                                                ? const Color(0xFF2B3185)
                                                : Colors.teal,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                user['username'] == name.value
                                                    ? Border.all(
                                                        width: 2,
                                                        color: Colors.white,
                                                      )
                                                    : Border.all(width: 0)),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: User(
                                                        onTap3: () {
                                                          Update_worker(
                                                              index,
                                                              user['worker']
                                                                  .toString());
                                                        },
                                                        User_data: user,
                                                        pass: decryptPassword(
                                                          user['password'],
                                                        ),
                                                        inedx: index + 1,
                                                        name12:
                                                            user['username'],
                                                        onTap1: () {
                                                          Delete(index);
                                                        },
                                                        onTap2: () {
                                                          Update(
                                                            index,
                                                            user['admin']
                                                                .toString(),
                                                          );
                                                        },
                                                        admin_user:
                                                            user['admin']
                                                                .toString(),
                                                        floor: user['floor'],
                                                        desc: user['floor'],
                                                        type: user['section'],
                                                        section:
                                                            user['section']),
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          user['username'],
                                                          style: const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      229,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontFamily:
                                                                  'font1',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Text(
                                                          user['section'],
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .white54,
                                                              fontFamily:
                                                                  'font1',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: ShapeDecoration(
                                                    color: Colors.black12,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: Icon(Icons.person,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )); //AdminCard(name: name, onTap1: onTap1, onTap2: onTap2, section: section, type: type, desc: desc, floor: floor, done: done, admin: admin)
                                  },
                                ),
                              ),
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
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B3185),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const Text(
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
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const Text(
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
                                        margin: const EdgeInsets.all(10),
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2B3185),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 2.0, color: Colors.white),
                                        ),
                                      ),
                                      const Text(
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
              ),
            ),
          )
        : Scaffold(
            drawer: const MyDrawer(),
            appBar: AppBar(
              toolbarHeight: 50.0,
              title: const Text(
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
                    icon: const Icon(Icons.menu),
                  );
                },
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  height: MediaQuery.of(context).size.width - 40,
                  child: const False(text: "حدث خطأ ما"),
                ),
              ],
            ),
          );
  }

  Future<void> fetchUsers() async {
    try {
      final url = Uri.parse("http://172.20.121.203:8000/users");
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
