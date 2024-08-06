import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  AdminCard({
    Key? key,
    required this.name,
    required this.onTap1,
    required this.onTap2,
    required this.section,
    required this.type,
    required this.desc,
    required this.floor,
    required this.done,
    required this.admin,
  }) : super(key: key);
  final String name; // Username
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final String section; // String for section
  final String type; // String for type
  final String desc; // String for description
  final int floor;
  final bool done;
  final bool admin; // Floor number

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width - 44,
          height: 362,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 21,
                offset: Offset(0, 17),
                spreadRadius: 6,
              )
            ],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 60,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.00, -0.04),
                        end: Alignment(1, 0.04),
                        colors: [Color(0xFF1CE0EC), Color(0xFF00C4D0)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 98,
                        height: 98,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                          color: done == true
                              ? Color(0xFF65B741)
                              : Color(0xFFC21010),
                          shadows: [
                            BoxShadow(
                              color: done == true
                                  ? Color(0xFF65B741)
                                  : Color(0xFFC21010),
                              blurRadius: 40,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                    floor.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 42,
                                      fontFamily: 'font2',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                name.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                section.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6000000238418579),
                  fontSize: 16,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: width - 74,
                height: 40,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: width - 74,
                height: 68,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      desc.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 22.0,
              ),
              Row(
                children: [
                  Container(
                    width: width - 44,
                    height: 54,
                    child: admin == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 54,
                                width: ((width - 44) / 2) - 1,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFC21010),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(19),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: onTap2,
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.only(
                                              left: 40,
                                              right: 40,
                                              top: 10,
                                              bottom: 10)),
                                      child: Text(
                                        'ليس بعد',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'font1',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 54,
                                width: (width - 44) / 2,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF65B741),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(19),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: onTap1,
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.only(
                                              left: 40,
                                              right: 40,
                                              top: 10,
                                              bottom: 10)),
                                      child: Text(
                                        'تم الحل',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'font1',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : done == false
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 54,
                                    width: width - 44,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFC21010),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(19),
                                          bottomRight: Radius.circular(19),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: onTap2,
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.only(
                                                  left: 100,
                                                  right: 100,
                                                  top: 10,
                                                  bottom: 10)),
                                          child: Text(
                                            'ليس بعد',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'font1',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 54,
                                    width: width - 44,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF65B741),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(19),
                                          bottomRight: Radius.circular(19),
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: onTap2,
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.only(
                                                  left: 100,
                                                  right: 100,
                                                  top: 10,
                                                  bottom: 10)),
                                          child: Text(
                                            "تم الحل",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'font1',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
