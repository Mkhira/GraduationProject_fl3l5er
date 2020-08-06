import 'package:company_task/Screens/LoginScreen/LoginMainScreen.dart';
import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/provider/SignUpLoginProvider/FireBaseAuth.dart';
//import 'package:company_task/Screens/MedicinePosts.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/service/LoginService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:profile_screen/models/info_provider.dart';
//import 'package:profile_screen/screens/edit_screen.dart';
//import 'package:profile_screen/screens/profile_screen.dart';
//import 'package:profile_screen/screens/ClothesPost.dart';
//import 'package:provider/provider.dart';

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
              height: 200.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff0041C4),
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
                        child: Provider.of<InfoProvider>(context).updatedImage ==
                            null
                            ? Center()
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            Provider.of<InfoProvider>(context).updatedImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          Provider.of<InfoProvider>(context).name,
                          style: TextStyle(
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
                          Provider.of<InfoProvider>(context).email,
                          style: TextStyle(
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
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
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
            ListTile(
              enabled: false,
              leading: Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ),
              onTap: () {},
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
