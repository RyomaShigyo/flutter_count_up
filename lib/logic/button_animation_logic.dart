import 'package:flutter/animation.dart';
import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/logic/count_data_changed_notifier.dart';
import 'dart:math' as math;

class ButtonAnimationLogic with CountDataChangedNotifier {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<double> _animationRotation;

  late AnimationCombination _animationCombination;

  get animationScale => _animationScale;
  get animationRotation => _animationRotation;
  get animationCombination => _animationCombination;

  ValueChangedCondition startCondition;

  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition){
    _animationController = AnimationController(
        vsync: tickerProvider,
        duration: const Duration(milliseconds: 500),
    );

    _animationScale = _animationController
        .drive(CurveTween(curve: Interval(0.4, 0.8)))
        .drive(Tween(begin: 1.0,end: 1.8));

    _animationRotation = _animationController
        .drive(CurveTween(curve: Interval(0.0, 0.7,curve: ButtonRotateCurve())))
        .drive(Tween(begin: 0.0,end: 1.0));

    _animationCombination = AnimationCombination(_animationScale, _animationRotation);
  }

  @override
  void dispose(){
    _animationController.dispose();
  }

  void start(){
    _animationController.forward()
        .whenComplete(() => _animationController.reset());
  }

  @override
  void valueChanged(CountData oldValue, CountData newValue){
    if(startCondition(oldValue, newValue)){
      start();
    }
  }
}

class ButtonRotateCurve extends Curve{
  @override
  double transform(double t){
    return math.sin(2 * math.pi * t) / 16;
  }
}

class AnimationCombination{
  final Animation<double> animationScale;
  final Animation<double> animationRotation;

  AnimationCombination(this.animationScale, this.animationRotation);
}