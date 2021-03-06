



import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/SignUpLoginProvider/LoginProvider.dart';
import 'file:///E:/flater_projects/company_task/lib/provider/SignUpLoginProvider/FireBaseAuth.dart';
import 'package:company_task/service/LoginService.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:company_task/wedgit/Steppers/stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';


enum AuthMode{signUp,Login}
class LoginMainScreen extends StatefulWidget {
  static const String id = 'LogInMainScreen';

  @override
  _LoginMainScreenState createState() => _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future restPassword(String email){

    return auth.sendPasswordResetEmail(email: email).whenComplete(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return customError(
              text: "تم ارسال رساله ",
              titleText: " شكرا لك ",
              onPressed: (){

                Provider.of<LoginProvider>(context).resetEmail.value = null;
                Provider.of<LoginProvider>(context).resetEmailController.text = null;

                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          });
     }
    ).catchError((onError){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return customError(
              text: "${onError.code}",
              titleText: "هنالك خطأ ",
              onPressed: (){
                Provider.of<LoginProvider>(context).resetEmail.value = null;
                Provider.of<LoginProvider>(context).resetEmailController.text = null;
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          });

    });

  }
  String _animationType = 'idle';
  bool _obscure = true;
  IconData _icon = Icons.visibility_off;
  final _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;
   User _user = User();
  String email = 'admin';
  String pass = 'admin';

  void _toggle() {
    setState(() {
      _obscure = !_obscure;
      _icon =
      _icon == Icons.visibility ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  void initState() {

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context,listen: false);
    initializeCurrentUser(authNotifier,context);
//    signOut(authNotifier);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _animationType = 'test';
        });
      } else {
        setState(() {
          _animationType = 'idle';
        });
      }
    });
    super.initState();
  }


  void _submitForm(BuildContext context)async {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(
        context, listen: false);
    login(Provider
        .of<LoginProvider>(context)
        .emailController
        .text, Provider
        .of<LoginProvider>(context)
        .passwordController
        .text, authNotifier,context);

//    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


//
//    firebaseAuth.onAuthStateChanged
//        .firstWhere((user) => user != null)
//        .then((user) {
//      String user_Name = user.displayName;
//      String image_Url = user.photoUrl;
//      String email_Id = user.email;
//      String user_Uuid = user.uid; // etc
//
//      print(user_Name);
//      print(user_Uuid);
//      print(email_Id);
//    });



  }
  @override
  Widget build(BuildContext context) {
    var loginProviderObj = Provider.of<LoginProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 20.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                        color: kSecondColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 280.0,
                      height: 280.0,
                      child: CircleAvatar(
                        child: ClipOval(
                          child: FlareActor(
                            'assets/teddy_test.flr',
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            animation: _animationType,
                          ),
                        ),
                        // backgroundColor: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MyMainTextField(
                      inputController: loginProviderObj.emailController ,
                      height: 13.0,
                      hintText: 'الايميل',
                      labelText: 'الايميل',
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    MyMainTextField(

                      height: 13.0,
                      hintText: 'كلمة المرور',
                      labelText: 'كلمة المرور',
                      obscure: _obscure,
                      inputController: loginProviderObj.passwordController,
                      focusNode: _focusNode,
                      widget: IconButton(
                        icon: Icon(
                          _icon,
                          color: Colors.grey,
                        ),
                        onPressed: _toggle,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Container(
                      width: 200.0,
                      child: RaisedButton(
                        padding: EdgeInsets.all(4.0),
                        color: Colors.orange,
                        onPressed: () {
                          //todo compareto(value from firebase auth)
//                          if (_passwordController.text.compareTo(pass) == 0) {
//                            setState(() {
//                              _animationType = 'success';
//                            });
//                            Navigator.pushNamed(context, HomePage.id);
//                          } else {
//                            setState(() {
//                              _animationType = 'fail';
//                            });
//                          }
//                        Navigator.push(context, MaterialPageRoute(builder: (context){
//                          return HomePage();
//                        }));

                       setState(() {
                         loginProviderObj.loginn(context);
                         _submitForm(context);
                       });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: 200.0,
                      child: RaisedButton(
                        padding: EdgeInsets.all(4.0),
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyStepper()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'انشاء حساب',
                          style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            color: Colors.white,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            'اضغط هنا',
                            style: TextStyle(
                              fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 18.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ResetPassword(
                                      onPressed: (){
                                        if(Provider.of<LoginProvider>(context).resetEmailController.text != null ){
                                          restPassword(loginProviderObj.resetEmailController.text);

                                        }else{
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return customError(
                                                  text: "تم ارسال رساله ",
                                                  titleText: " شكرا لك ",
                                                  onPressed: (){

                                                    Provider.of<LoginProvider>(context).resetEmail.value = null;
                                                    Provider.of<LoginProvider>(context).resetEmailController.text = null;

                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              });

                                        }
                                      },
                                    );
                                  });
                            });
                          },
                        ),
                        Text(
                          'اذا نسيت كلمة المرور',
                          style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
