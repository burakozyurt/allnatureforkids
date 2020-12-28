import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundManager{
  static final player = AudioCache();
  static final playerSection = AudioCache();
  static final playerBackground = AudioCache();
  static AudioPlayer playerAudioBackground = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  static final itemPlayerBackground = AudioCache();

  static AudioPlayer itemPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  stopItemLocal(){
    itemPlayer.stop();

  }

  playItemLocal(String path) async {
    //int result = await audioPlayer.play(localPath, isLocal: true);
    await Future.delayed(Duration(milliseconds: 500));
    itemPlayer.stop();
    itemPlayerBackground.load(path);
    itemPlayer = await itemPlayerBackground.play(path,volume: 0.8,);
  }

  playTap()async{
    player.play('environment/sound_effect/tap.wav',volume: 0.8,);
  }
  playClockTick()async{
    player.play('environment/sound_effect/clock_tac.wav',volume: 0.8,);
  }
  playSectionName(String sectionId)async{
    player.play('sections/$sectionId/en/names/$sectionId.wav',volume: 0.8,);
  }

  playBackground()async{
    playerBackground.clearCache();
    playerAudioBackground.stop();
    playerBackground.load('environment/background_sound/background_sound.mp3');
    playerAudioBackground = await playerBackground.loop('environment/background_sound/background_sound.mp3',volume: 0.8,);
  }

  stopBackground()async{
    playerAudioBackground.stop();
    playerBackground.clearCache();
  }
  pauseBackground()async{
    playerAudioBackground.pause();
  }
  resumeBackground()async{
    playerAudioBackground.resume();

  }
}