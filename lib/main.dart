import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:rjd_app/Screens/AboutScreen.dart';

import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/LoginScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/admin/Users.dart';
import 'package:rjd_app/Screens/test.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';
import 'package:rjd_app/Screens/widgets/false.dart';
import 'package:rjd_app/Screens/widgets/true.dart';
import 'package:nfc_manager/nfc_manager.dart';

late final ValueNotifier<String> user_id;
late final ValueNotifier<String> name;
late final ValueNotifier<String> section;
late final ValueNotifier<String> floor;
late final ValueNotifier<String> admin1;
late final ValueNotifier<String> worker;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  user_id = ValueNotifier(localStorage.getItem('user_id') ?? '0');
  name = ValueNotifier(localStorage.getItem('name') ?? '0');
  section = ValueNotifier(localStorage.getItem('section') ?? '0');
  floor = ValueNotifier(localStorage.getItem('floor') ?? '0');
  admin1 = ValueNotifier(localStorage.getItem('admin1') ?? '0');
  worker = ValueNotifier(localStorage.getItem('worker') ?? '0');

  user_id.addListener(() {
    localStorage.setItem('user_id', user_id.value.toString());
    print(user_id.value);
  });
  name.addListener(() {
    localStorage.setItem('name', name.value.toString());
    print(name.value);
  });

  section.addListener(() {
    localStorage.setItem('section', section.value.toString());
    print(section.value);
  });

  floor.addListener(() {
    localStorage.setItem('floor', floor.value.toString());
    print(floor.value);
  });
  admin1.addListener(() {
    localStorage.setItem('admin1', admin1.value.toString());
    print(admin1.value);
  });
  worker.addListener(() {
    localStorage.setItem('worker', worker.value.toString());
    print(worker.value);
  });

  print(user_id.value);

  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Future<void> updatelocal() async {
    final response = await http
        .post(Uri.parse("http://192.168.1.169:8000/user/${user_id.value}"));

    if (response.statusCode == 200) {
      final result =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      name.value = result['username'];
      section.value = result['section'];
      floor.value = result['floor'];
      admin1.value = result['admin'];
      worker.value = result['worker'];
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 80,
                height: MediaQuery.of(context).size.width - 40,
                child: False(
                    text: "حدث خطأ ما \nالرجاء التواصل مع الكادر التقني")),
          ],
        ),
      );
      Future.delayed(const Duration(seconds: 3)).then((val) {
        exit(0);
      });
    }
  }

  decideScreen() {
    if (user_id.value == '0') {
      return Starter();
    } else {
      updatelocal().then(
        (value) {
          print(admin1.value);
          if (admin1.value == 'true') {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => Adminhomescreen()));
          } else {
            return Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homescreen()));
          }
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: MyDrawer(),
          body: decideScreen(),
        ));
  }
}

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    NfcManager.instance.isAvailable().then((value) {
      print('NFC is available: $value');
    });
  }

  Future<void> _startNFC() async {
    print("kmr");
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      NdefMessage? message1 = await ndef!.read();
      NdefRecord record1 = message1.records[0];
      print(utf8.decode(record1.payload));
      result.value = tag.data;
      if (record1.payload.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width - 80,
                  height: MediaQuery.of(context).size.width - 40,
                  child: True(text: "تم التقاط البطاقة")),
            ],
          ),
        );
      }

      NfcManager.instance.stopSession();

      //print(result.value);
      print("kmr ------------------------");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/bir.jpg',
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x80000000),
                        offset: Offset(4, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 172,
                    height: 172,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Rj-Data x Al-Bir Hospital \n Reports App',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Janna LT',
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              decoration: ShapeDecoration(
                  color: Colors.black26,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              padding: EdgeInsets.all(10),
              child: Text(
                textAlign: TextAlign.center,
                'version: 1.0.5',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7599999904632568),
                  fontSize: 16,
                  fontFamily: 'Janna LT',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 174,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 52,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.00, -0.04),
                  end: Alignment(1, 0.04),
                  colors: [Color(0xFF2B3185), Color.fromARGB(255, 43, 49, 132)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'تسجيل/إنشاء',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
