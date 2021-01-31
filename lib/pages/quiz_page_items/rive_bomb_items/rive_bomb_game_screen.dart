import 'package:allnatureforkids/pages/quiz_page_items/rive_big_balloon.dart';
import 'package:allnatureforkids/pages/quiz_page_items/rive_bomb_items/rive_bomb_balloon_widget.dart';
import 'package:flutter/material.dart';

class RiveBombGame extends StatelessWidget {
  VoidCallback onDone;

  RiveBombGame({this.onDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          AnimatedPositioned(
            bottom: 0,
            left: 0,
            height: 150,
            width: 150,
            duration: Duration(milliseconds: 1000),
            child: RiveBombBalloon(
              id: '2',
              onDone: () {},
            ),
          )
        ],
      ),
    );
  }
}
