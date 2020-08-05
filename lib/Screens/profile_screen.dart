import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/edit_screen.dart';
import 'package:company_task/Screens/more_info.dart';
import 'package:company_task/Screens/profile_image_screen.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/list_item.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:company_task/wedgit/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

//import 'package:profile_screen/constants.dart';
//import 'package:profile_screen/models/info_provider.dart';
//import 'package:profile_screen/screens/profile_image_screen.dart';
//import 'package:profile_screen/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:profile_screen/widgets/list_item.dart';
//import 'package:profile_screen/widgets/progress_bar.dart';
//import 'package:profile_screen/screens/edit_screen.dart';
//import 'package:profile_screen/screens/more_info.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> image = [
    'assets/medicine.jfif',
    'assets/food.jpg',
    'assets/clothes.jpg',
    'assets/education.jfif',
  ];

  List<String> title = [
    'Give medecine to poor people.',
    'Give food to poor people.',
    'Give clothes to poor people.',
    'Donate to build a school.',
  ];

  List<String> subtitle = [
    'Give medecine to poor people.',
    'Give food to poor people.',
    'Give clothes to poor people.',
    'Donate to build a school.',
  ];



  List<String> category = ['Medicine', 'Food', 'Clothes', 'Education'];
  Bloc _bloc;

@override
  void initState()  {


    // TODO: implement initState

  var prov = Provider.of<InfoProvider>(context,listen: false);
  prov.fetch();
  Bloc();
  _bloc = Bloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<InfoProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xff0041C4), //Color(0xFF04022B),
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 25.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: 205.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: 25.0,
                left: 15.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          width: 150.0,
                          height: 150.0,
                          child:
                              profileProvider.imageUrlProfile ==
                                      null
                                  ? Center(
                                      child: Text(
                                      'No image selected.',
                                      style: TextStyle(color: Colors.white),
                                    ))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:CachedNetworkImage(
                                        imageUrl: profileProvider.imageUrlProfile,
                                        height: 98,
                                        width: 200,
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Provider.of<InfoProvider>(context, listen: false)
                                  .modifyImage =
                              Provider.of<InfoProvider>(context, listen: false)
                                  .updatedImage;
                          Navigator.pushNamed(context, ProfileImageScreen.id);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '${profileProvider.nameProfile}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',//Color(0xff2CC696),
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                onSelected: (kMainPopMenu result) {
                                  if (result == kMainPopMenu.editProfile) {
                                    Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .modifyImage =
                                        Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .updatedImage;

                                    Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .modifyStatus =
                                        Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .updatedStatus;
                                    Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .modifyGender =
                                        Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .updatedGender;

                                    Provider.of<InfoProvider>(context,
                                            listen: false)
                                        .modifyDay = Provider.of<InfoProvider>(
                                            context,
                                            listen: false)
                                        .updatedDay;

                                    Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .modifyMonth =
                                        Provider.of<InfoProvider>(context,
                                                listen: false)
                                            .updatedMonth;

                                    Provider.of<InfoProvider>(context,
                                            listen: false)
                                        .modifyYear = Provider.of<InfoProvider>(
                                            context,
                                            listen: false)
                                        .updatedYear;
                                  }
                                  result == kMainPopMenu.moreInfo
                                      ? showModalBottomSheet(
                                          context: context,
                                          builder: (context) => MoreInfo(),
                                        )
                                      : Navigator.pushNamed(
                                          context, EditScreen.id);
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<kMainPopMenu>>[
                                  PopupMenuItem<kMainPopMenu>(
                                    value: kMainPopMenu.moreInfo,
                                    child: Text('More Information'),
                                  ),
                                  PopupMenuItem<kMainPopMenu>(
                                    value: kMainPopMenu.editProfile,
                                    child: Text('Edit Profile'),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.work, color: Colors.white),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                '${profileProvider.jop}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on, color: Colors.white),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text(
                               '${profileProvider.location}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/donate.png',
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                '14 Donation',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              blurRadius: 7,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 15.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  'BIO',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                Provider.of<InfoProvider>(context).bio,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 21.0,
                                  wordSpacing: 3.0,
                                  color: Colors.black87, //Color(0xffB4B6B6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Wheres your donations go?',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ProgressBar(
                        progressValue: 100.0,
                        category: 'Education',
                        value: 872400,
                      ),
                      ProgressBar(
                        progressValue: 70.0,
                        category: 'Medicine',
                        value: 13700,
                      ),
                      ProgressBar(
                        progressValue: 50.0,
                        category: 'Clothes',
                        value: 928,
                      ),
                      ProgressBar(
                        progressValue: 60.0,
                        category: 'Blood Donation',
                        value: 420,
                      ),
                      ProgressBar(
                        progressValue: 30.0,
                        category: 'Furniture',
                        value: 500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //width: 500,
          ),
        ],
      ),
    );
  }
}
