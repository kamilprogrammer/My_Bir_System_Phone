import 'package:flutter/material.dart';
import 'package:rjd_app/main.dart';

class StatusCard extends StatelessWidget {
  const StatusCard(
      {super.key,
      required this.section,
      required this.title,
      required this.desc,
      required this.done,
      required this.notes,
      required this.index});

  final String desc;
  final String notes;
  final String section;
  final String title;
  final bool done;
  final int index;

  Widget _buildContentRow(IconData icon, String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, fontFamily: "font1"),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Container(
              width: 32,
              height: 32,
              decoration: const ShapeDecoration(
                color: Color(0xFF323751),
                shape: OvalBorder(),
              ),
              child: Icon(icon, color: Colors.white, size: 20)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05, top: 2),
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: const Color.fromARGB(255, 68, 79, 134), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with name and status indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "$section | ${title}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "font1",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(thickness: 1, color: Colors.black),
                SizedBox(height: screenHeight * 0.02),
                // Main content
                _buildContentRow(Icons.description, desc, screenWidth),
                _buildContentRow(Icons.color_lens, notes, screenWidth),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: screenWidth * 0.06, top: 6),
          width: 40,
          height: 40,
          decoration: ShapeDecoration(
            color: done == false ? const Color(0xFFC21010) : Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: done == false
                    ? const Color(0x3FFF0000)
                    : const Color.fromARGB(164, 76, 175, 79),
                blurRadius: 8,
                offset: const Offset(0, 0),
                spreadRadius: 1,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (index + 1).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "font1", fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
