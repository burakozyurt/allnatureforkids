import 'dart:ui';

import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/colors.dart';
import 'package:allnatureforkids/main_model.dart';
import 'package:allnatureforkids/models/section_list_card_item_model.dart';
import 'package:allnatureforkids/pages/home_page_items/home_page_manage_model.dart';
import 'package:allnatureforkids/widgets/background.dart';
import 'package:allnatureforkids/widgets/sections_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainModel mainModel;
  HomePageManageModel homePageManageModel;
  ScrollController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController();

    //init();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
    mainModel = Provider.of<MainModel>(context);
    homePageManageModel = Provider.of<HomePageManageModel>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          Positioned.fill(child: BackgroundWidget()),
          Positioned(
            top: 0,
            left: 16,
            right: 16,
            bottom: 0,
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                controller: controller,
                physics: BouncingScrollPhysics(),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    ChangeNotifierProvider.value(
                        value: SectionListCardModel(
                            AppLocalizations.of(context).translate('fruits'), '', 'fruits'),
                        child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(
                        value: SectionListCardModel(
                            AppLocalizations.of(context).translate('vegetables'), '', 'vegetables'),
                        child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(
                        value: SectionListCardModel(
                            AppLocalizations.of(context).translate('seasons'), '', 'seasons'),
                        child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(
                        value: SectionListCardModel(
                            AppLocalizations.of(context).translate('mushrooms'), '', 'mushrooms',isLocked: true),
                        child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(
                        value: SectionListCardModel(
                            AppLocalizations.of(context).translate('fruits'), '', 'fruits',isLocked: true),
                        child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(
                        value: SectionListCardModel(
                            AppLocalizations.of(context).translate('vegetables'), '', 'vegetables',isLocked: true),
                        child: SectionListCardWidget()),
                    SizedBox(
                      height: ScreenUtil().setHeight(48),
                    ),
                  ],
                ),
              ),
            ),
          ),
          languageWidget()
        ],
      ),
    );
  }

  Widget languageWidget() {
    return Consumer<HomePageManageModel>(builder: (context, data, _) {
      if (data.isOpenLanguageWidget) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: ScreenUtil().setHeight(35 * 2),
          child: Stack(
            children: [
              Container(
                color: Colors.black45,
                child: ClipRRect(
                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          mainModel.preferredLanguageCode = 'en';
                          homePageManageModel.isOpenLanguageWidget = false;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'EN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(
                                  16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.white,),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          mainModel.preferredLanguageCode = 'tr';
                          homePageManageModel.isOpenLanguageWidget = false;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'TR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(
                                  16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        height: ScreenUtil().setHeight(30),
        child: GestureDetector(
          onTap: () {
            data.isOpenLanguageWidget = true;

          },
          child: Stack(
            children: [
              Container(
                color: Colors.black26,
                child: ClipRRect(
                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                      child: Text(
                        "",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      AppLocalizations.of(context).locale.languageCode.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(
                          16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
