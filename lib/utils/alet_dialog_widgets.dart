import 'package:allnatureforkids/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DialogPage{

  showSnackBar(BuildContext context, String content) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ThemeColor.anaRenk1,
        content: Text(
          content,
          style: TextStyle(fontSize: ScreenUtil().setSp(18)),
        ),
        duration: Duration(seconds: 2),
      ),
    );

  }
}