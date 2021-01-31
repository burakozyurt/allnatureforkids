import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/models/quiz_data_model.dart';
import 'package:allnatureforkids/models/section_data_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_big_balloon_manage_model.dart';
import 'package:allnatureforkids/pages/quiz_page_items/quiz_page_manage_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizCardWidget extends StatelessWidget {
  QuizPageManageModel quizPageManageModel;
  QuizPageBalloonManageModel quizPageBalloonManageModel;
  QuizPageBigBalloonManageModel quizBigPageBalloonManageModel;
  @override
  Widget build(BuildContext context) {
    quizPageManageModel = Provider.of<QuizPageManageModel>(context, listen: false);
    quizPageBalloonManageModel = Provider.of<QuizPageBalloonManageModel>(context, listen: false);
    quizBigPageBalloonManageModel = Provider.of<QuizPageBigBalloonManageModel>(context, listen: false);
    quizPageManageModel.playQuestion(quizPageManageModel.currentQuizDataModel.answer, AppLocalizations.of(context).locale.languageCode);
    return Consumer<QuizPageManageModel>(builder: (context, data, _) {
      List<SectionDataModel> optionList = quizPageManageModel.currentQuizDataModel.optionList;
      QuizDataModel quizDataModel = quizPageManageModel.currentQuizDataModel;
      return GridView.builder(
        itemCount: quizPageManageModel.currentQuizDataModel.optionList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, childAspectRatio: 0.85),
        itemBuilder: (context, index) {
          return Consumer<QuizPageManageModel>(builder: (context, data, _) {
            return GestureDetector(
              onTap: () async {
                if(quizPageManageModel.onTapped == false){
                  quizPageManageModel.onTapped = true;
                  if (optionList[index].name == quizDataModel.answer.name) {
                    if(quizPageManageModel.correctList.length == 4 && quizPageManageModel.period == 0){
                      quizPageBalloonManageModel.riveName = '5';
                      Future.delayed(Duration(milliseconds: 1500)).then((value) {
                        quizPageBalloonManageModel.riveName = 'done';
                        Future.delayed(Duration(milliseconds: 500)).then((value) => quizBigPageBalloonManageModel.riveName = '1');
                      });
                    }else if(quizPageManageModel.correctList.length == 4 && quizPageManageModel.period == 1){
                      quizPageBalloonManageModel.riveName = '5';
                      Future.delayed(Duration(milliseconds: 1500)).then((value) {
                        quizPageBalloonManageModel.riveName = 'done';
                        Future.delayed(Duration(milliseconds: 500)).then((value) => quizBigPageBalloonManageModel.riveName = '2');

                      });
                    }else{
                      quizPageBalloonManageModel.riveName = (quizPageManageModel.correctList.length%5 + 1).toString();

                    }
                    quizPageManageModel.playCommon(AppLocalizations.of(context).locale.languageCode);
                    quizPageManageModel.correctVisibility = true;
                    await Future.delayed(Duration(milliseconds: 1000));
                    quizPageManageModel.correctVisibility = false;
                    quizPageManageModel.addCorrectAnswer(quizDataModel);
                    await Future.delayed(Duration(milliseconds: 500));
                    data.playQuestion(data.nextQuizDataModel.answer, AppLocalizations.of(context).locale.languageCode);
                    quizPageManageModel.onTapped = false;
                  } else if (quizPageManageModel.wrongAnswerItems.contains(index)) {
                    quizPageManageModel.playWrong(AppLocalizations.of(context).locale.languageCode);
                    quizPageManageModel.onTapped = false;
                  } else {
                    quizPageManageModel.playWrong(AppLocalizations.of(context).locale.languageCode);
                    await Future.delayed(Duration(milliseconds: 200));

                    quizPageManageModel.addWrongAnswer(index);
                    await Future.delayed(Duration(milliseconds: 500));
                    data.playQuestion(data.currentQuizDataModel.answer, AppLocalizations.of(context).locale.languageCode);
                    quizPageManageModel.onTapped = false;

                  }
                }else{
                  await Future.delayed(Duration(milliseconds: 500));
                  quizPageManageModel.onTapped = false;
                }

              },
              child: Transform.scale(
                scale:  quizPageManageModel.wrongAnswerItems.contains(index) == true ? 0.9 : 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Opacity(
                          opacity: quizPageManageModel.wrongAnswerItems.contains(index) == true ? 0.3 : 1,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage(optionList[index].photo),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (quizPageManageModel.correctVisibility && optionList[index].name == quizDataModel.answer.name)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Container()),
                      )
                    else if(quizPageManageModel.wrongAnswerItems.contains(index))
                      Container(),
                  ],
                ),
              ),
            );
          });
        },
      );
    });
  }
}
