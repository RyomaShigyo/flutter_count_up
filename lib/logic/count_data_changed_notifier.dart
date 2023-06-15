import 'package:flutter_new/data/count_data.dart';

typedef ValueChangedCondition = bool Function(CountData oldValue, CountData newValue);

//↓動画ではabstract classとなっているが、withの後で使えなかった
mixin CountDataChangedNotifier{
  void valueChanged(CountData oldValue, CountData newValue);
}