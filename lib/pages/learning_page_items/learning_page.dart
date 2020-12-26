import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/main_model.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_bloc.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_manage_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_repository.dart';
import 'package:allnatureforkids/pages/learning_page_items/swipe_learning_card_items/learning_card_widget.dart';
import 'package:allnatureforkids/shared/bloc/bloc_provider.dart';
import 'package:allnatureforkids/utils/alet_dialog_widgets.dart';
import 'package:allnatureforkids/widgets/background.dart';
import 'package:flutter/material.dart';
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
    learningPageManageModel = Provider.of<LearningPageManageModel>(context,listen: false);
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

            return Stack(
              children: [
                Positioned.fill(child: BackgroundWidget()),
                Positioned(
                  top: MediaQuery.of(context).size.height * 4 / 12,
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
                          data.currentIndex == 0 ? Container(width: 119,): GestureDetector(
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
                            )
                          ),
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
                          GestureDetector(
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
                    }
                  ),
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
