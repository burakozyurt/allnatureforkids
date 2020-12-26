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
    return SwipeStack(
      key: swipeKey,
      stackFrom: StackFrom.Left,
      translationInterval: 8,
      scaleInterval: 0.04,
      historyCount: sectionDataModelList.length,
      onEnd: () {
        learningPageManageModel.currentIndex = sectionDataModelList.length;
      },
      onSwipe: (int index, SwiperPosition position) async {
        learningPageManageModel.currentIndex = index;

        if(index != 0){
          learningPageManageModel.playSound(sectionDataModelList.toList().reversed.toList()[index], AppLocalizations.of(context).locale.languageCode);
          await playScaleAnimation();
        }

      },
      onRewind: (int index, SwiperPosition position) async {

        learningPageManageModel.currentIndex--;
        learningPageManageModel.playSound(sectionDataModelList.toList().reversed.toList()[learningPageManageModel.currentIndex], AppLocalizations.of(context).locale.languageCode);
        await playScaleAnimation();

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
                value =1;
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
                              ))),
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

  playScaleAnimation()async{
    await Future.delayed(Duration(milliseconds: 200));
    learningPageManageModel.imageScale = 1.02;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.03;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.04;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.05;
    await Future.delayed(Duration(milliseconds: 200));
    learningPageManageModel.imageScale = 1.05;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.04;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.03;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.02;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1.01;
    await Future.delayed(Duration(milliseconds: 25));
    learningPageManageModel.imageScale = 1;
    return;
  }
}