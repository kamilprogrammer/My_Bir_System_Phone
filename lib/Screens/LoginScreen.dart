import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name_controller = TextEditingController(text: '');
  TextEditingController floor_controller = TextEditingController(text: '');
  TextEditingController section_controller = TextEditingController(text: '');
  TextEditingController pass_controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 80),
                      width: MediaQuery.of(context).size.width > 375
                          ? MediaQuery.of(context).size.width * 50 / 100
                          : MediaQuery.of(context).size.width * 60 / 100,
                      height: 250,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 98.05,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(-0.56),
                              child: Container(
                                width: 184,
                                height: 106,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF91B3AB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 94,
                            child: Container(
                              width: 182,
                              height: 182,
                              decoration: ShapeDecoration(
                                color: Color(0xFFA0E5D9),
                                shape: StarBorder.polygon(sides: 3),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 130.18,
                            top: 966,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(3.14),
                              child: Container(
                                width: 212.18,
                                height: 276,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: -98.05,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..translate(0.0, 0.0)
                                          ..rotateZ(2.58),
                                        child: Container(
                                          width: 184,
                                          height: 106,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF77C9DB),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -15,
                                      top: -94,
                                      child: Transform(
                                        transform: Matrix4.identity()
                                          ..translate(0.0, 0.0)
                                          ..rotateZ(3.14),
                                        child: Container(
                                          width: 182,
                                          height: 182,
                                          decoration: ShapeDecoration(
                                            color: Color(0xCE90F8FF),
                                            shape: StarBorder.polygon(sides: 3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text(
                      'إنشاء الحساب',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50, top: 5),
                    child: Text(
                      'الرجاء تسجيل الدخول قبل المتابعة',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5299999713897705),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
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
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.name,
                      controller: name_controller,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person_outline_outlined),
                        suffixIconColor:
                            Colors.black.withOpacity(0.6499999761581421),
                        hintText: 'اسم المستخدم',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 26,
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
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.name,
                      controller: floor_controller,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.format_list_numbered_rounded),
                        suffixIconColor:
                            Colors.black.withOpacity(0.6499999761581421),
                        hintText: 'الطابق',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 26,
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
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.streetAddress,
                      controller: section_controller,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.border_inner_rounded),
                        suffixIconColor:
                            Colors.black.withOpacity(0.6499999761581421),
                        hintText: 'القسم',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 26,
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
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.name,
                      controller: pass_controller,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIconColor:
                            Colors.black.withOpacity(0.6499999761581421),
                        hintText: 'كلمة السر',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: Login,
                child: Container(
                  width: width - 195,
                  height: 55,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF77C9DB)),
                      borderRadius: BorderRadius.circular(19),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 12.50,
                        offset: Offset(4, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Color(0xFF77C9DB),
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
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    if (name_controller.text.isNotEmpty &&
        floor_controller.text.isNotEmpty &&
        section_controller.text.isNotEmpty &&
        pass_controller.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse("http://192.168.1.104:8000/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'username': name_controller.text,
            'floor': floor_controller.text,
            'section': section_controller.text,
            'password': pass_controller.text,
            'admin': admin(),
          },
        ),
      );

      if (response.statusCode == 201) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        user_id.value = result['id'].toString();
        name.value = result['username'].toString();
        print(name.value);
        section.value = result['section'];
        floor.value = result['floor'];
        admin1.value = admin();
        if (admin() == 'true') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Adminhomescreen()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homescreen()));
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
                child: False(text: "حدث خطأ ما"),
              ),
            ],
          ),
        );
      }
    }
  }

  admin() {
    if (name_controller.text == 'bir' &&
        pass_controller.text == "#bir.admin.app#") {
      return "true";
    } else {
      return "false";
    }
  }
}
