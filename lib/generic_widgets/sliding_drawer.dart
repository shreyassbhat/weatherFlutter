import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class SlidingDrawer extends StatelessWidget {

  final Widget drawer;
  final OpenableController openableController;

  SlidingDrawer({
    @required this.drawer,
    this.openableController,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new GestureDetector(
            onTap: openableController.isOpen()
                ? openableController.close
                : null
        ),
        new Transform(
          transform: new Matrix4.translationValues(
              125.0 * (1.0 - openableController.percentOpen),
              0.0,
              0.0
          ),
          child: new Align(
              alignment: Alignment.centerRight,
              child: drawer,
          ),
        ),
      ],
    );
  }
}


class OpenableController extends ChangeNotifier {

  OpenableState _state = OpenableState.closed;
  AnimationController _opening;

  OpenableController({
    @required TickerProvider vsync,
    @required Duration openDuration,
  }) : _opening = new AnimationController(duration: openDuration, vsync: vsync) {
    _opening..addListener(() {
      notifyListeners();
    })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = OpenableState.opening;
            break;
          case AnimationStatus.completed:
            _state = OpenableState.open;
            break;
          case AnimationStatus.reverse:
            _state = OpenableState.closing;
            break;
          case AnimationStatus.dismissed:
            _state = OpenableState.closed;
            break;
        }
        notifyListeners();
      });
  }

  get state => _state;

  get percentOpen => _opening.value;

  bool isOpen() {
    return _state == OpenableState.open;
  }

  bool isOpening() {
    return _state == OpenableState.opening;
  }

  bool isClosed() {
    return _state == OpenableState.closed;
  }

  bool isClosing() {
    return _state == OpenableState.closing;
  }

  void open() {
    _opening.forward();
  }

  void close() {
    _opening.reverse();
  }

  void toggle() {
    if (_state == OpenableState.closed) {
      open();
    } else if (_state == OpenableState.open) {
      close();
    }
  }

}

enum OpenableState {
  closed,
  opening,
  open,
  closing,
}