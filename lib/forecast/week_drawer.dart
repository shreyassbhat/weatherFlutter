import 'dart:ui';

import 'package:flutter/material.dart';

class WeekDrawer extends StatelessWidget {
  final week = [
    'Tuesday\nOctober 02',
    'Wednesday\nOctober 03',
    'Thursday\nOctober 04',
    'Friday\nOctober 05',
    'Saturday\nOctober 06',
    'Sunday\nOctober 07',
    'Monday\nOctober 08',
  ];

  final Function(String title) onDaySelected;

  WeekDrawer({
    this.onDaySelected,
  });

  List<Widget> _buildDayButtons() {
    return week.map((String title) {
      return new Expanded(
        child: new GestureDetector(
          onTap: () {
            onDaySelected(title);
          },
          child: new Text(
            title,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new ClipRect(
      clipper: new RectClipper(),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: new Container(
            width: 125.0,
            height: double.infinity,
            color: const Color(0xAA234060),
            child: new Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ]..addAll(_buildDayButtons()),
                ))),
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
