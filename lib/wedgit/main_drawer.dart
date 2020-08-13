import 'package:community_material_icon/community_material_icon.dart';
import 'package:company_task/Screens/ContactUs.dart';
import 'package:company_task/Screens/LoginScreen/LoginMainScreen.dart';
import 'package:company_task/Screens/homePage.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/profile_screen.dart';
import 'package:company_task/provider/SignUpLoginProvider/FireBaseAuth.dart';
//import 'package:company_task/Screens/MedicinePosts.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/service/LoginService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../style/constent.dart';
//import 'package:profile_screen/models/info_provider.dart';
//import 'package:profile_screen/screens/edit_screen.dart';
//import 'package:profile_screen/screens/profile_screen.dart';
//import 'package:profile_screen/screens/ClothesPost.dart';
//import 'package:provider/provider.dart';
import 'package:google_fonts_arabic/fonts.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context,listen: false);

    return SafeArea(
      child: Drawer(
        elevation: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Container(
              height: 250.0,
              child: DrawerHeader(
                decoration: BoxDecoration(

                  color: Color(0xffF9A110),

                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        width: 65.0,
                        height: 65.0,
                        child: Provider.of<InfoProvider>(context).imageUrlProfile ==
                            null
                            ? Center()
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: '${Provider.of<InfoProvider>(context).imageUrlProfile}',
                            height: 130,
                            width: MediaQuery.of(context).size.width/2.21,

                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget:
                                (context, url, error) =>
                                Icon(Icons.error),
                            placeholderFadeInDuration:
                            Duration(days: 30),
                            useOldImageOnUrlChange: true,
                            filterQuality:
                            FilterQuality.low,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Flexible(
                        child: Text(

                          Provider.of<InfoProvider>(context).nameProfile,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          Provider.of<InfoProvider>(context).emailProfile,
                          style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',

                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 25.0,
              ),
              title: Text(
                'Home',
                style: TextStyle(  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                    fontSize: 22.0, fontWeight: FontWeight.w500),
              ),
              onTap: () => Navigator.pushNamed(context, HomePage.id),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',

                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => Navigator.pushNamed(context, ProfileScreen.id),
            ),
//            ListTile(
//              leading: Icon(Icons.favorite,),
//              title: Text('Medicine Post',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500,),),
//              onTap: () => Navigator.pushNamed(context, Items.id),
//            ),
            Divider(
              thickness: 3.0,
              color: Colors.grey.shade300,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUS()));
              },
              child: ListTile(
                enabled: false,
                leading: Icon(
                  CommunityMaterialIcons.contact_mail,
                  color: Colors.red,
                ),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                      fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',

                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                onTap: () {
                  print("fffffffff");
                },
              ),
            ),
            GestureDetector(
              onTap: ()async{

                await FirebaseAuth.instance.signOut().catchError((error)=> print(error.code));
//                Provider.of<AuthNotifier>(context).setUser(null);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return LoginMainScreen();
              }));
              },
              child: ListTile(
                enabled: false,

                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                title: Text(
                  'Sign Out',

                  style: TextStyle(
                      fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',

                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
