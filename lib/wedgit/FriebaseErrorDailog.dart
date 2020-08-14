import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class DailogError extends StatelessWidget {
  DailogError({this.text,this.titleText});
  final String text;
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return           AlertDialog(
      backgroundColor: kMainColor,
      title: Text(
        titleText,
        style:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
      ),
      content: Row(
        children: <Widget>[

          Text(
            text,
            style: TextStyle(
                color: kSecondColor, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
          ),
        ],
      ),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        ButtonWidget(text: "ok",color: kSecondColor,height: 30,onPressed: (){
          Navigator.pop(context);

        },
        borderColor: kSecondColor,
          textColor: Colors.white,
        )
      ],
    );
    ;
  }
}
class DailogErrorimage extends StatelessWidget {
  DailogErrorimage({this.text,this.titleText});
  final String text;
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return           AlertDialog(
      backgroundColor: kMainColor,
      title: Text(
        titleText,
        style:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
      ),
      content: Row(
        children: <Widget>[

          Text(
            text,
            style: TextStyle(
                color: kSecondColor, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
          ),
        ],
      ),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        ButtonWidget(text: "ok",color: kSecondColor,height: 30,onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);

        },
          borderColor: kSecondColor,
          textColor: Colors.white,
        )
      ],
    );
    ;
  }
}



class customError extends StatelessWidget {
  customError({this.text,this.titleText,this.onPressed});
  final String text;
  final String titleText;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return           AlertDialog(
      backgroundColor: kMainColor,
      title: Text(
        titleText,
        style:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
      ),
      content: Row(
        children: <Widget>[

          Text(
            text,
            style: TextStyle(
                color: kSecondColor, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),
          ),
        ],
      ),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        ButtonWidget(text: "ok",color: kSecondColor,height: 30,
          onPressed:
              onPressed,
          borderColor: kSecondColor,
          textColor: Colors.white,
        )
      ],
    );
    ;
  }
}