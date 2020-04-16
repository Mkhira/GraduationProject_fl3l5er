import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:provider/provider.dart';
import '../provider/taskData.dart';
import '../Block/Block.dart';
class DateButton extends StatefulWidget {
  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  final bloc = Bloc();
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dateField(bloc),

          Row(
            children: <Widget>[
              Spacer(flex: 1,),
              RaisedButton(

                  elevation: 4,
                  color: Colors.blueAccent,
                  child: Text("Date",style: TextStyle(color: Colors.white),),
                  onPressed: () {

                    showDatePicker(context: context,     initialDate: DateTime(DateTime.now().year - 30),
                      firstDate: DateTime(DateTime.now().year - 70),
                      lastDate: DateTime(DateTime.now().year + 1),
                    ).then((date){
                      setState(() {
                        _dateTime = date;

                      });
                    });



                  }),

            ],
          )

      ],
      ),
    );

  }
  Widget dateField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.dateStream,
      builder: (context, snapshot) {
        TextEditingController Textdate = TextEditingController(text: "$_dateTime");

        return TextField(

        controller: Textdate ,
          enabled: false,
          keyboardType: TextInputType.text,
          obscureText: false,
          onChanged: bloc.dateChange ,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            hintText: "Your Date",
//          labelText: "Enter ur email",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

}

