import 'package:flutter/material.dart';

TextStyle stepStyleTitle =
    TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold);
TextStyle kRadioButton = TextStyle(color: Colors.blueAccent, fontSize: 10);

Color kMainColor = Color(0xffe6e6ea);

Color kSecondColor = Color(0xffF9A110);

TextStyle kTitleHeadLine = TextStyle(
    color: Color(0xffAAA59F), fontSize: 12, fontWeight: FontWeight.w400);
TextStyle bigHeadLine =
    TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold);
TextStyle kBlood =
    TextStyle(color: kSecondColor, fontSize: 25, fontWeight: FontWeight.bold);

TextStyle kTitleHeader =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15);
TextStyle kCarousHeader =
    TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);
TextStyle carouslittle =
    TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300);
TextStyle Data = TextStyle(
    color: Colors.blueAccent, fontSize: 17, fontWeight: FontWeight.bold);
TextStyle HomeHeadreStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
TextStyle homeLittleHeaderStyle = TextStyle(color: Color(0xff616161));

const KTitleTextStyle = TextStyle(
    fontSize: 20.0,
    color: Color(0xffE3E5E8),
);

TextStyle kHeadingTextStyle = TextStyle(
    fontSize: 18,
    color: Color(0xffB8B8B8),
);

TextStyle kBodyTextStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
);

const List<String> kGenderList = ['Male', 'Female'];
const List<String> kStatusList = ['Single', 'Married'];

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter value',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
);

enum kPickImage { gallery, camera }

enum kMainPopMenu { editProfile, moreInfo }

enum kGender { male, female }

List<String> kDay = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
];

List<String>kMonth=[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
];
List<String>kYear=[
    '1987',    //33 years old
    '1988',
    '1989',
    '1990',
    '1991',
    '1992',
    '1993',
    '1994',
    '1995',
    '1996',
    '1997',
    '1998',
    '1999',
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',

    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
];