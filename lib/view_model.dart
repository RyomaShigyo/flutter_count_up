import 'package:flutter/animation.dart';
import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/logic/button_animation_logic.dart';
import 'package:flutter_new/logic/logic.dart';
import 'package:flutter_new/logic/sound_logic.dart';
import 'package:flutter_new/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewModel{
  Logic _logic = Logic();
  SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;

  late WidgetRef _ref;

  void setRef(WidgetRef ref, TickerProvider tickerProvider){
    this._ref = ref;
    _buttonAnimationLogicPlus = ButtonAnimationLogic(tickerProvider);
    _soundLogic.load();
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp => _ref.read(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref.read(countDataProvider.select((value) => value.countDown)).toString();

  get animationPlus => _buttonAnimationLogicPlus.animationScale;

  void onIncrease(){
    _logic.increase();
    _buttonAnimationLogicPlus.start();
    update();
  }

  void onDecrease(){
    _logic.decrease();
    update();
  }

  void onReset(){
    _logic.reset();
    update();
  }

  void update(){
    CountData oldValue = _ref.watch(countDataProvider.notifier).state;
    _ref.watch(countDataProvider.notifier).state = _logic.countData;
    CountData newValue = _ref.watch(countDataProvider.notifier).state;
    _soundLogic.valueChanged(oldValue, newValue);
    _buttonAnimationLogicPlus.valueChanged(oldValue, newValue);
  }
}