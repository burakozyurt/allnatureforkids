import 'dart:async';
import 'dart:ui';

import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/colors.dart';
import 'package:allnatureforkids/locator.dart';
import 'package:allnatureforkids/models/section_list_card_item_model.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_bloc.dart';
import 'package:allnatureforkids/pages/learning_page_items/learning_page_manage_model.dart';
import 'package:allnatureforkids/shared/bloc/bloc_provider.dart';
import 'package:allnatureforkids/sound_manager/sound_manager.dart';
import 'package:allnatureforkids/utils/alet_dialog_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SectionListCardWidget extends StatelessWidget {
  SectionListCardModel sectionListCardModel;
  LearningPageManageModel learningPageManageModel = LearningPageManageModel();
  @override
  Widget build(BuildContext context) {
    sectionListCardModel = Provider.of<SectionListCardModel>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapCancel: () {
          if (sectionListCardModel.isLocked) {
            DialogPage().showSnackBar(context, AppLocalizations.of(context).translate('hold_five_second'));
          }
          sectionListCardModel.pressDetails('CANCEL');
        },
        onTapDown: (details) {
          sectionListCardModel.pressDetails('DOWN');
        },
        onTapUp: (details) {
          if (sectionListCardModel.isLocked) {
            DialogPage().showSnackBar(context, AppLocalizations.of(context).translate('hold_five_second'));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  bloc: LearningPageBloc(),
                  child: ChangeNotifierProvider.value(
                    value:LearningPageManageModel(),
                    child: LearningPage(),
                  ),
                ),
              ),
            );
          }
          sectionListCardModel.pressDetails('UP');
        },
        onLongPress: () {
          if (sectionListCardModel.isLocked) {
            sectionListCardModel.isLongPressTimerOpen = true;
            Timer.periodic(Duration(seconds: 1), (timer) {
              if (timer.tick > 1) {
                getIt.get<SoundManager>().playClockTick();
              }
              if (!sectionListCardModel.isLongPressTimerOpen) {
                timer.cancel();
              } else if (timer.tick > 5) {
                sectionListCardModel.pressDetails('LP_START');
                timer.cancel();
              }
              print(timer.tick);
            });
          }
          sectionListCardModel.pressDetails('LP_START');
        },
        onLongPressEnd: (details) async {
          if (sectionListCardModel.isLocked) {
            sectionListCardModel.isLongPressTimerOpen = false;
          }
          sectionListCardModel.pressDetails('LP_END');
        },
        child: AspectRatio(
          aspectRatio: 2,
          child: Container(child: Consumer<SectionListCardModel>(builder: (context, data, _) {
            return Transform.scale(
              scale: sectionListCardModel.scale,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white30,
                            blurRadius: 0.2,
                            spreadRadius: 0.0,
                            offset: Offset(-4.0, -12.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Image(image: AssetImage('assets/environment/section_backgrounds/background.png')),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 16,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              Center(
                                child: Image(
                                  image: AssetImage(
                                      'assets/sections/${sectionListCardModel.sectionIdName}/images/cover.png'),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                              data.isLocked == true ? LockedWidget() : Container(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  sectionListCardModel.sectionName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColor.yaziAra,
                                    fontSize: ScreenUtil().setSp(
                                      18,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Image(
                                  image: AssetImage('assets/environment/section_backgrounds/play_button.png'),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}

class BlurWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        child: ClipRRect(
          // make sure we apply clip it properly
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(alignment: Alignment.center, color: Colors.white24, child: Container()),
          ),
        ),
      ),
    );
  }
}

class LockedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurWidget(),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              image: AssetImage('assets/environment/section_backgrounds/locked_icon.png'),
              filterQuality: FilterQuality.low,
            ),
          ),
        ),
      ],
    );
  }
}
