import 'package:company_task/Screens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'MyMainTextField.dart';

class StepperScreen extends StatefulWidget {
  @override
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int currentStep = 1;
  bool complete = false,_loading=false;
  String _administrativeArea = 'العنوان';
  String _locality = 'العنوان';

  next() {
    currentStep + 1 != 4
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> steps = [
      //Step1(next:next() ,cancel: cancel(),),
      step1(),
      step2(),
      step3(),
      //Step2(),
    ];

    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  height: 109.0,
                ),
                Positioned(
                  top: 20,
                  left: 1,
                  right: 1,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentStep < 1 ? indexContainer(1) : completeContainer(),
                    currentStep < 2 ? indexContainer(2) : completeContainer(),
                    currentStep < 3 ? indexContainer(3) : completeContainer(),
                  ],
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 600,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7.0,
                      //spreadRadius: 5.0,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: steps[currentStep - 1],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container indexContainer(int index) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 26.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Container completeContainer() {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 5,
            ),
          ]),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 35.0,
        ),
      ),
    );
  }

  Widget step1() {
    return Column(
      children: [
        SizedBox(
          height: 45.0,
        ),
        Stack(
          children: [
            Container(
              width: 155.0,
              height: 155.0,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orangeAccent, width: 3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.person,
                size: 100.0,
                color: Colors.grey[200],
              ),
            ),
            Positioned(
              bottom: 12.0,
              right: 0.0,
              child: Image.asset(
                'assets/camera.png',
                height: 35.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 40.0,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'الايميل',
          labelText: 'الايميل',
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(
          height: 25.0,
        ),
        Step1TextField(),
        SizedBox(
          height: 25.0,
        ),
        FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text(
            'هل لديك حساب بالفعل؟',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            width: 180.0,
            child: RaisedButton(
              padding: EdgeInsets.all(5),
              onPressed: next,
              child: Text(
                'التالي',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget step2() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 15,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'الاسم الاول',
          labelText: 'الاسم الاول',
        ),
        SizedBox(
          height: 25,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'اسم الاب',
          labelText: 'اسم الاب',
        ),
        SizedBox(
          height: 25,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'اسم العائلة',
          labelText: 'اسم العائلة',
        ),
        SizedBox(
          height: 25,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'الرقم القومي',
          labelText: 'الرقم القومي',
          inputType: TextInputType.phone,
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width: 90,
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 2.0,
                  indent: 12.0,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                'الحالة الاجتماعية',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 90,
                child: Divider(
                  endIndent: 12.0,
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
              ),
            ),
          ],
        ),
        Step2Radio(),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 110.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(4.0),
                  onPressed: cancel,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    'السابق',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 110.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(4.0),
                  onPressed: next,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    'التالي',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget step3() {
    return Column(
      children: [
        SizedBox(
          height: 80.0,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'الوظيفة',
          labelText: 'الوظيفة',
        ),
        SizedBox(
          height: 25,
        ),
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'التلفون',
          labelText: 'التلفون',
          inputType: TextInputType.phone,
        ),
        SizedBox(
          height: 25,
        ),
        MyMainTextField(
          hintText: _locality,
          labelText: 'العنوان',
          widget: IconButton(
            icon: Icon(Icons.language),
            onPressed: () async {
              setState(() {
                _loading=true;
              });
              Position position = await Geolocator()
                  .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

              //get the address from the coordinates
              List<Placemark> placeMark = await Geolocator()
                  .placemarkFromCoordinates(
                  position.latitude, position.longitude);

              Placemark place = placeMark[0];
              setState(() {
//                  _administrativeArea =
//                      place.locality;
                _locality = place.locality;
                _loading=false;
              });
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 110,
              child: Divider(
                color: Colors.grey[300],
                thickness: 2.0,
                indent: 12.0,
              ),
            ),
            Text(
              'النوع',
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Container(
              width: 110,
              child: Divider(
                endIndent: 12.0,
                color: Colors.grey[300],
                thickness: 2.0,
              ),
            ),
          ],
        ),
        Step3Radio(),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 110.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(4.0),
                  onPressed: cancel,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    'السابق',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 110.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(4.0),
                  //todo goto main page && making condition to go to home page.
                  onPressed: ()=>Navigator.pushNamed(context,HomePage.id),
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    'انشاء',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Step1TextField extends StatefulWidget {
  @override
  _Step1TextFieldState createState() => _Step1TextFieldState();
}

class _Step1TextFieldState extends State<Step1TextField> {
  bool _obscure = true, _confirmObscure = true;
  IconData _icon = Icons.visibility_off, _confirmIcon = Icons.visibility_off;

  void _toggle() {
    setState(() {
      _obscure = !_obscure;
      _icon =
      _icon == Icons.visibility ? Icons.visibility_off : Icons.visibility;
    });
  }

  void _confirmToggle() {
    setState(() {
      _confirmObscure = !_confirmObscure;
      _confirmIcon = _confirmIcon == Icons.visibility
          ? Icons.visibility_off
          : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'كلمة المرور',
          labelText: 'كلمة المرور',
          obscure: _obscure,
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
        MyMainTextField(
          width: MediaQuery.of(context).size.width,
          hintText: 'تأكيد كلمة المرور',
          labelText: 'تأكيد كلمة المرور',
          obscure: _confirmObscure,
          widget: IconButton(
            icon: Icon(
              _confirmIcon,
              color: Colors.grey,
            ),
            onPressed: _confirmToggle,
          ),
        ),
      ],
    );
  }
}

class Step3Radio extends StatefulWidget {
  @override
  _Step3RadioState createState() => _Step3RadioState();
}

class _Step3RadioState extends State<Step3Radio> {
  String _gender = 'male';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Text(
              'ذكر',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            Radio(
              activeColor: Colors.orange,
              value: 'male',
              groupValue: _gender,
              onChanged: (String value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'انثي',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            Radio(
              activeColor: Colors.orange,
              value: 'female',
              groupValue: _gender,
              onChanged: (String value) {
                setState(
                      () {
                    _gender = value;
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class Step2Radio extends StatefulWidget {
  @override
  _Step2RadioState createState() => _Step2RadioState();
}

class _Step2RadioState extends State<Step2Radio> {
  String _status = 'divorced';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Text(
              'مطلق',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            Radio(
              activeColor: Colors.orange,
              value: 'divorced',
              groupValue: _status,
              onChanged: (String value) {
                setState(() {
                  _status = value;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'متزوج',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            Radio(
              activeColor: Colors.orange,
              value: 'married',
              groupValue: _status,
              onChanged: (String value) {
                setState(
                      () {
                    _status = value;
                  },
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'اعزب',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            Radio(
              activeColor: Colors.orange,
              value: 'single',
              groupValue: _status,
              onChanged: (String value) {
                setState(
                      () {
                    _status = value;
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
