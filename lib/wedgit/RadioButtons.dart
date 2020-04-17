import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/info_provider.dart';
import '../style/constent.dart';

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

        groupValue: Provider.of<InfoProvider>(context).selcetedStatus,
        title: Text(
          content,
          style: kRadioButton,
        ),
        onChanged: (val) {
          Provider.of<InfoProvider>(context).selectedMaritalStatus(val);
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
        groupValue: Provider.of<InfoProvider>(context).selcetedJop,
        title: Text(
          content,
          style: kRadioButton,
        ),
        onChanged: (vale) {
          Provider.of<InfoProvider>(context).selectedJop(vale);
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
        groupValue: Provider.of<InfoProvider>(context).selcetedGender,
        title: Text(
          content,
          style: kRadioButton,
        ),
        onChanged: (value) {
          Provider.of<InfoProvider>(context).selectedGender(value);
        },
        activeColor: Colors.green,
      ),
    );
  }
}
