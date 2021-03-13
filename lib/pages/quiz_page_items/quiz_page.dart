import 'package:allnatureforkids/colors.dart';
import 'package:allnatureforkids/models/quiz_data_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_card_items/quiz_card_widget.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_bloc.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/rive_balloon.dart';
import 'package:allnatureforkids/pages/quiz_page_items/rive_big_balloon.dart';
import 'package:allnatureforkids/pages/quiz_page_items/rive_bomb_items/rive_bomb_game_screen.dart';
import 'package:allnatureforkids/shared/bloc/bloc_provider.dart';
import 'package:allnatureforkids/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatelessWidget {
  String sectionName;

  QuizPage(this.sectionName);

  QuizPageBloc quizPageBloc;
  QuizPageManageModel quizPageManageModel;
  QuizPageBalloonManageModel quizPageBalloonManageModel;
  @override
  Widget build(BuildContext context) {
    quizPageBloc = BlocProvider.of<QuizPageBloc>(context);
    quizPageManageModel = Provider.of<QuizPageManageModel>(context,listen: false);
    quizPageBalloonManageModel = Provider.of<QuizPageBalloonManageModel>(context,listen: false);
    quizPageBloc.fetchAllData(sectionName,length: 10);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: quizPageBloc.quizDataModelListStream,
        builder: (context, AsyncSnapshot<List<QuizDataModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              children: [
                Positioned.fill(child: BackgroundWidget()),
              ],
            );
          }
          if (snapshot.data == null) {
            return Stack(
              children: [
                Positioned.fill(child: BackgroundWidget()),
              ],
            );
          }
          List<QuizDataModel> quizDataModel = snapshot.data;
          quizPageManageModel.fetchData(quizDataModel);
          return Stack(
            children: [
              Positioned.fill(child: BackgroundWidget()),
              //RiveGameInitial(isBackground: true,),
              Positioned(
                  top: 0,
                  right: 16,
                  left: 16,
                  height: MediaQuery.of(context).size.height * 2 / 12,
                  child: Stack(
                    children: [
                    Positioned.fill(child: ChangeNotifierProvider.value(value:quizPageManageModel,child: RiveBigBalloon())),
                    ],
                  )),
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
                              padding: const EdgeInsets.only(left: 10, right: 7, top: 12, bottom: 14),
                              child: Image(
                                width: ScreenUtil().setWidth(32),
                                image: AssetImage('assets/environment/learning_items/back.png'),
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
                          child: ListView(
                            children: [
                              Text(''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height * 2 / 12,
                  right: 16,
                  left: 16,
                  height: MediaQuery.of(context).size.height * 2 / 12,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: ChangeNotifierProvider.value(value:quizPageManageModel,child: RiveBalloon()),
                      ),
                    ],
                  )),
              quizBackgroundItem(context),
              Positioned(
                top: MediaQuery.of(context).size.height * 4 / 12 + 16,
                right: 16,
                left: 16,
                height: MediaQuery.of(context).size.height * 6.5 / 12,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white24,
                        blurRadius: 0.2,
                        spreadRadius: 0.0,
                        offset: Offset(0.0, 0.0), // shadow direction: bottom right
                      ),
                    ],
                  ),
                  child: ChangeNotifierProvider.value(value:quizPageBalloonManageModel,child: ChangeNotifierProvider.value(value: quizPageManageModel,child: QuizCardWidget(),)),
                ),
              ),
              /*RiveBombGame()*/
              Consumer<QuizPageManageModel>(
                builder: (context,data,_){
                  if(data.correctList.length ==1 && data.period == 0){
                    return RiveGameInitial();
                  }else{
                    return Container();
                  }
                },
              )
            ],
          );
        }
      ),
    );
  }

  Widget quizBackgroundItem(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 4 / 12 + 16,
          right: 16,
          left: 16,
          height: MediaQuery.of(context).size.height * 6.5 / 12,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 0.2,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0), // shadow direction: bottom right
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 4 / 12 + 16,
          right: 16,
          left: 16,
          height: MediaQuery.of(context).size.height * 6.5 / 12 + 16,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 0.2,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0), // shadow direction: bottom right
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 4 / 12 + 16,
          right: 16,
          left: 16,
          height: MediaQuery.of(context).size.height * 6.5 / 12 + 32,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 0.2,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.0), // shadow direction: bottom right
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
