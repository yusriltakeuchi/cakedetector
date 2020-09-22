import 'package:cakedetector/ui/constant/constant.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  Color color;
  Color textColor;
  String title;
  Function onClick;
  double fontSize;
  bool useBold;
  bool onlyRadiusBottom;
  PrimaryButton({
    @required this.color,
    @required this.title,
    @required this.onClick,
    this.textColor = Colors.white,
    this.fontSize = 45,
    this.useBold = true,
    this.onlyRadiusBottom = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(),
      height: 45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(onlyRadiusBottom ? 0 : 5),
          topRight: Radius.circular(onlyRadiusBottom ? 0 : 5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)
        ),
      ),      
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(onlyRadiusBottom ? 0 : 5),
            topRight: Radius.circular(onlyRadiusBottom ? 0 : 5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)
          ),
          onTap: () => onClick != null ? onClick() : {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: useBold
                ? styleTitle.copyWith(color: textColor, fontSize: setFontSize(fontSize))
                : styleSubtitle.copyWith(color: textColor, fontSize: setFontSize(fontSize)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
