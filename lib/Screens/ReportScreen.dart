import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/widgets/Drawer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

TextEditingController place_controller = TextEditingController(text: '');
TextEditingController kind_controller = TextEditingController(text: '');
TextEditingController desc_controller = TextEditingController(text: '');

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 46,
              ),
              Text(
                'الابلاغ عن عطل',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text(
                      'موقع العطل',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.800000011920929),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width - 100,
                    height: 49,
                    decoration: ShapeDecoration(
                      color: Color(0xFF717AA4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 23,
                          offset: Offset(0, 12),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.name,
                      controller: place_controller,
                      decoration: InputDecoration(
                        hintText: 'ما بعرف شو حط هون',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(105, 0, 0, 0)
                              .withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text(
                      'نوع العطل',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.800000011920929),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width - 100,
                    height: 49,
                    decoration: ShapeDecoration(
                      color: Color(0xFF717AA4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 23,
                          offset: Offset(0, 12),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.name,
                      controller: place_controller,
                      decoration: InputDecoration(
                        hintText: 'ما بعرف شو حط هون',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(105, 0, 0, 0)
                              .withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text(
                      'وصف العطل',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.800000011920929),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width - 100,
                    height: 49,
                    decoration: ShapeDecoration(
                      color: Color(0xFF717AA4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 23,
                          offset: Offset(0, 12),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6499999761581421),
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.name,
                      controller: place_controller,
                      decoration: InputDecoration(
                        hintText: 'ما بعرف شو حط هون',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(105, 0, 0, 0)
                              .withOpacity(0.6499999761581421),
                          fontSize: 16,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: width - 160,
                height: 64,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.00, -0.07),
                    end: Alignment(1, 0.07),
                    colors: [
                      Color(0xFF00D1FF),
                      Color(0xFF5EE2FF),
                      Color(0xA557E0FF)
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 17,
                      offset: Offset(0, 20),
                      spreadRadius: -4,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'إرسال',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Janna LT',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
