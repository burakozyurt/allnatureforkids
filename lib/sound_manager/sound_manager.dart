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
    itemPlayerBackground.clearCache();
    itemPlayerBackground.load(path);
    itemPlayer = await itemPlayerBackground.play(path,volume: 0.8,mode: PlayerMode.MEDIA_PLAYER);
  }

  playTap()async{
    if(player.loadedFiles.length > 10){
      player.clearCache();
    }
    player.play('environment/sound_effect/tap.wav',volume: 0.8,);
  }

  clearCache(){
    if(player.loadedFiles.length > 1){
      player.clearCache();
    }
  }

  playBalloonPopping()async{
    clearCache();
    player.play('environment/sound_effect/balloon_popping.wav',volume: 0.8,mode: PlayerMode.LOW_LATENCY);
  }
  playSuccess()async{
    clearCache();
    player.play('environment/sound_effect/success.wav',volume: 0.8,mode: PlayerMode.LOW_LATENCY);
  }
  playClockTick()async{
    clearCache();

    player.play('environment/sound_effect/clock_tac.wav',volume: 0.8,mode: PlayerMode.LOW_LATENCY);
  }
  playSectionName(String sectionId)async{
    clearCache();

    player.play('sections/$sectionId/en/names/$sectionId.wav',volume: 0.8,mode: PlayerMode.LOW_LATENCY);
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