import 'dart:ffi';

import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = Provider<String>((ref){
  return 'riverpod demo';
});

final messageProvider = Provider<String>((ref){
  return '何回タップしたか';
});

//final countProvider = StateProvider<int>((ref) => 0);
final countDataProvider = StateProvider<CountData>(
        (ref) => CountData(
            count: 0,
            countUp: 0,
            countDown: 0));