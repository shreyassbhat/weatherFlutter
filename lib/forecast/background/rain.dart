import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';

ImageMap _images;
SpriteSheet _sprites;

class Rain extends StatefulWidget {
  @override
  _RainState createState() => new _RainState();
}

class _RainState extends State<Rain> {
  bool assetsLoaded = false;
  WeatherWorld weatherWorld;

  @override
  void initState() {
    super.initState();

    AssetBundle bundle = rootBundle;
    _loadAssets(bundle).then((_) {
      setState(() {
        assetsLoaded = true;
        weatherWorld = new WeatherWorld();
      });
    });
  }

  Future<Null> _loadAssets(AssetBundle bundle) async {
    _images = new ImageMap(bundle);

    // Load sprites bitmap file.
    await _images.load([
      'assets/weathersprites.png',
    ]);

    // Configure sprite sheet based on loaded bitmap.
    String json = await DefaultAssetBundle.of(context)
        .loadString('assets/weathersprites.json');
    _sprites = new SpriteSheet(_images['assets/weathersprites.png'], json);
  }

  @override
  Widget build(BuildContext context) {
    return assetsLoaded ? new SpriteWidget(weatherWorld) : new Container();
  }
}

class WeatherWorld extends NodeWithSize {
  RainNode _rain;

  WeatherWorld() : super(const Size(2048.0, 2048.0)) {
    _rain = new RainNode();
    _rain.active = true;
    addChild(_rain);
  }
}

class RainNode extends Node {
  List<ParticleSystem> _particles = [];

  RainNode() {
    _addParticles(1.0);
    _addParticles(1.5);
    _addParticles(2.0);
  }

  void _addParticles(double distance) {
    ParticleSystem particles = new ParticleSystem(
      _sprites['raindrop.png'],
      transferMode: BlendMode.lighten,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 10000.0 / distance,
      speedVar: 100.0 / distance,
      startSize: 1.2 / distance,
      startSizeVar: 0.2 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 1.5 * distance,
      lifeVar: 1.0 * distance,
      maxParticles: 15,
    );
    particles.position = const Offset(1024.0, 200.0);
    particles.rotation = 0.0;
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    actions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        actions.run(
          new ActionTween<double>(
            (value) => system.opacity = value,
            system.opacity,
            1.0,
            2.0,
          ),
        );
      } else {
        actions.run(new ActionTween<double>(
          (value) => system.opacity = value,
          system.opacity,
          0.0,
          0.5,
        ));
      }
    }
  }
}
