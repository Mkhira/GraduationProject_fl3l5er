import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class MyMainTextField extends StatelessWidget {
  final Stream textStream;
  final Function textChange;
  final String hintText;
  String labelText;
  final TextInputType inputType;
  final bool enable;
  final Widget widget;
  final double width;
  final double height;
  final bool obscure;
  FocusNode focusNode = FocusNode();
  TextEditingController inputController=TextEditingController();

  MyMainTextField({
    this.textStream,
    this.textChange,
    this.hintText,
    this.labelText,
    this.inputType,
    this.widget,
    this.width,
    this.enable = true,
    this.obscure = false,
    this.focusNode,
    this.inputController,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: mainField(),
    );
  }

  Widget mainField() {
    return StreamBuilder(
      stream: textStream,
      builder: (context, snapshot) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            textInputAction: TextInputAction.next,
            enabled: enable,
            onChanged: textChange,
            controller: inputController,
            focusNode: focusNode,
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.white,
            autofocus: false,
            keyboardType: inputType,
            obscureText: obscure,
            decoration: InputDecoration(
              suffixIcon: widget,
              contentPadding:
              EdgeInsets.symmetric(vertical: height, horizontal: 15.0),
              errorText: snapshot.error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: "$labelText",
              hintText: " $hintText",
              hintStyle: TextStyle(
                fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                color: kSecondColor,
                fontWeight: FontWeight.bold,
              ),
              labelStyle:
              TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),
              //isDense: true,
            ),
          ),
        );
      },
    );
  }
}


class MyMainTextFieldForm extends StatelessWidget {
  final Stream textStream;
  final Function textChange;
  final String hintText;
  String labelText;
  final TextInputType inputType;
  final bool enable;
  final Widget widget;
  final double width;
  final double height;
  final bool obscure;
  final Function val;
  FocusNode focusNode = FocusNode();
  TextEditingController inputController=TextEditingController();

  MyMainTextFieldForm({
    this.val,
    this.textStream,
    this.textChange,
    this.hintText,
    this.labelText,
    this.inputType,
    this.widget,
    this.width,
    this.enable = true,
    this.obscure = false,
    this.focusNode,
    this.inputController,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: mainField(),
    );
  }

  Widget mainField() {
    return StreamBuilder(
      stream: textStream,
      builder: (context, snapshot) {
        return Directionality(

          textDirection: TextDirection.rtl,
          child: TextFormField(
            validator: val,
            enabled: enable,
            onChanged: textChange,
            controller: inputController,
            focusNode: focusNode,
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.white,
            autofocus: false,
            keyboardType: inputType,
            obscureText: obscure,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              suffixIcon: widget,
              contentPadding:
              EdgeInsets.symmetric(vertical: height, horizontal: 15.0),
              errorText: snapshot.error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: "$labelText",
              hintText: " $hintText",
              hintStyle: TextStyle(
                fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                color: kSecondColor,
                fontWeight: FontWeight.bold,
              ),
              labelStyle:
              TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),
              //isDense: true,
            ),
          ),
        );
      },
    );
  }
}



class MyMainTextFieldLocation extends StatelessWidget {
  final Stream textStream;
  final Function textChange;
  final String hintText;
  String labelText;
  final TextInputType inputType;
  final bool enable;
  final Widget widget;
  final double width;
  final double height;
  final bool obscure;
  FocusNode focusNode = FocusNode();
  TextEditingController inputController=TextEditingController();

  MyMainTextFieldLocation({
    this.textStream,
    this.textChange,
    this.hintText,
    this.labelText,
    this.inputType,
    this.widget,
    this.width,
    this.enable = true,
    this.obscure = false,
    this.focusNode,
    this.inputController,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: mainField(),
    );
  }

  Widget mainField() {
    return StreamBuilder(
      stream: textStream,
      builder: (context, snapshot) {
        return
          TextField(
            textInputAction: TextInputAction.next,
            enabled: enable,
            onChanged: textChange,
            controller: inputController,
            focusNode: focusNode,
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.white,
            autofocus: false,
            keyboardType: inputType,
            obscureText: obscure,
            decoration: InputDecoration(
              suffixIcon: widget,
              contentPadding:
              EdgeInsets.symmetric(vertical: height, horizontal: 5.0),
              errorText: snapshot.error,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: "$labelText",
              hintText: " $hintText",
              hintStyle: TextStyle(
                fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                color: kSecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 10
              ),
              labelStyle:
              TextStyle(  fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',),
              //isDense: true,
            ),

        );
      },
    );
  }
}