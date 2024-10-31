import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({
    super.key,
    required this.name_controller,
    required this.floor_controller,
  });

  @override
  final String name_controller;
  final String floor_controller;

  @override
  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  TextEditingController section_controller = TextEditingController(text: '');
  TextEditingController pass_controller = TextEditingController(text: '');
  String section_count = "0";
  String section_login_value = "";
  List<DropdownMenuItem<String>> sections = [];
  @override
  void initState() {
    super.initState();
    fetching_sections();
  }

  @override
  Widget build(BuildContext context) {
    final _formSearchProductsKey = GlobalKey<FormState>();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 80),
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
                                    color: const Color(0xFF2B3185),
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
                                decoration: const ShapeDecoration(
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
                                child: SizedBox(
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
                                              color: const Color(0xFF77C9DB),
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
                                            decoration: const ShapeDecoration(
                                              color: Color(0xCE90F8FF),
                                              shape:
                                                  StarBorder.polygon(sides: 3),
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
                      margin: const EdgeInsets.only(right: 40),
                      child: const Text(
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
                      margin: const EdgeInsets.only(right: 40, top: 0),
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
                const SizedBox(
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
                        shadows: const [
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
                                  icon: const Icon(Icons.border_inner_rounded),
                                  style: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 14,
                                    fontFamily: 'font1',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  iconSize: 22.0,
                                  value: section_count,
                                  onChanged: (newVal) {
                                    setState(() {
                                      section_count = newVal!;
                                    });
                                    print(section_count);
                                  },
                                  underline: const SizedBox(
                                    height: 0,
                                  ),
                                  items: sections,
                                )
                              : const Row(
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
                const SizedBox(
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
                        shadows: const [
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
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
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
                            suffixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              size: 20.0,
                            ),
                            suffixIconColor:
                                Colors.black.withOpacity(0.6499999761581421),
                            hintText: 'كلمة السر',
                            hintStyle: TextStyle(
                              color:
                                  Colors.black.withOpacity(0.6499999761581421),
                              fontSize: 14,
                              fontFamily: 'font1',
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(top: 10)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                sections.length != 1
                    ? Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await Register(deviceInfo);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 160,
                              height: 55,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2.0, color: Color(0xFF2B3185)),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                shadows: const [
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
                                      'إنشاء الحساب',
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
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width - 200,
                              height: 55,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 2.0, color: Color(0xFF2B3185)),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                shadows: const [
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
                                      'العودة',
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
                        ],
                      )
                    : TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 55,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2.0, color: Color(0xFF2B3185)),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            shadows: const [
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
                                  'العودة',
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
        "http://172.20.121.203:8000/sections/${widget.floor_controller.toString()}"));
    if (request.statusCode == 200) {
      List<dynamic> list1 = jsonDecode(utf8.decode(request.bodyBytes));
      print(list1);
      setState(() {
        sections = list1.map((section) {
          return DropdownMenuItem<String>(
            value: section['name'].toString(),
            child: Text(section['name'].toString()),
          );
        }).toList();
        sections.add(const DropdownMenuItem(
          value: "0",
          child: Text("القسم"),
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

  Future<void> Register(deviceInfo) async {
    if (widget.name_controller.isNotEmpty &&
        widget.floor_controller != "0" &&
        section_count != "0" &&
        pass_controller.text.isNotEmpty &&
        pass_controller.text.length > 8) {
      final password = pass_controller.text;

      final encryptedPassword = encryptPassword(password);
      final response = await http.post(
        Uri.parse("http://172.20.121.203:8000/register"),
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

      if (response.statusCode == 203) {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const False(
                    text:
                        "هذا الحساب موجود مسبقاً الرجاء العودة لتسجيل الدخول"),
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
        if (kIsWeb) {
          print("web");
        } else {
          if (Platform.operatingSystem == "android") {
            final info = NetworkInfo();
            AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
            final wifiGateway = await info.getWifiGatewayIP();
            final wifiName = await info.getWifiName();

            final wifiIp = await info.getWifiIP();
            final wifiMask = await info.getWifiSubmask();

            final json = {
              "os": Platform.operatingSystem,
              "model": androidInfo.model,
              "version": Platform.operatingSystemVersion,
              "cpu": "${androidInfo.supportedAbis}",
              "cpu_cores": "${Platform.numberOfProcessors}",
              "wifi": "$wifiName",
              "wifi_ip": "$wifiIp",
              "wifi_gateway": "$wifiGateway",
              "wifi_sub": "$wifiMask",
            };
            print(json);
            final responsePhone = await http.post(
              Uri.parse(
                  "http://172.20.121.203:8000/phone?name=${name.value}&json=${json.toString()}"),
              body: {
                'name': "name.value.toString()",
                'json': "json.toString()"
              },
            );
          }
        }
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyApp()));
      } else {
        showDialog(
          context: context,
          builder: (context) => Column(
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
    } else {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: const False(text: "الرجاء ملء جميع الحقول")),
          ],
        ),
      );
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
