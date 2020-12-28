import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/colors.dart';
import 'package:allnatureforkids/main_model.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_bloc.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_manage_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_repository.dart';
import 'package:allnatureforkids/pages/learning_page_items/swipe_learning_card_items/learning_card_widget.dart';
import 'package:allnatureforkids/shared/bloc/bloc_provider.dart';
import 'package:allnatureforkids/utils/alet_dialog_widgets.dart';
import 'package:allnatureforkids/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';

class LearningPage extends StatelessWidget {
  MainModel mainModel;
  LearningPageManageModel learningPageManageModel;
  LearningPageBloc learningPageBloc;
  final GlobalKey<SwipeStackState> _swipeKey = GlobalKey<SwipeStackState>();

  @override
  Widget build(BuildContext context) {
    mainModel = Provider.of<MainModel>(context);
    learningPageManageModel = Provider.of<LearningPageManageModel>(context, listen: false);
    learningPageBloc = BlocProvider.of<LearningPageBloc>(context);
    learningPageBloc.fetchAllData('fruit');
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder(
          stream: learningPageBloc.sectionDataModelListStream,
          builder: (context, AsyncSnapshot<List<SectionDataModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Stack(
                children: [
                  Positioned.fill(child: BackgroundWidget()),
                ],
              );
            }
            List<SectionDataModel> sectionDataModelList = snapshot.data;
            learningPageManageModel.resetVariables();
            return Stack(
              children: [
                Positioned.fill(child: BackgroundWidget()),
                Positioned(
                    top: 0,
                    height: MediaQuery.of(context).size.height * 0.7 / 12,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Transform.scale(
                                scale: 1.5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ThemeColor.anaRenk1,
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image(
                                  image: AssetImage('assets/environment/learning_items/home.png'),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 1 / 12,
                    height: MediaQuery.of(context).size.height * 0.7 / 12,
                    right: 16,
                    left: 16,
                    child: GestureDetector(behavior: HitTestBehavior.translucent,
                      onTapCancel: () {
                        learningPageManageModel.pressDetailsStartQuiz('CANCEL');
                      },
                      onTapDown: (details) {
                        learningPageManageModel.pressDetailsStartQuiz('DOWN');
                      },
                      onTapUp: (details) async {
                        learningPageManageModel.pressDetailsStartQuiz('UP');
                      },
                      child: Consumer<LearningPageManageModel>(
                        builder: (context, data,_) {
                          return Transform.scale(
                            scale:data.startQuizScale,
                            child: Center(
                              child: Container(
                                width: ScreenUtil().setWidth(183),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18.0),
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white30,
                                                blurRadius: 0.2,
                                                spreadRadius: 0.0,
                                                offset: Offset(-4.0, -4.0), // shadow direction: bottom right
                                              ),
                                              BoxShadow(
                                                color: Colors.white30,
                                                blurRadius: 0.2,
                                                spreadRadius: 0.0,
                                                offset: Offset(4.0, -4.0), // shadow direction: bottom right
                                              ),
                                              BoxShadow(
                                                color: Colors.white30,
                                                blurRadius: 0.2,
                                                spreadRadius: 0.0,
                                                offset: Offset(4.0, 4.0), // shadow direction: bottom right
                                              ),
                                              BoxShadow(
                                                color: Colors.white30,
                                                blurRadius: 0.2,
                                                spreadRadius: 0.0,
                                                offset: Offset(-4.0, 4.0), // shadow direction: bottom right
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      elevation: 4,
                                      borderRadius: BorderRadius.all(Radius.circular(18)),
                                      child: Container(
                                        width: ScreenUtil().setWidth(183),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(18)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context).translate('start_quiz'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ThemeColor.yaziAra,
                                                  fontSize: ScreenUtil().setSp(
                                                    18,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 16, bottom: 16, left: 4),
                                                child: Image(
                                                  image: AssetImage('assets/environment/learning_items/play_icon.png'),
                                                  fit: BoxFit.cover,
                                                  filterQuality: FilterQuality.low,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 2 / 12,
                    right: 16,
                    left: 16,
                    height: MediaQuery.of(context).size.height * 2 / 12,
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
                                  ),
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius: 0.2,
                                    spreadRadius: 0.0,
                                    offset: Offset(4.0, -4.0), // shadow direction: bottom right
                                  ),
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius: 0.2,
                                    spreadRadius: 0.0,
                                    offset: Offset(4.0, 4.0), // shadow direction: bottom right
                                  ),
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius: 0.2,
                                    spreadRadius: 0.0,
                                    offset: Offset(-4.0, 4.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16, bottom: 16),
                            child: Consumer<LearningPageManageModel>(builder: (context, data, _) {
                              return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sectionDataModelList.length > 3 ? 3 : sectionDataModelList.length,
                                  itemBuilder: (context, index) {
                                    int currentIndex;
                                    bool hasEmpty = false;
                                    if (sectionDataModelList.length > 3) {
                                      currentIndex =
                                          (index + (data.currentIndex % 3 - 1)) + ((data.currentIndex ~/ 3)) * 3;
                                      if (currentIndex < 0) {
                                        hasEmpty = true;
                                        currentIndex = sectionDataModelList.length - 1;
                                      }
                                      if (currentIndex > sectionDataModelList.length - 1) {
                                        hasEmpty = true;
                                        currentIndex = sectionDataModelList.length - 1;
                                      }
                                    } else {
                                      currentIndex = index;
                                    }
                                    SectionDataModel sectionDataModel =
                                        sectionDataModelList.toList().reversed.toList()[currentIndex];
                                    return Transform.scale(
                                      scale: index == 1 ? 1.1 : 0.8,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0, top: 8, bottom: 8, right: 10),
                                        child: Material(
                                          elevation: 4,
                                          borderRadius: BorderRadius.circular(24),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (hasEmpty == false) {
                                                int targetIndex;
                                                targetIndex = sectionDataModelList
                                                    .toList()
                                                    .reversed
                                                    .toList()
                                                    .indexWhere((element) => element.name == sectionDataModel.name);
                                                print(targetIndex);
                                                int currentIndex = learningPageManageModel.currentIndex;
                                                int direction;
                                                int difference = (currentIndex - targetIndex).abs();
                                                if (currentIndex > targetIndex) {
                                                  direction = 1;
                                                } else if (currentIndex < targetIndex) {
                                                  direction = -1;
                                                } else {
                                                  direction = 0;
                                                }
                                                if (direction > 0) {
                                                  for (int i = 0; i < difference; i++) {
                                                    _swipeKey.currentState.rewind();
                                                    await Future.delayed(Duration(milliseconds: 1000));
                                                  }
                                                } else if (direction < 0) {
                                                  for (int i = 0; i < difference; i++) {
                                                    _swipeKey.currentState.swipeRight();
                                                    await Future.delayed(Duration(milliseconds: 1000));
                                                  }
                                                } else {
                                                  return;
                                                }
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(24)),
                                              ),
                                              child: Opacity(
                                                opacity: hasEmpty == true ? 0 : 1,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Image(
                                                      image: AssetImage(sectionDataModel.photo),
                                                      fit: BoxFit.cover,
                                                      filterQuality: FilterQuality.low,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: MediaQuery.of(context).size.height * 4 / 12 + 16,
                  right: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * 6 / 12,
                  child: LearningCardWidget(
                    swipeKey: _swipeKey,
                    sectionDataModelList: sectionDataModelList,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 10 / 12,
                  right: 0,
                  left: 0,
                  height: MediaQuery.of(context).size.height * 2 / 12,
                  child: Consumer<LearningPageManageModel>(builder: (context, data, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        data.currentIndex == 0
                            ? Container(
                                width: 119,
                              )
                            : GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTapCancel: () {
                                  learningPageManageModel.pressDetailsLeft('CANCEL');
                                },
                                onTapDown: (details) {
                                  learningPageManageModel.pressDetailsLeft('DOWN');
                                },
                                onTapUp: (details) async {
                                  /*if(learningPageManageModel.currentIndex < 0){
                                await Future.delayed(Duration(milliseconds: 200));
                                learningPageManageModel.currentIndex = 0;
                              }else{
                                learningPageManageModel.beforeCurrentIndex = learningPageManageModel.currentIndex;
                                learningPageManageModel.currentIndex--;
                                _swipeKey.currentState.rewind();
                                await Future.delayed(Duration(milliseconds: 200));

                              }*/
                                  _swipeKey.currentState.rewind();

                                  learningPageManageModel.pressDetailsLeft('UP');
                                },
                                child: Transform.scale(
                                  scale: learningPageManageModel.leftScale,
                                  child: Container(
                                    width: 119,
                                    child: Image(
                                      image: AssetImage('assets/environment/learning_items/left_arrow.png'),
                                    ),
                                  ),
                                )),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTapCancel: () {
                            learningPageManageModel.pressDetailsShuffle('CANCEL');
                          },
                          onTapDown: (details) {
                            learningPageManageModel.pressDetailsShuffle('DOWN');
                          },
                          onTapUp: (details) {
                            learningPageManageModel.pressDetailsShuffle('UP');
                            learningPageBloc.shuffleSectionDataList();
                            learningPageManageModel.notifyListeners();
                          },
                          child: Transform.scale(
                            scale: learningPageManageModel.shuffleScale,
                            child: Container(
                              width: 54,
                              child: Image(
                                image: AssetImage('assets/environment/learning_items/shuffle.png'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        data.currentIndex == sectionDataModelList.length
                            ? Container(
                          width: 119,
                        )
                            : GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTapCancel: () {
                            learningPageManageModel.pressDetailsRight('CANCEL');
                          },
                          onTapDown: (details) {
                            learningPageManageModel.pressDetailsRight('DOWN');
                          },
                          onTapUp: (details) async {
                            /* if(learningPageManageModel.currentIndex == sectionDataModelList.length){
                                await Future.delayed(Duration(milliseconds: 200));
                                learningPageManageModel.currentIndex = sectionDataModelList.length;
                              }else{
                                learningPageManageModel.beforeCurrentIndex = learningPageManageModel.currentIndex;
                                learningPageManageModel.currentIndex++;
                                await Future.delayed(Duration(milliseconds: 200));
                              }*/
                            _swipeKey.currentState.swipeRight();
                            learningPageManageModel.pressDetailsRight('UP');
                          },
                          child: Transform.scale(
                            scale: learningPageManageModel.rightScale,
                            child: Container(
                              width: 119,
                              child: Image(
                                image: AssetImage('assets/environment/learning_items/right_arrow.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            );
          }),
    );
  }

  deneme() async {
    List<SectionDataModel> list = await LearningPageRepository().getSectionDataModelList('fruit');
    print(list.length);
  }
}
