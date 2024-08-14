import 'package:flutter/material.dart';

class True extends StatelessWidget {
  const True({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), side: BorderSide.none),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_turned_in,
                color: Colors.blueAccent,
                size: 50,
              ),
            ],
          ),
          Text(
            text.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'font1',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
