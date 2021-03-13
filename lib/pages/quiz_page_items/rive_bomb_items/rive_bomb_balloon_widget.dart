import 'package:allnatureforkids/locator.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_big_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_manage_model.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class RiveBombBalloon extends StatefulWidget {
  String id;
  VoidCallback onDone;
  bool isBackground;
  RiveBombBalloon({this.id = '2',this.onDone,this.isBackground});

  @override
  _RiveBombBalloonState createState() => _RiveBombBalloonState();
}

class _RiveBombBalloonState extends State<RiveBombBalloon> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  int current = 0;
  bool visibility = true;
  String path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    path = 'balloon_' + widget.id + '.riv';

    rootBundle.load('assets/environment/rive/ballon_one.riv').then(
      (data) {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation(widget.id));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }
  void _toggleBomb() {
    setState(() {
      current = 1;
      _riveArtboard.artboard..addController(_controller = SimpleAnimation('bomb'));
    });
  }
  bool isIgnore = false;
  @override
  Widget build(BuildContext context) {

    if (_riveArtboard == null) {
      return const SizedBox();
    } else {
      return Visibility(
            visible: visibility,
            child: IgnorePointer(
              ignoring: isIgnore,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) async {
                  print(details.localPosition.dy);
                  if(details.localPosition.dy > 0 && details.localPosition.dy < 120 && details.localPosition.dx >10 &&  details.localPosition.dx<70){
                    if(widget.isBackground){

                    }else{
                      visibility = false;
                      getIt.get<SoundManager>().playBalloonPopping();
                      setState(() {

                      });
                     // widget.onDone.call();
                    }
                  }
                },
                child: Rive(
                  artboard: _riveArtboard,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
    }
  }
}
