import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';













     TextStyle kPostStyleArabicBase=  TextStyle(fontWeight: FontWeight.bold,color: Colors.black87,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic');
     TextStyle kPostStyleArabicChange=  TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic');
     TextStyle kPostStyleProfileChange=  TextStyle(fontWeight: FontWeight.bold,color: kSecondColor,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic');
     TextStyle kPostStyleArabicTextLable=  TextStyle(fontWeight: FontWeight.bold,color:  kSecondColor,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic');
     TextStyle kPostStyleArabicTextHint=  TextStyle(fontWeight: FontWeight.bold,color:Colors.black54 ,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic');
       TextStyle KBaseHeaders =TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold);






TextStyle stepStyleTitle =
    TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold);
TextStyle kRadioButton = TextStyle(color: Colors.blueAccent, fontSize: 10);

Color kMainColor = Color(0xffe6e6ea);

Color kSecondColor = Color(0xffF9A110);
Color KBackGroundColor =  Color(0xffe6e6ea);
     TextStyle kNavigationBar = TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',);
TextStyle kTitleHeadLine = TextStyle(
    color: Color(0xffAAA59F), fontSize: 12, fontWeight: FontWeight.w400,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',);
TextStyle bigHeadLine =
    TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',);
TextStyle kBlood =
    TextStyle(color: Color(0xFFEB1555), fontSize: 20, fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',);

TextStyle kTitleHeader =
    TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15);
TextStyle kCarousHeader =
    TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold);
TextStyle carouslittle =
    TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300);
TextStyle Data = TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
    color: Colors.blueAccent, fontSize: 17, fontWeight: FontWeight.bold);
TextStyle HomeHeadreStyle =
    TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
TextStyle homeLittleHeaderStyle = TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Color(0xff616161));

const KTitleTextStyle = TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
    fontSize: 20.0,
    color: Color(0xffE3E5E8),
);

TextStyle kHeadingTextStyle = TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
    fontSize: 18,
    color: Color(0xffB8B8B8),
);

TextStyle kBodyTextStyle = TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
);

const List<String> kGenderList = ['Male', 'Female'];
const List<String> kStatusList = ['Single', 'Married'];

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter value',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    hintStyle: TextStyle(
        color: Colors.white,
    ),
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
enum kPostPopMenu { edit, delete }

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