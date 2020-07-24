import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RadioGroup extends StatelessWidget {
  final String groupName, firstText, secondText;

  RadioGroup({this.groupName, this.firstText, this.secondText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Theme(
          data: ThemeData(
            unselectedWidgetColor: Colors.white,
            accentColor: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0,12.0,0.0,5.0),
                child: Text(
                  groupName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  firstText,
                  style: TextStyle(color: Colors.white),
                ),
                leading: Radio(
                  value: 'Single',
                  groupValue: Provider.of<InfoProvider>(context).status,
                  onChanged: (String value) {
                    Provider.of<InfoProvider>(context, listen: false)
                        .modifyStatus = value;
                  },
                ),
              ),
              ListTile(
                title: Text(secondText, style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: 'Married',
                  groupValue: Provider.of<InfoProvider>(context).status,
                  onChanged: (String value) {
                    Provider.of<InfoProvider>(context, listen: false)
                        .modifyStatus = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
