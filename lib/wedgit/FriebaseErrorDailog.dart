import 'package:flutter/material.dart';





class DailogError extends StatelessWidget {
  DailogError({this.text,this.titleText});
  final String text;
  final String titleText;
  @override
  Widget build(BuildContext context) {
    return           AlertDialog(
      title: Text(
        titleText,
        style:
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: Row(
        children: <Widget>[

          Text(
            text,
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: <Widget>[
        FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "ok",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
    ;
  }
}
