import 'package:flutter/animation.dart';
import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/logic/button_animation_logic.dart';
import 'package:flutter_new/logic/count_data_changed_notifier.dart';
import 'package:flutter_new/logic/logic.dart';
import 'package:flutter_new/logic/sound_logic.dart';
import 'package:flutter_new/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewModel{
  Logic _logic = Logic();
  SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;
  late ButtonAnimationLogic _buttonAnimationLogicMinus;
  late ButtonAnimationLogic _buttonAnimationLogicReset;

  late WidgetRef _ref;

  List<CountDataChangedNotifier> notifiers = [];

  void setRef(WidgetRef ref, TickerProvider tickerProvider){
    this._ref = ref;

    ValueChangedCondition conditionPlus = (CountData oldValue, CountData newValue){
      return oldValue.countUp + 1 == newValue.countUp;
    };

    ValueChangedCondition conditionMinus = (CountData oldValue, CountData newValue){
      return oldValue.countDown + 1 == newValue.countDown;
    };

    ValueChangedCondition conditionReset = (CountData oldValue, CountData newValue){
      return newValue.countUp == 0 && newValue.countDown == 0;
    };

    _buttonAnimationLogicPlus = ButtonAnimationLogic(tickerProvider, conditionPlus);
    _buttonAnimationLogicMinus = ButtonAnimationLogic(tickerProvider, conditionMinus);
    _buttonAnimationLogicReset = ButtonAnimationLogic(tickerProvider, conditionReset);
    _soundLogic.load();
    notifiers = [
      _soundLogic,
      _buttonAnimationLogicPlus,
      _buttonAnimationLogicMinus,
      _buttonAnimationLogicReset,
    ];
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp => _ref.read(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref.read(countDataProvider.select((value) => value.countDown)).toString();

  get animationPlus => _buttonAnimationLogicPlus.animationScale;
  get animationMinus => _buttonAnimationLogicMinus.animationScale;
  get animationReset => _buttonAnimationLogicReset.animationScale;

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
    notifiers.forEach((element) => element.valueChanged(oldValue, newValue));
    //↑上の１行とした２行は同じ
    // _soundLogic.valueChanged(oldValue, newValue);
    // _buttonAnimationLogicPlus.valueChanged(oldValue, newValue);
  }
}