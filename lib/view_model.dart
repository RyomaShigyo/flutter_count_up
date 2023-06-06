import 'package:flutter_new/logic.dart';
import 'package:flutter_new/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewModel{
  Logic _logic = Logic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref){
    this._ref = ref;
  }

  get count => _ref.watch(countDataProvider).count.toString();

  get countUp => _ref.read(countDataProvider.select((value) => value.countUp)).toString();

  get countDown => _ref.read(countDataProvider.select((value) => value.countDown)).toString();

  void onIncrease(){
    _logic.increase();
    _ref.watch(countDataProvider.notifier).state = _logic.countData;
  }

  void onDecrease(){
    _logic.decrease();
    _ref.watch(countDataProvider.notifier).state = _logic.countData;
  }

  void onReset(){
    _logic.reset();
    _ref.watch(countDataProvider.notifier).state = _logic.countData;
  }
}