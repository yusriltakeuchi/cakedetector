import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// --------------
/// Constant Color
/// --------------
Color primaryColor = Color(0xff00D070);
Color lightPrimaryColor = Color(0xff00B28B);
Color blackColor = Color(0xff666666);
Color grayColor = Color(0xff999999);
Color graySoftColor = Color(0xffF6F6F6);

/// --------------
/// Asset Location
/// --------------
/// Example: $iconAsset/logo.svg
String iconAsset = "assets/icons";
String imageAsset = "assets/images";
String modelAsset = "assets/models";
String modelPath = "$modelAsset/cake_model.tflite";
String labelPath = "$modelAsset/labels.txt";

/// ------------
/// Device Size
/// ------------
double deviceWidth() => ScreenUtil.screenWidth;
double deviceHeight() => ScreenUtil.screenHeight;

/// ----------------
/// Status Bar Color
/// ----------------
void setStatusBar({Brightness brightness = Brightness.dark}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: brightness));
}

/// ----------------------------------- 
/// Font and size scaling screen utils
/// ----------------------------------- 
/// Initialize screen util
void setupScreenUtil(BuildContext context) 
  => ScreenUtil.init(context, allowFontScaling: true);

/// Setting height and width 
double setWidth(double width) => ScreenUtil().setWidth(width);
double setHeight(double height) => ScreenUtil().setHeight(height);

/// Setting fontsize
double setFontSize(double size)  => ScreenUtil().setSp(size, allowFontScalingSelf: true);

/// ----------------------------------- 
/// Constant Base Text Styling
/// ----------------------------------- 
TextStyle styleHeader = TextStyle(
  fontSize: setFontSize(50),
  color: blackColor,
  fontWeight: FontWeight.w700
);

TextStyle styleHeadLine = TextStyle(
  fontSize: setFontSize(44),
  color: blackColor,
);

TextStyle styleTitle = TextStyle(
  fontSize: setFontSize(36),
  color: blackColor,
  fontWeight: FontWeight.w700
);

TextStyle stylePrice = TextStyle(
  fontSize: setFontSize(34),
  color: grayColor.withOpacity(0.7),
  fontWeight: FontWeight.w700
);

TextStyle styleSubtitle = TextStyle(
  fontSize: setFontSize(32),
  color: blackColor
);

TextStyle styleCategory = TextStyle(
  fontSize: setFontSize(32),
  color: blackColor,
  fontWeight: FontWeight.w700
);

TextStyle styleCaption = TextStyle(
  fontSize: setFontSize(31),
  color: blackColor
);