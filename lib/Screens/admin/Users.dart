import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.5),
                        child: Container(
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
                                                      "لا يمكن تعديل بيانات الحساب الحالي"),
                                            ),
                                          ],
                                        ),
                                      );
                                      fetchUsers();
                                    } else {
                                      if (worker == "false") {
                                        final updated_user = users[status];

                                        final real_index = updated_user['id'];
                                        final req = await http.put(Uri.parse(
                                            "http://192.168.1.169:8000/worker/${real_index}"));

                                        if (req.statusCode == 200) {
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Users()));
                                          });
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
                                                  child: True(
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
                                            ),
                                          );
                                        }
                                      } else {
                                        final updated_user = users[status];
                                        print("asas");
                                        final real_index = updated_user['id'];
                                        final req = await http.put(Uri.parse(
                                            "http://192.168.1.169:8000/not_worker/${real_index}"));
                                        final req2 = await http.put(Uri.parse(
                                            "http://192.168.1.169:8000/not_admin/${real_index}"));

                                        if (req.statusCode == 200 &&
                                            req2.statusCode == 200) {
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Users()));
                                          });
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
                                                  child: True(
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
                                            "http://192.168.1.169:8000/admin/${real_index}"));

                                        if (req.statusCode == 200) {
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Users()));
                                          });
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
                                                  child: True(
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
                                            ),
                                          );
                                        }
                                      } else {
                                        print('true');
                                        final updated_user = users[status];
                                        print("asas");
                                        final real_index = updated_user['id'];
                                        final req = await http.put(Uri.parse(
                                            "http://192.168.1.169:8000/not_admin/${real_index}"));
                                        final req2 = await http.put(Uri.parse(
                                            "http://192.168.1.169:8000/not_worker/${real_index}"));

                                        if (req.statusCode == 200 &&
                                            req2.statusCode == 200) {
                                          Future.delayed(Duration(seconds: 2),
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Users()));
                                          });
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
                                                  child: True(
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
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  }

                                  Delete(int status) async {
                                    final response = await http.post(Uri.parse(
                                        "http://192.168.1.169:8000/user/${user_id.value}"));

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
                                            "http://192.168.1.169:8000/del_user/${real_index}"));

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
                                                  child: True(
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
                                                      Container(
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
                                                        child: False(
                                                            text: "حدث خطأ ما"),
                                                      ),
                                                    ],
                                                  ));
                                        }
                                        print('else');
                                      }
                                    }
                                  }

                                  Future<bool> showAlertDialog(
                                      BuildContext context,
                                      String message) async {
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
                                    );
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
                                                      BorderRadius.circular(
                                                          20))),
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
                                                      BorderRadius.circular(
                                                          20))),
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
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        showAlertDialog(context,
                                                "الضغط على نعم سيقوم بحذف البلاغ")
                                            .then((bool1) {
                                          if (bool1 == true) {
                                            Delete(index);
                                          } else {
                                            fetchUsers();
                                          }
                                        });
                                      } else if (direction ==
                                          DismissDirection.startToEnd) {
                                        showAlertDialog(
                                                context,
                                                user['admin'] == 'true'
                                                    ? "الضغط على نعم سيقوم بتحويل الحساب الى حساب مستخدم "
                                                    : "الضغط على نعم سيقوم بتحويل الحساب الى حساب ادمن ")
                                            .then((bool2) {
                                          if (bool2 == true) {
                                            Update(index,
                                                user['admin'].toString());
                                          } else {
                                            fetchUsers();
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                        height: 70,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: user['admin'] == 'true'
                                                ? Color(0xFF2B3185)
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
                                              MaterialPageRoute(
                                                builder: (context) => User(
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
                                                    name12: user['username'],
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
                                                    admin_user: user['admin']
                                                        .toString(),
                                                    floor: user['floor'],
                                                    desc: user['floor'],
                                                    type: user['section'],
                                                    section: user['section']),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          user['username'],
                                                          style: TextStyle(
                                                              color: const Color
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
                                                          style: TextStyle(
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
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: ShapeDecoration(
                                                    color: Colors.black12,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: Icon(
                                                  Icons.person,
                                                  color: user['username'] ==
                                                          name.value
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
      final url = Uri.parse("http://192.168.1.169:8000/users");
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
