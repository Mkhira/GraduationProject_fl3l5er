import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:profile_screen/constants.dart';
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
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text(groupName,style: TextStyle(color: Colors.white)),
            children: <Widget>[
              ListTile(
                title: Text(firstText,style: TextStyle(color: Colors.white),),
                leading: Radio(
                  value:groupName == 'Gender' ?'Male':'Single',
                  groupValue: groupName == 'Gender' ? Provider
                      .of<InfoProvider>(context)
                      .gender : Provider
                      .of<InfoProvider>(context)
                      .status, //
                  onChanged: (String value) {
                    groupName == 'Gender' ? Provider
                        .of<InfoProvider>(context, listen: false)
                        .modifyGender = value : Provider
                        .of<InfoProvider>(context,listen: false)
                        .modifyStatus = value;
                  },
                ),
              ),
              ListTile(
                title: Text(secondText,style: TextStyle(color: Colors.white)),
                leading: Radio(
                  value: groupName == 'Gender' ?'Female':'Married',
                  groupValue: groupName == 'Gender' ? Provider
                      .of<InfoProvider>(context)
                      .gender : Provider
                      .of<InfoProvider>(context)
                      .status,
                  onChanged: (String value) {
                    groupName == 'Gender' ? Provider
                        .of<InfoProvider>(context, listen: false)
                        .modifyGender = value : Provider
                        .of<InfoProvider>(context,listen: false)
                        .modifyStatus=value;
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
