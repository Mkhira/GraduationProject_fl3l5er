import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/taskData.dart';
import '../style/conist.dart';

class radioButtonMarital extends StatelessWidget {
  final int value;
  final String content;

  radioButtonMarital({this.content, this.value});
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 140,
      child: RadioListTile(
        value: value,
        dense: true,

        groupValue: Provider.of<TaskData>(context).selcetedStatus,
        title: Text(
          content,
          style: kradioButton,
        ),
        onChanged: (val) {
          Provider.of<TaskData>(context).selectedMaritalStatus(val);
        },
        activeColor: Colors.green,
      ),
    );
  }
}

class radioButtonJop extends StatelessWidget {
  final int value;
  final String content;

  radioButtonJop({this.content, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: RadioListTile(
        value: value,
        groupValue: Provider.of<TaskData>(context).selcetedJop,
        title: Text(
          content,
          style: kradioButton,
        ),
        onChanged: (vale) {
          Provider.of<TaskData>(context).selectedJop(vale);
        },
        activeColor: Colors.green,
      ),
    );
  }
}

class radioButtonGender extends StatelessWidget {
  final int value;
  final String content;

  radioButtonGender({this.content, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: RadioListTile(
        value: value,
        groupValue: Provider.of<TaskData>(context).selcetedGender,
        title: Text(
          content,
          style: kradioButton,
        ),
        onChanged: (value) {
          Provider.of<TaskData>(context).selectedGender(value);
        },
        activeColor: Colors.green,
      ),
    );
  }
}
