import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';

import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/LoginScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/test.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:rjd_app/Screens/widgets/true.dart';

late final ValueNotifier<String> user_id;
late final ValueNotifier<String> name;
late final ValueNotifier<String> section;
late final ValueNotifier<String> floor;
late final ValueNotifier<String> admin1;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  user_id = ValueNotifier(localStorage.getItem('user_id') ?? '0');
  name = ValueNotifier(localStorage.getItem('name') ?? '0');
  section = ValueNotifier(localStorage.getItem('section') ?? '0');
  floor = ValueNotifier(localStorage.getItem('floor') ?? '0');
  admin1 = ValueNotifier(localStorage.getItem('admin1') ?? '0');
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

  print(user_id.value);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

updatelocal() async {
  final response = await http
      .post(Uri.parse("http://192.168.1.104:8000/user/${user_id.value}"));

  final result = jsonDecode(response.body) as Map<String, dynamic>;
  name.value = result['username'];
  section.value = result['section'];
  floor.value = result['floor'];
  admin1.value = result['admin'];
}

decideScreen() {
  updatelocal();
  print(admin1.value);
  if (admin1.value == 'true') {
    return Adminhomescreen();
  } else if (user_id.value != '0' &&
      name.value != '0' &&
      section.value != '0' &&
      floor.value != '0') {
    return Homescreen();
  } else {
    return LoginScreen();
  }
}

class Starter extends StatefulWidget {
  const Starter({super.key});

  @override
  State<Starter> createState() => _StarterState();
}

class _StarterState extends State<Starter> {
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
                      image: NetworkImage(
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
              height: 28,
            ),
            Text(
              'Al-bir complaints application',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF5B4F4F),
                fontSize: 16,
                fontFamily: 'font1',
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              child: const Text(
                'version: 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5B5050),
                  fontSize: 16,
                  fontFamily: 'font1',
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
                  colors: [Color(0xFFA6FAFF), Color(0xFF1CE0EC)],
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
                  'التالي',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
