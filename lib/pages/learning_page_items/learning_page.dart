import 'package:allnatureforkids/main_model.dart';
import 'package:allnatureforkids/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LearningPage extends StatelessWidget {
  MainModel mainModel;
  @override
  Widget build(BuildContext context) {
    mainModel = Provider.of<MainModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(children: [
        Positioned.fill(child: BackgroundWidget()),

      ],),
    );
  }
}
