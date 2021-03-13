import 'dart:math';

import 'package:allnatureforkids/pages/quiz_page_items/rive_big_balloon.dart';
import 'package:allnatureforkids/pages/quiz_page_items/rive_bomb_items/rive_bomb_balloon_widget.dart';
import 'package:flutter/material.dart';

class _Balloon {
  final String animationIndex;
  final double direction;
  final double speed;
  final double size;
  final double initialPosition;
  final double bottom;
  final double left;
  final RiveBombBalloon riveBombBalloon;

  _Balloon({
    this.animationIndex,
    this.direction,
    this.speed,
    this.size,
    this.initialPosition,
    this.bottom,
    this.left,
    this.riveBombBalloon
  });
}
class RiveGameInitial extends StatelessWidget{
  bool isBackground;

  RiveGameInitial({this.isBackground = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RiveBombGame(mediaQueryData: MediaQuery.of(context),isBackground: isBackground,);
  }

}

class RiveBombGame extends StatefulWidget{
  VoidCallback onDone;
  bool isBackground;
  MediaQueryData mediaQueryData;
  RiveBombGame({this.onDone,this.mediaQueryData,this.isBackground});

  @override
  _RiveBombGameState createState() => _RiveBombGameState();
}

class _RiveBombGameState extends State<RiveBombGame> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _progressAnimation;
  List<_Balloon> balloons;
  @override
  void initState() {
    final dataQuery = widget.mediaQueryData;
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _progressAnimation = CurvedAnimation(parent: _animationController,curve: Interval(0.0,1.0));
    super.initState();
    balloons = List<_Balloon>.generate(80, (index) {
      final size = Random().nextDouble()%0.5;
      final speed = Random().nextInt(50) + 30.0;
      final directionRandom = Random().nextBool();
      final direction = Random().nextInt(150) * (directionRandom ? 1.0 : -1.0);
      final index = Random().nextInt(4).toString();
      var left = Random().nextInt((dataQuery.size.width - 150.0).toInt()).toDouble();
      if(left < 0){
        left += 150.0;
      }
      final bottom = Random().nextInt((dataQuery.size.height*1.4).toInt())*-1 - 300;
      return _Balloon(animationIndex: index,size: size,speed: speed,direction: direction,left: left,bottom: bottom.toDouble(),riveBombBalloon: RiveBombBalloon(id: index,isBackground: widget.isBackground,));
    }).toList();
    _animationController.forward();
    _progressAnimation.addListener(() {
      if(_progressAnimation.isCompleted){
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  balloonsWidget(Animation<double> progressAnimaiton){
    return balloons.map((_balloon) => Positioned(
      bottom: _balloon.bottom + progressAnimaiton.value * 50 * _balloon.speed,
      left: _balloon.left  + progressAnimaiton.value * 2 * _balloon.direction,
      height: 150,
      width: 80,
      child: Transform.scale(scale: (0.8 + _balloon.size),child: _balloon.riveBombBalloon),
    )).toList();

  }
  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context,child){
        return Opacity(
          opacity: widget.isBackground ? _progressAnimation.value * 0.6 :1,
          child: Scaffold(
            backgroundColor: Colors.black26,
            body: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: balloonsWidget(_progressAnimation),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
