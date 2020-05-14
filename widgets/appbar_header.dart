import 'package:flutter/material.dart';

AppBar appbarHeader(String title, Color color) {
  return AppBar(
    backgroundColor: Colors.black,
    title: Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'WILD',
          shadows: [
            Shadow(blurRadius: 5.0, offset: Offset.zero, color: color),
          ],
          color: Colors.white,
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(27.0),
    ),
  );
}
