import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/widgets/AdminCard.dart';
import 'package:rjd_app/main.dart';

class User extends StatelessWidget {
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
      required this.admin_user});

  @override
  final String name12;
  final int inedx;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final String floor;
  final String desc;
  final String type;
  final String section;
  final String admin_user;
  Widget build(BuildContext context) {
    print(name.value);
    return MaterialApp(
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
            inedx.toString() + " الحساب رقم",
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
              name: name12,
              onTap1: onTap1,
              onTap2: onTap2,
              section: admin_user == "true" ? "حساب أدمن" : "مستخدم عادي",
              type: ("${section} في ") + "\n" + ("${floor} في الطابق "),
              desc: desc,
              floor: int.parse(floor),
              done: true,
              admin: true,
              user: true,
            ),
            SizedBox(
              height: 80,
            ),
            name12 != name.value
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(right: 10),
                          decoration: ShapeDecoration(
                              color: admin_user == 'true'
                                  ? Colors.blueAccent
                                  : Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: Icon(
                            Icons.person,
                            color: admin_user == 'true'
                                ? Colors.white
                                : Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: onTap2,
                          child: Text(
                            admin_user == 'true'
                                ? "التحويل الى مستخدم"
                                : "التحويل الى ادمن",
                            style: TextStyle(
                                fontFamily: 'font1',
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: EdgeInsets.all(20)),
                        )
                      ],
                    ),
                  )
                : Text(
                    "لا يمكن تعديل بيانات الحساب الحالي",
                    style: TextStyle(
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
            SizedBox(
              height: 30,
            ),
            name12 != name.value
                ? Container(
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
                          onPressed: onTap1,
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
                  )
                : Container()
          ],
        ))),
      ),
    );
  }
}
