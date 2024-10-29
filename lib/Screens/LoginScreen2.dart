import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({
    super.key,
    required this.name_controller,
    required this.floor_controller,
  });

  @override
  final String name_controller;
  final String floor_controller;

  @override
  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  TextEditingController section_controller = TextEditingController(text: '');
  TextEditingController pass_controller = TextEditingController(text: '');
  String section_count = "0";
  String section_login_value = "";
  List<DropdownMenuItem<String>> sections = [];
  void initState() {
    super.initState();
    fetching_sections();
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return new PopScope(
      canPop: false,
      child: MaterialApp(
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
                                    color: Color(0xFF2B3185),
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
                                  color: Color(0xFFD4D3F7),
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
                      margin: EdgeInsets.only(right: 40),
                      child: Text(
                        'إكمال التسجيل',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
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
                      margin: EdgeInsets.only(right: 40, top: 0),
                      child: Text(
                        'الرجاء إدخال البيانات المتبقية',
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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        color: sections.length != 1 ? Colors.white : Colors.red,
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
                      child: Row(
                        children: [
                          SizedBox(
                            width: sections.length != 1
                                ? MediaQuery.of(context).size.width - 146
                                : MediaQuery.of(context).size.width - 170,
                          ),
                          sections.length != 1
                              ? DropdownButton(
                                  icon: Icon(Icons.border_inner_rounded),
                                  style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 14,
                                    fontFamily: 'font1',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  iconSize: 22.0,
                                  value: section_count,
                                  onChanged: (new_val) {
                                    setState(() {
                                      section_count = new_val!;
                                    });
                                    print(section_count);
                                  },
                                  underline: SizedBox(
                                    height: 0,
                                  ),
                                  items: sections,
                                )
                              : Row(
                                  children: [
                                    Text(
                                      "حدث خطأ ما",
                                      style: TextStyle(
                                          fontFamily: "font1",
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      color: Colors.white,
                                      Icons.border_inner_rounded,
                                      size: 22.0,
                                    ),
                                  ],
                                )
                        ],
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
                          color: Colors.black.withOpacity(0.6499999761581421),
                          fontSize: 14,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: pass_controller,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.lock_outline_rounded,
                              size: 20.0,
                            ),
                            suffixIconColor:
                                Colors.black.withOpacity(0.6499999761581421),
                            hintText: 'كلمة السر',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.6499999761581421),
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
                sections.isNotEmpty
                    ? TextButton(
                        onPressed: () async {
                          await Login().then((onValue) async {
                            if (kIsWeb) {
                              print("web");
                            } else {
                              if (Platform.operatingSystem == "android") {
                                final info = NetworkInfo();
                                AndroidDeviceInfo androidInfo =
                                    await deviceInfo.androidInfo;
                                final wifi_gateway =
                                    await info.getWifiGatewayIP();
                                final wifi_name = await info.getWifiName();
      
                                final wifi_ip = await info.getWifiIP();
                                final wifi_mask = await info.getWifiSubmask();
      
                                final json = {
                                  "os": "${Platform.operatingSystem}",
                                  "model": "${androidInfo.model}",
                                  "version": "${Platform.operatingSystemVersion}",
                                  "cpu": "${androidInfo.supportedAbis}",
                                  "cpu_cores": "${Platform.numberOfProcessors}",
                                  "wifi": "${wifi_name}",
                                  "wifi_ip": "${wifi_ip}",
                                  "wifi_gateway": "${wifi_gateway}",
                                  "wifi_sub": "${wifi_mask}",
                                };
                                print(json);
                                final response_phone = await http.post(
                                  Uri.parse(
                                      "http://192.168.1.169:8000/phone?name=${name.value}&json=${json.toString()}"),
                                  body: {
                                    'name': "name.value.toString()",
                                    'json': "json.toString()"
                                  },
                                );
                              }
                            }
                          });
                        },
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
                                  'إنشاء/تسجيل',
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
                      )
                    : SizedBox(
                        height: 0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetching_sections() async {
    print("here");
    final request = await http.post(Uri.parse(
        "http://192.168.1.169:8000/sections/${widget.floor_controller.toString()}"));
    if (request.statusCode == 200) {
      List<dynamic> list1 = jsonDecode(utf8.decode(request.bodyBytes));
      print(list1);
      setState(() {
        sections = list1.map((section) {
          return DropdownMenuItem<String>(
            child: Text(section['name'].toString()),
            value: section['name'].toString(),
          );
        }).toList();
        sections.add(DropdownMenuItem(
          child: Text("القسم"),
          value: "0",
        ));
      });
    }
  }

  final key = encrypt.Key.fromUtf8('#1bir.admin.hash.bir.admin.hash#');

  final iv = encrypt.IV.fromUtf8('#1bir.admin.app#');

  // Function to encrypt the password
  String encryptPassword(String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key,
        mode: encrypt.AESMode.cbc)); // CBC mode with default PKCS7 padding
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  Future<void> Login() async {
    if (widget.name_controller.isNotEmpty &&
        widget.floor_controller != "0" &&
        section_count.isNotEmpty &&
        pass_controller.text.isNotEmpty) {
      final password = pass_controller.text;

      final encryptedPassword = encryptPassword(password);
      final response = await http.post(
        Uri.parse("http://192.168.1.169:8000/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*'
        },
        body: jsonEncode(
          <String, String>{
            'username': widget.name_controller,
            'floor': widget.floor_controller,
            'section': section_count,
            'password': encryptedPassword,
            'worker': "false",
            'admin': admin(),
          },
        ),
      );

      if (response.body == 203.toString()) {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: False(text: "الباسوورد غير مطابق للحساب السابق"),
              ),
            ],
          ),
        );
      } else if (response.statusCode == 201) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        user_id.value = result['id'].toString();
        name.value = widget.name_controller;

        section.value = section_controller.text;
        floor.value = widget.floor_controller;
        admin1.value = admin();
        worker.value = result['worker'];

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
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
    if (widget.name_controller == 'bir' &&
        pass_controller.text == "#bir.admin.app#") {
      return "true";
    } else {
      return "false";
    }
  }
}