import 'package:flutter/widgets.dart';
import 'package:weather/forecast/radial_list.dart';

final RadialListViewModel forecastRadialList = new RadialListViewModel(
  items: [
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_rain.png'),
      title: '11:30AM',
      subtitle: 'Light Rain',
      isSelected: true,
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_rain.png'),
      title: '12:30PM',
      subtitle: 'Light Rain',
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_cloudy.png'),
      title: '1:30PM',
      subtitle: 'Cloudy',
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_sunny.png'),
      title: '2:30P',
      subtitle: 'Sunny',
    ),
    new RadialListItemViewModel(
      icon: new AssetImage('assets/ic_sunny.png'),
      title: '3:30PM',
      subtitle: 'Sunny',
    ),
  ],
);
