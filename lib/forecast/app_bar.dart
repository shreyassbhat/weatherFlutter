import 'package:flutter/material.dart';
import 'package:weather/generic_widgets/spinner_text.dart';

class ForecastAppBar extends StatelessWidget {
  final String dateText;
  final Function onDrawerArrowTap;

  ForecastAppBar({
    this.dateText,
    this.onDrawerArrowTap,
  });

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new SpinnerText(
            text: dateText,
          ),
          new Text('India',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              )),
        ],
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 35.0,
          ),
          onPressed: onDrawerArrowTap,
        ),
      ],
    );
  }
}
