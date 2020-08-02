



import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/OurTextFeilds/MyMainTextField.dart';
import 'package:company_task/wedgit/Steppers/stepper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class LoginMainScreen extends StatefulWidget {
  static const String id = 'LogInMainScreen';

  @override
  _LoginMainScreenState createState() => _LoginMainScreenState();
}

class _LoginMainScreenState extends State<LoginMainScreen> {
  String _animationType = 'idle';
  bool _obscure = true;
  IconData _icon = Icons.visibility_off;
  final _focusNode = FocusNode();
  final _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
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
                      inputController: _passwordController,
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
                        Navigator.pushNamed(context, HomePage.id);
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
                              _animationType = "test";
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
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
