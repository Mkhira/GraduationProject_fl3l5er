import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/taskData.dart';
import '../style/conist.dart';
import '../Block/Block.dart';
class textField extends StatelessWidget {
  final TextInputType textInputType;
  final bool obscureText;
  final bool enable;
  final TextInputAction textInputAction;
  final String hintText;
  final String labelText;
 final TextEditingController textEditingController;
  final Function validate;
    final Function onnchange;
  textField(
      {this.textInputType,
      this.hintText,
      this.labelText,
      this.obscureText,
      this.enable = true,
      this.textInputAction,this.textEditingController,this.validate,this.onnchange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        child: TextFormField(
          validator: validate ,
          controller: textEditingController,
          textInputAction: textInputAction,
          onFieldSubmitted: (term) {
            FocusScope.of(context).requestFocus();
          },
          keyboardType: textInputType,
          obscureText: obscureText,
          enabled: enable,
          onChanged: onnchange,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(
//              borderSide: const BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




