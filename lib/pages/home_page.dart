import 'package:allnatureforkids/app_localizations.dart';
import 'package:allnatureforkids/models/section_list_card_item_model.dart';
import 'package:allnatureforkids/widgets/background.dart';
import 'package:allnatureforkids/widgets/sections_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init();

  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
    return Scaffold(
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
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChangeNotifierProvider.value(value:SectionListCardModel(AppLocalizations.of(context).translate('fruits'),'','fruits'),child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(value:SectionListCardModel(AppLocalizations.of(context).translate('vegetables'),'','vegetables'),child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(value:SectionListCardModel(AppLocalizations.of(context).translate('seasons'),'','seasons'),child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(value:SectionListCardModel(AppLocalizations.of(context).translate('mushrooms'),'','mushrooms'),child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(value:SectionListCardModel(AppLocalizations.of(context).translate('fruits'),'','fruits'),child: SectionListCardWidget()),
                    ChangeNotifierProvider.value(value:SectionListCardModel(AppLocalizations.of(context).translate('vegetables'),'','vegetables'),child: SectionListCardWidget()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
