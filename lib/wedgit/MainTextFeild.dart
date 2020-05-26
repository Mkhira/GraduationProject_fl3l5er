




import 'package:company_task/style/constent.dart';
import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final Stream textStream;
  final Function textChange;
  final String hintText;
  final TextInputType inputType;
  final bool obscure;
  final bool enable;
  final Widget widget;
  final double width;
  const MainTextField(
      {this.textStream,
        this.textChange,
        this.hintText,
        this.inputType,
        this.obscure = false, this.widget, this.width, this.enable=true,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Mainfeild(),
    );
  }


  Widget Mainfeild ( ){

    return
      StreamBuilder(
      stream: textStream,
      builder: (context, snapshot) {
        return TextField(
           enabled: enable,
          onChanged: textChange,
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.white,
          autofocus: false,
          keyboardType: inputType,
          obscureText: obscure,
          decoration: InputDecoration(
            errorText: snapshot.error,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kSecondColor,width: 5),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: 5),
            ),
            labelText: "$hintText",
            hintText: " $hintText",
            hintStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

}
