import 'package:flutter/material.dart';
import '../Block/Block.dart';
import 'package:provider/provider.dart';
import '../provider/taskData.dart';


class RowText extends StatelessWidget {
  final Widget feild;
  final String text;
  RowText({this.text, this.feild});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),

        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),

              )),
          child: Row(
            children: <Widget>[
              Spacer(flex: 1),  Text("$text:",style: TextStyle(fontSize: 11),),
              Spacer(
                flex: 1,
              ),
              Container(width: 240, child: feild),
              SizedBox(width: 30,)
            ],
          ),
        ),
      ),
    );
  }
}

Widget emailField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (context, snapshot) {
      return
        TextField(
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        onChanged: bloc.emailChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Enter Email example@.com",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}

Widget firstNameField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.firstNameStream,
    builder: (context, snapshot) {
      return
        TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.firstNameChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Enter your First Name",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}
Widget lastNameField(Bloc bloc) {
  return
    StreamBuilder(
    stream: bloc.lastNameStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.lastNameChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Enter your Last Name",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget cardIdField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.cardIdStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.number,
        obscureText: false,
        onChanged: bloc.cardIdChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Card Id",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget salaryField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.salaryStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.number,
        obscureText: false,
        onChanged: bloc.salaryChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Salary",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget nickEamilField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.nickNameStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.nickNameChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Enter your nickName",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}

Widget phoneField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.phoneStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.number,
        obscureText: false,
        onChanged: bloc.phoneChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Phone",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget kidsField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.numKidsStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.number,
        obscureText: false,
        onChanged: bloc.numKidsChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Kids Num",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget passwordField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: bloc.passwordChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Enter your Password",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}
Widget confirmPasswordField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.confirmPasswordStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
        onChanged: bloc.confirmPasswordChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Confirm your Password",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}



Widget countryField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.countryStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.countryChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Your Country",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget governateField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.governateStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.governateChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Your Governate",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}
Widget cityField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.cityStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.cityChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Your City",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}


Widget streetField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.streetStream,
    builder: (context, snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        obscureText: false,
        onChanged: bloc.streetChange,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          hintText: "Your Street",
//          labelText: "Enter ur email",
          errorText: snapshot.error,
        ),
      );
    },
  );
}