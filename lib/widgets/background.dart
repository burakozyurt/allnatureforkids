import 'package:flutter/material.dart';
class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: AssetImage('assets/environment/background/background.png'),
        fit: BoxFit.cover,
        filterQuality: FilterQuality.low,
      ),
    );
  }
}
