import 'package:flutter/material.dart';
import 'rigisterWedgit.dart';
import '../Block/Block.dart';
import '../style/conist.dart';
import 'RadioButtons.dart';
import 'DateButton.dart';

class LocationContiner extends StatelessWidget {
  const LocationContiner({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: ExpansionTile(title: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5),
        child: Text("Location Data", style: Data),
      ),children: <Widget>[
        SizedBox(
          height: 20,
        ),
        RowText(
          text: "Country",
          feild: countryField(bloc),
        ),
        SizedBox(
          height: 20,
        ),
        RowText(
          text: "Governate",
          feild: governateField(bloc),
        ),
        SizedBox(
          height: 20,
        ),
        RowText(
          text: "City",
          feild: cityField(bloc),
        ),
        SizedBox(
          height: 20,
        ),
        RowText(
          text: "Street",
          feild: streetField(bloc),
        ),
        SizedBox(
          height: 30,
        ),

      ],)
    );
  }
}
class jopContainer extends StatelessWidget {
  const jopContainer({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: ExpansionTile(title:
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 5),
        child: Text("Jop Data", style: Data),
      ), children: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            radioButtonJop(
              value: 4,
              content: "Work",
            ),
            radioButtonJop(
              value: 5,
              content: "jobless",
            ),
          ],
        ),
        RowText(
          text: "Salary",
          feild: salaryField(bloc),
        ),
        SizedBox(height: 25)
      ],)
    );
  }
}

class maritalStatusContainer extends StatelessWidget {
  const maritalStatusContainer({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: ExpansionTile(title: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5),
        child: Text("Matirial Status Data", style: Data),
      ),children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            radioButtonMarital(
              content: "Married",
              value: 1,
            ),
            radioButtonMarital(
              content: "Single",
              value: 2,
            ),
          ],
        ),
        radioButtonMarital(
          content: "Divorced",
          value: 3,
        ),
        RowText(
          text: "Kids Num",
          feild: kidsField(bloc),
        ),
        SizedBox(
          height: 25,
        ),
      ],)
    );
  }
}

class PasswordContainer extends StatelessWidget {
  const PasswordContainer({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Text("Password Data", style: Data),
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
              feild: passwordField(bloc),
              text: "Password",
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
                text: "Con Password",
                feild: confirmPasswordField(bloc)),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailContainer extends StatelessWidget {
  const EmailContainer({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final Bloc bloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Text("Email Data", style: Data),
            ),
            SizedBox(
              height: 10,
            ),
            RowText(
              feild: emailField(bloc),
              text: "Email",
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
              text: "Fisr Name",
              feild: firstNameField(bloc),
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
              text: "Last Name",
              feild: lastNameField(bloc),
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
              text: "Nick Name",
              feild: nickEamilField(bloc),
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
              text: "Card Id",
              feild: cardIdField(bloc),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width/1.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Spacer(flex: 1,),
                  Text("Date:"),
                  Spacer(),
                  DateButton(),

                  SizedBox(width: 25,),

                ],
              ),
            ),

            SizedBox(
              height: 0,
            ),
            Row(
              children: <Widget>[
                radioButtonGender(
                  value: 6,
                  content: "Male",
                ),
                radioButtonGender(
                  value: 7,
                  content: "Femail",
                ),
              ],
            ),
            RowText(
              text: "Phone",
              feild: phoneField(bloc),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

