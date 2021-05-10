import 'dart:async';

import 'package:flutter/material.dart';

class WidgetAnimator extends StatelessWidget {
  final int animatedtime;
  final int durationtime;
  final bool horizontal;
  final bool vertical;
  final Widget child;

  const WidgetAnimator({
    Key key,
    this.animatedtime = 290,
    this.durationtime = 100,
    this.horizontal = false,
    this.vertical = false,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Animator(
        animatedtime: animatedtime,
        durationtime: durationtime,
        horizontal: horizontal,
        vertical: vertical,
        child: child,
      );
}

class Animator extends StatefulWidget {
  final int animatedtime;
  final int durationtime;
  final bool horizontal;
  final bool vertical;
  final Widget child;

  const Animator({
    Key key,
    @required this.animatedtime,
    @required this.durationtime,
    @required this.horizontal,
    @required this.vertical,
    @required this.child,
  }) : super(key: key);

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  Timer timer;
  Duration duration;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    duration = Duration();
    animationController = AnimationController(
        duration: Duration(milliseconds: this.widget.animatedtime),
        vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    Timer(waitDuration(), animationController.forward);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Duration waitDuration() {
    if (timer == null || !timer.isActive) {
      timer = Timer(
        Duration(microseconds: 120),
        () {
          duration = Duration();
        },
      );
    }
    duration += Duration(milliseconds: this.widget.durationtime);
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: this.widget.vertical
                ? Offset(0.0, (1 - animation.value) * 20)
                : this.widget.horizontal
                    ? Offset((1 - animation.value) * 20, 0.0)
                    : Offset(0.0, 0.0),
            child: child,
          ),
        );
      },
    );
  }
}
