import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/logic/logic.dart';
import 'package:flutter_new/logic/sound_logic.dart';
import 'package:flutter_new/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewModel{
  Logic _logic = Logic();

  SoundLogic _soundLogic = SoundLogic();

  late WidgetRef _ref;

  void setRef(WidgetRef ref){
    this._ref = ref;
    _soundLogic.load();
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp => _ref.read(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref.read(countDataProvider.select((value) => value.countDown)).toString();

  void onIncrease(){
    _logic.increase();
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
    _soundLogic.valeuChanged(oldValue, newValue);
  }
}