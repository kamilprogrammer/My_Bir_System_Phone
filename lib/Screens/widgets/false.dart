import 'package:flutter/material.dart';

class False extends StatelessWidget {
  const False({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.width - 20,
      child: Dialog(
        //insetPadding: EdgeInsets.all(0),
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
                  Icons.back_hand,
                  color: Colors.redAccent,
                  size: 50,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'font1',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
