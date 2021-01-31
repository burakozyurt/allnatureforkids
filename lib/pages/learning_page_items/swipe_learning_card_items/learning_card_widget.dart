import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/colors.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_manage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';

class LearningCardWidget extends StatelessWidget {
  final GlobalKey<SwipeStackState> swipeKey;
  List<SectionDataModel> sectionDataModelList;
  LearningCardWidget({this.swipeKey,this.sectionDataModelList});

  LearningPageManageModel learningPageManageModel;

  @override
  Widget build(BuildContext context) {
    learningPageManageModel = Provider.of<LearningPageManageModel>(context,listen: false);
    firstPlay(context);
    return SwipeStack(
      key: swipeKey,
      stackFrom: StackFrom.Right,
      translationInterval: 4,
      scaleInterval: 0.04,
      visibleCount: 3,
      historyCount: sectionDataModelList.length,
      onEnd: () {
        learningPageManageModel.currentIndex = sectionDataModelList.length;
      },
      onSwipe: (int index, SwiperPosition position) async {
      //  print((index.toString() + '\n')*5);
        learningPageManageModel.currentIndex++;

        if(index != 0 && !learningPageManageModel.isAnimationEnabled){
          learningPageManageModel.isAnimationEnabled = true;
          learningPageManageModel.playSound(sectionDataModelList.toList().reversed.toList()[learningPageManageModel.currentIndex], AppLocalizations.of(context).locale.languageCode);
          await playScaleAnimation();
          learningPageManageModel.isAnimationEnabled = false;
        }else{
          learningPageManageModel.stopSound();
        }

      },
      onRewind: (int index, SwiperPosition position) async {
        //print((index.toString() + '\n')*5);

        learningPageManageModel.currentIndex--;
        if(!learningPageManageModel.isAnimationEnabled){
          learningPageManageModel.isAnimationEnabled = true;
          learningPageManageModel.playSound(sectionDataModelList.toList().reversed.toList()[learningPageManageModel.currentIndex], AppLocalizations.of(context).locale.languageCode);
          await playScaleAnimation();
          learningPageManageModel.isAnimationEnabled = false;
        }else{
          learningPageManageModel.stopSound();
        }

      },
      children: sectionDataModelList.map((SectionDataModel sectionDataModel) {
        return SwiperItem(builder: (SwiperPosition position, double progress) {
          return Consumer<LearningPageManageModel>(
            builder: (context, data,_) {
              double value = data.imageScale;
              int index = data.currentIndex;
              if(index == sectionDataModelList.length){
                index = sectionDataModelList.length-1;
              }
              if(sectionDataModel.name != sectionDataModelList.toList().reversed.toList()[index].name){
                value = 1;
              }
              return Transform.scale(
                scale: value,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white30,
                                blurRadius: 0.2,
                                spreadRadius: 0.0,
                                offset: Offset(-4.0, -4.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          child: GestureDetector(
                            onTap: () async {
                              if(!data.isAnimationEnabled){
                                data.isAnimationEnabled = true;
                                learningPageManageModel.playSound(sectionDataModelList.toList().reversed.toList()[data.currentIndex], AppLocalizations.of(context).locale.languageCode);
                                await playScaleAnimation();
                                data.isAnimationEnabled = false;

                              }

                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(24)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image(
                                                image: AssetImage(
                                                    sectionDataModel.photo),
                                                fit: BoxFit.cover,
                                                filterQuality: FilterQuality.low,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/environment/learning_items/waves.png'),
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.low,

                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 24.0, right: 16,bottom: 4),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  sectionDataModel.languageName.toJson()[AppLocalizations.of(context).locale.languageCode],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: ThemeColor.yaziAra,
                                                    fontSize: ScreenUtil().setSp(
                                                      24,
                                                    ),
                                                  ),

                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                )),
                          )),
                    ),
                  ],
                ),
              );
            }
          );
        });
      }).toList(),
    );
  }
  firstPlay(BuildContext context)async{
    await Future.delayed(Duration(milliseconds: 200));
    learningPageManageModel.playSound(sectionDataModelList.toList().reversed.toList()[learningPageManageModel.currentIndex], AppLocalizations.of(context).locale.languageCode);
    playScaleAnimation();
  }
  playScaleAnimation()async{
    await Future.delayed(Duration(milliseconds: 200));
    learningPageManageModel.imageScale = 1.01;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.015;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.02;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.025;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.030;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.035;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.040;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.045;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.050;
    await Future.delayed(Duration(milliseconds: 100));
    learningPageManageModel.imageScale = 1.045;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.04;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.035;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.03;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.025;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.02;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.015;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1.01;
    await Future.delayed(Duration(milliseconds: 10));
    learningPageManageModel.imageScale = 1;
    return;
  }
}
