import 'package:flutter/material.dart';
import 'package:weather/forecast/background/background_with_rings.dart';
import 'package:weather/forecast/background/rain.dart';
import 'package:weather/forecast/forecast_list.dart';
import 'package:weather/forecast/radial_list.dart';

class Forecast extends StatelessWidget {
  final RadialListViewModel list;
  final SlidingRadialListController listController;

  Forecast({
    this.list,
    this.listController,
  });

  Widget _buildTemperatureText() {
    return new Align(
      alignment: Alignment.centerLeft,
      child: new Padding(
        padding: const EdgeInsets.only(top: 150.0, left: 10.0),
        child: new Text(
          '25°',
          style: new TextStyle(
            color: Colors.white,
            fontSize: 80.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      new BackgroundWithRings(
        rawBackground: new AssetImage('assets/weather-bk.png'),
        frostedBackground: new AssetImage('assets/weather-bk_enlarged.png'),
        seeThruCircleRadius: 140.0,
        seeThruCircleOffset: const Offset(40.0, 0.0),
      ),
      _buildTemperatureText(),
      new AnimatedBuilder(
          animation: listController,
          builder: (BuildContext context, Widget child) {
            return new SlidingRadialList(
              radialList: forecastRadialList,
              controller: listController,
            );
          }),
      new Rain(),
    ]);
  }
}
