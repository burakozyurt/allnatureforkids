import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_big_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_manage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class RiveBigBalloon extends StatelessWidget {
  Artboard _riveArtboard;

  String name = '0';
  QuizPageManageModel quizPageManageModel;
  QuizPageBigBalloonManageModel quizPageBigBalloonManageModel;
  @override
  Widget build(BuildContext context) {
    quizPageManageModel = Provider.of<QuizPageManageModel>(context,listen: false);
    quizPageBigBalloonManageModel = Provider.of<QuizPageBigBalloonManageModel>(context,listen: false);
    return FutureBuilder(
        future: rootBundle.load('assets/environment/rive/big_balloon.riv'),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container();
          }
          RiveAnimationController _controller;
          final file = RiveFile();

          // Load the RiveFile from the binary data.
          if (file.import(snapshot.data)) {
            // The artboard is the root of the animation and gets drawn in the
            // Rive widget.
            final artboard = file.mainArtboard;
            // Add a controller to play back a known animation on the main/default
            // artboard.We store a reference to it so we can toggle playback.
            artboard.addController(_controller = SimpleAnimation('0'));
            _riveArtboard = artboard;
          }
          return Consumer<QuizPageBigBalloonManageModel>(
              builder: (context, data,child) {
                if(_riveArtboard != null){
                  if(quizPageManageModel.nameRive != '0'){

                  }
                  _riveArtboard.artboard.remove();
                  RiveAnimationController _controller;
                  final file = RiveFile();

                  // Load the RiveFile from the binary data.
                  if (file.import(snapshot.data)) {
                    // The artboard is the root of the animation and gets drawn in the
                    // Rive widget.
                    final artboard = file.mainArtboard;
                    // Add a controller to play back a known animation on the main/default
                    // artboard.We store a reference to it so we can toggle playback.
                    artboard.addController(_controller = SimpleAnimation(data.riveName));
                    _riveArtboard = artboard;
                  }
                }
                return  _riveArtboard == null
                    ? const SizedBox(): Rive(
                  artboard: _riveArtboard,
                );
              },
            child: _riveArtboard == null
              ? const SizedBox(): Rive(
            artboard: _riveArtboard,
          ),
          );
        }
    );
  }
}

