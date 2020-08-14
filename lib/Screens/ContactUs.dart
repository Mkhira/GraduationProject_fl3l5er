//




import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts_arabic/fonts.dart';

class ContactUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: new Container(),
          backgroundColor: kSecondColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Spacer(
                        flex: 2,
                      ),
                      Text(
                        "تواصل معنا ",
                        style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 32,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      SizedBox(
                        width: 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              ContactUsCard(email:"khaledkhaira@gmail.com" ,image: "assets/me.jpg",name: "محمد خالد خيره",phone: "01094580442",),
              ContactUsCard(email: "medosakr506@gmail.com",name: "احمد محمد صقر",image: "assets/sakr.jpeg",phone: "01013709514",),
              ContactUsCard(phone: "01006248494",name: "تسنيم حسام ",image: "assets/tasnem.jpeg",email: "Tota.hosam1997@gmail.com",),
              ContactUsCard(image: "assets/darwesh.jpeg",phone: "01092485524",name: "احمد صبحي درويش",email: "ahmeddarwish0098@gmail.com",),
              ContactUsCard(email: "bakrahmed649@gmail.com",name: "احمد عبدالفتاح بكر",phone: "01204809694",image: "assets/bakr.jpeg",),
            ],
          )
        ),
      ),
    );
  }
}

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({
    this.name,this.phone,this.email,this.image
  }) ;
  final String image;
  final String name;
  final String email;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 175,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            height: 150,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kSecondColor
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),

              child: Image(
                image: AssetImage("$image"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 5,),

          Container(
            height: 150,
            width: MediaQuery.of(context).size.width-140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Container(

                  width: MediaQuery.of(context).size.width-140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                       Text(" :الإسم  ", style: TextStyle(
                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                           fontSize: 13,
                           fontWeight: FontWeight.bold,
                           color: Colors.black),),
                       Text("$name", style: TextStyle(
                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
                           color: kSecondColor),)

                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Container(

                  width: MediaQuery.of(context).size.width-140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      SizedBox(width: 10,),
                       Text(" :الإيميل  ", style: TextStyle(
                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                           fontSize: 13,
                           fontWeight: FontWeight.bold,
                           color: Colors.black),),
                       Text("$email", style: TextStyle(
                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
                           color: kSecondColor),)

                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Container(

                  width: MediaQuery.of(context).size.width-140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[

                      Text(" :الهاتف  ", style: TextStyle(
                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                           fontSize: 13,
                           fontWeight: FontWeight.bold,
                           color: Colors.black),),
                       Text("$phone", style: TextStyle(
                           fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                           fontSize: 12,
                           fontWeight: FontWeight.bold,
                           color: kSecondColor),)


                    ],
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
