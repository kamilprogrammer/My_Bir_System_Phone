import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/admin/Users.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;

class User extends StatefulWidget {
  const User(
      {super.key,
      required this.name12,
      required this.onTap1,
      required this.onTap2,
      required this.floor,
      required this.desc,
      required this.type,
      required this.section,
      required this.inedx,
      required this.admin_user,
      required this.pass,
      required this.User_data,
      required this.onTap3});

  @override
  final String name12;
  final int inedx;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final VoidCallback onTap3;
  final String floor;
  final String desc;
  final String type;
  final String section;
  final String admin_user;
  final String pass;
  final User_data;
  @override
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool showPassword = true;

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name_controller =
        TextEditingController(text: widget.name12);
    TextEditingController section_controller =
        TextEditingController(text: widget.section);
    TextEditingController floor_controller =
        TextEditingController(text: widget.floor);
    TextEditingController pass_controller =
        TextEditingController(text: widget.pass);

    print(name.value);

    Future<void> update_user() async {
      if (name_controller.text.isNotEmpty &&
          floor_controller.text.isNotEmpty &&
          section_controller.text.isNotEmpty &&
          pass_controller.text.isNotEmpty) {
        final password = pass_controller.text;
        final key = encrypt.Key.fromUtf8('#1bir.admin.hash.bir.admin.hash#');

        final iv = encrypt.IV.fromUtf8('#1bir.admin.app#');

        // Function to encrypt the password
        String encryptPassword(String password) {
          final encrypter = encrypt.Encrypter(encrypt.AES(key,
              mode:
                  encrypt.AESMode.cbc)); // CBC mode with default PKCS7 padding
          final encrypted = encrypter.encrypt(password, iv: iv);
          return encrypted.base64;
        }

        final encryptedPassword = encryptPassword(password);
        final response = await http.put(
          Uri.parse(
              "http://192.168.1.169:8000/update_user/${widget.User_data['id']}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Access-Control-Allow-Origin": "*",
            'Accept': '*/*'
          },
          body: jsonEncode(
            <String, String>{
              'username': name_controller.text,
              'floor': floor_controller.text,
              'section': section_controller.text,
              'password': encryptedPassword.toString(),
              'worker': widget.User_data['worker'],
              'admin': widget.User_data['admin'],
            },
          ),
        );
        if (response.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Users()));
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
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: False(text: "الرجاء ملء جميع الحقول"),
              ),
            ],
          ),
        );
      }
    }

    return new PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              widget.inedx.toString() + " الحساب رقم",
              style: TextStyle(
                  fontFamily: 'font1',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            centerTitle: true,
          ),
          body: Container(
              child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminCard(
                share: () {},
                name: widget.name12,
                onTap1: widget.onTap1,
                onTap2: widget.onTap2,
                section: widget.admin_user == "true"
                    ? "حساب أدمن"
                    : widget.User_data['worker'] == 'false'
                        ? "مستخدم عادي"
                        : 'موظف',
                type: ("${widget.section} في ") +
                    "\n" +
                    ("${widget.floor} في الطابق "),
                desc: widget.desc,
                floor: widget.inedx,
                done: true,
                admin: true,
                user: true,
              ),
              SizedBox(
                height: 80,
              ),
              widget.name12 != name.value
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 12,
                                    offset: Offset(-10, 14),
                                    spreadRadius: 4,
                                  )
                                ],
                              ),
                              width: MediaQuery.of(context).size.width - 60,
                              height: 46,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.name,
                                controller: name_controller,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.person_outline_outlined,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'اسم المستخدم',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 10)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 12,
                                    offset: Offset(-10, 14),
                                    spreadRadius: 4,
                                  )
                                ],
                              ),
                              width: MediaQuery.of(context).size.width - 60,
                              height: 46,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.name,
                                controller: floor_controller,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.format_list_numbered_rounded,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'الطابق',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 10)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 12,
                                    offset: Offset(-10, 14),
                                    spreadRadius: 4,
                                  )
                                ],
                              ),
                              width: MediaQuery.of(context).size.width - 60,
                              height: 46,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.streetAddress,
                                controller: section_controller,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.border_inner_rounded,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'القسم',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                      fontSize: 14,
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 10)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 12,
                                    offset: Offset(-10, 14),
                                    spreadRadius: 4,
                                  )
                                ],
                              ),
                              width: MediaQuery.of(context).size.width - 60,
                              height: 46,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.6499999761581421),
                                  fontSize: 14,
                                  fontFamily: 'font1',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                                obscureText: showPassword,
                                controller: pass_controller,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      size: 20.0,
                                    ),
                                    suffixIconColor: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    hintText: 'كلمة السر',
                                    hintStyle: TextStyle(
                                      color: Colors.black
                                          .withOpacity(0.6499999761581421),
                                      fontSize: 14,
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 10)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextButton(
                          onPressed: toggleShowPassword,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 220,
                            height: 55,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2.0, color: Color(0xFF2B3185)),
                                borderRadius: BorderRadius.circular(19),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF2B3185),
                                  blurRadius: 14,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: const Icon(
                                  Icons.lock,
                                  color: Color(0xFF2B3185),
                                  size: 25.0,
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: update_user,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 160,
                            height: 55,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2.0, color: Color(0xFF2B3185)),
                                borderRadius: BorderRadius.circular(19),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0xFF2B3185),
                                  blurRadius: 14,
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: const Text(
                                    'تعديل البيانات',
                                    style: TextStyle(
                                      color: Color(0xFF2B3185),
                                      fontSize: 16,
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        widget.admin_user == "true" &&
                                widget.User_data['worker'] == 'true'
                            ? Container()
                            : Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: ShapeDecoration(
                                          color: widget.admin_user == 'true'
                                              ? Color(0xFF2B3185)
                                              : Color(0xFF2B3185),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      child: Icon(
                                        Icons.person,
                                        color: widget.admin_user == 'true'
                                            ? Colors.white
                                            : Colors.white,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: widget.onTap3,
                                      child: Text(
                                        widget.User_data['worker'] == 'false'
                                            ? "التحويل الى موظف"
                                            : "التحويل الى مستخدم",
                                        style: TextStyle(
                                            fontFamily: 'font1',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF2B3185),
                                          padding: EdgeInsets.all(20)),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(right: 10),
                                decoration: ShapeDecoration(
                                    color: widget.admin_user == 'true'
                                        ? Color(0xFF2B3185)
                                        : Color(0xFF2B3185),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40))),
                                child: Icon(
                                  Icons.person,
                                  color: widget.admin_user == 'true'
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onTap2,
                                child: Text(
                                  widget.admin_user == 'true'
                                      ? "التحويل الى مستخدم"
                                      : "التحويل الى ادمن",
                                  style: TextStyle(
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF2B3185),
                                    padding: EdgeInsets.all(20)),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "لا يمكن تعديل بيانات الحساب الحالي",
                      style: TextStyle(
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
              SizedBox(
                height: 20,
              ),
              widget.name12 != name.value
                  ? Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(right: 10),
                                decoration: ShapeDecoration(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40))),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              TextButton(
                                onPressed: widget.onTap1,
                                child: Text(
                                  "حذف الحساب نهائياً",
                                  style: TextStyle(
                                      fontFamily: 'font1',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.all(20)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    )
                  : Container()
            ],
          ))),
        ),
      ),
    );
  }
}
