import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/AboutScreen.dart';
import 'package:rjd_app/Screens/HomeScreen.dart';
import 'package:rjd_app/Screens/ReportScreen.dart';
import 'package:rjd_app/Screens/admin/AdminHomeScreen.dart';
import 'package:rjd_app/Screens/admin/Users.dart';
import 'package:rjd_app/main.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
        title: Text(
          "قائمة الانتقال",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'font1', fontSize: 18.0),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: const Color.fromARGB(0, 255, 255, 255),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Scaffold.of(context).closeDrawer();
              },
              icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Color(0xFF2B3185)),
                        borderRadius: BorderRadius.circular(100)),
                    width: 160,
                    height: 160,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            const Image(image: AssetImage("assets/bir.jpg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFF2B3185)),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(name.value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'font1',
                      fontSize: 18.0)),
              Text(section.value, style: TextStyle(fontFamily: 'font1')),
              const SizedBox(height: 20),

              ListTile(
                //isThreeLine: true,

                leading: Icon(Icons.home),
                subtitle: Text(
                  "آخر البلاغات",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'font1',
                      color: Colors.black87),
                ),
                title: Text(
                  'الصفحة الرئيسية',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'font1',
                  ),
                ),
                onTap: () {
                  if (admin1.value == 'true') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Adminhomescreen()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homescreen()));
                  }

                  // Handle tap
                },
              ),
              admin1.value == 'false'
                  ? ListTile(
                      leading: Icon(Icons.add_box_rounded),
                      title: Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(
                          'إضافة بلاغ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'font1',
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportScreen()));
                        // Handle tap
                      },
                    )
                  : ListTile(
                      leading: Icon(Icons.person),
                      title: Container(
                        margin: EdgeInsets.only(bottom: 6),
                        child: Text(
                          'جميع الحسابات',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'font1',
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Users()));
                        // Handle tap
                      },
                    ),
              ListTile(
                leading: Icon(Icons.info),
                title: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(
                    'عن التطبيق',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'font1',
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutScreen()));
                  // Handle tap
                },
              ),
              ListTile(
                textColor: Colors.red,
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'font1',
                    ),
                  ),
                ),
                onTap: () {
                  user_id.value = '0';
                  name.value = '0';
                  section.value = '0';
                  floor.value = '0';
                  admin1.value = '0';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Starter()));
                  // Handle tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
