import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/logic/count_data_changed_notifier.dart';

class SoundLogic with CountDataChangedNotifier {
  static const SOUND_DATA_UP = 'sounds/Onoma-Flash08-1(High-Long).mp3';
  static const SOUND_DATA_DOWN = 'sounds/Onoma-Flash09-1(High-Long).mp3';
  static const SOUND_DATA_RESET = 'sounds/Onoma-Flash10-1(Low-1).mp3';

  final AudioCache _cache = AudioCache();
  final player = AudioPlayer();

  void load(){
    _cache.loadAll([
      SOUND_DATA_UP,
      SOUND_DATA_DOWN,
      SOUND_DATA_RESET
    ]);
  }

  void valueChanged(CountData oldData, CountData newData){
    if(newData.countUp == 0 && newData.countDown == 0 && newData.count ==0){
      playResetSound();
    } else if(oldData.countUp + 1 == newData.countUp){
      playUpSound();
    } else if(oldData.countDown + 1 == newData.countDown){
      playDownSound();
    }
  }

  void playUpSound(){
    player.play(AssetSource(SOUND_DATA_UP));
  }

  void playDownSound(){
    player.play(AssetSource(SOUND_DATA_DOWN));
  }

  void playResetSound(){
    player.play(AssetSource(SOUND_DATA_RESET));
  }
}