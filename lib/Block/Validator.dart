import 'dart:async';

class Validator {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        bool regExp =  RegExp(pattern).hasMatch(email);
    if (regExp == true ) {
      sink.add(email);
    } else {
      sink.addError("Wrong Email Type");
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(


      handleData: (password, sink) {

        Pattern pattern =r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';


    if (password.length >=8) {
      sink.add(password);
    } else {
      sink.addError("Password should not less than 8");
    }
  });

  final validateConfirmPassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.length >= 8 ) {
      sink.add(password);
    } else {
      sink.addError("Password should not less than 8");
    }
  });

  final validateFirstName = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
    if (firstName.contains(RegExp(r'^[a-z-0-9_\-=@,\.;]+$'))!=true||  firstName.contains("-")== true || firstName.contains(";") ==true && firstName.contains(",")==true || firstName.contains("@")==true|| firstName.contains("=")==true || firstName.contains("_")== true) {
      sink.addError("Un valid  characters ");
    } else {
      sink.add(firstName);
    }
  });
  final validateStrng = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastName, sink) {
        if (lastName.contains(RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$'))!=true) {
          sink.addError("Un valid  characters ");
        } else {
          sink.add(lastName);
        }
      });

  final phone = StreamTransformer<String, String>.fromHandlers(
      handleData: (phone, sink) {
        if (phone.length==11) {
          sink.addError("phone is only 11 numper");
        } else {
          sink.add(phone);
        }
      });


}
