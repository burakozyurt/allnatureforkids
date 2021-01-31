import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_big_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_manage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class RiveBombBalloon extends StatefulWidget {
  String id;
  VoidCallback onDone;
  RiveBombBalloon({this.id = '2',this.onDone});

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

    rootBundle.load('assets/environment/rive/bomb/balloon_one.riv').then(
      (data) {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('paues'));
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

  @override
  Widget build(BuildContext context) {
    return _riveArtboard == null
        ? const SizedBox()
        : Visibility(
            visible: visibility,
            child: GestureDetector(
              onTap: () async {
                _toggleBomb();
                await Future.delayed(Duration(milliseconds: 1200));
                visibility = false;
                setState(() {

                });
                widget.onDone.call();
              },
              child: Rive(
                artboard: _riveArtboard,
              ),
            ),
          );
  }
}
