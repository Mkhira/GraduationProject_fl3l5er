
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/Cloth/ClothMoreScreen.dart';
import 'package:company_task/Screens/Furinture/FurintureMoreScreen.dart';
import 'package:company_task/Screens/HomePageContentScreen.dart';
import 'package:company_task/Screens/Profile/ProfileClothMore.dart';
import 'package:company_task/Screens/Profile/ProfileFurnitureMore.dart';
import 'package:company_task/Screens/Profile/ProfileMedicineMore.dart';
import 'package:company_task/Screens/edit_screen.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/more_info.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/profile_image_screen.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/models/FurintureModel.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/service/deleteService.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/list_item.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:company_task/wedgit/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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



Delete delete = Delete();

@override
  void initState()  {

    // TODO: implement initState

  super.initState();
  var prov = Provider.of<InfoProvider>(context,listen: false);
  prov.fetch();
  Bloc();
  _bloc = Bloc();
  _bloc.fetchClothProfileData(context);
  _bloc.fetchFurnitureProfileData(context);
  _bloc.fetchMedicineProfileData(context);
//  _bloc.fetchUSerProfile(context, widget.userId);

  }

  final List<MenuItem> menuitems =[
    MenuItem(menuValue: 'Edit'),
    MenuItem(menuValue: 'Delete'),
  ];
  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<InfoProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor, //Color(0xFF04022B),

        appBar: AppBar(

         title: Row(
           textDirection: TextDirection.rtl,
           children: <Widget>[
             SizedBox(width: 10,),
             Text("الصفحه الشخصيه",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
           ],
         ),

          backgroundColor: kSecondColor,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              ProfileHeader(),
              SizedBox(height: 15),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  SizedBox(width: 35,),
                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[

                        FlatButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileClothMoreScreen()));
                        },
                          child: Text("المزيد",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
                        ),

                        Spacer(),
                        Text("الملابس",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(width: 40,)


                      ],
                    ),
                  )              ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:  StreamBuilder<List<ClothModel>>(
                    stream: _bloc.streamClothProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 290,
                          child: new ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              addAutomaticKeepAlives: false,
                              itemBuilder: (BuildContext context, index) {
                                var data = snapshot.data[index];

                                return Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: PostClothProfileMaterial(
                                    clothModel: data,
                                    onsSelect: (kPostPopMenu result){

                                      if(result == kPostPopMenu.delete){
                                        setState(() {
                                          delete.deleteDocument('Cloth', data.documentId);
                                          _bloc.fetchClothProfileData(context);
                                        });
                                      }

                                    },
                                  ),
                                );
                              }),
                        );
                      } else
                        return
                          Container(
                          height: 290,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Center(
                            child:   Text("لم يتم نشر بوستات الى الان",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold,color: kSecondColor),),
                          ),
                        );

                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  SizedBox(width: 40,),
                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[

                        FlatButton(

                          onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileFurnitureMoreScreen()));
                        },
                          child: Text("المزيد",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
                        ),

                        Spacer(),
                        Text("الأثاث",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
SizedBox(width: 40,)

                      ],
                    ),
                  )              ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20,top: 10,bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:  StreamBuilder<List<FurnitureModel>>(
                    stream: _bloc.streamFurnitureProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 290,
                          child: new ListView.builder(

                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              shrinkWrap: false,
                              addAutomaticKeepAlives: false,
                              itemBuilder: (BuildContext context, index) {
                                var data = snapshot.data[index];

                                return Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: PostFurnitureProfileMaterial(
                                    furnitureModel: data,
                                    onsSelect: (kPostPopMenu result){

                                      if(result == kPostPopMenu.delete){
                                        setState(() {
                                          delete.deleteDocument('Furniture', data.documentId);
                                          _bloc.fetchFurnitureProfileData(context);
                                        });
                                      }

                                    },
                                  ),
                                );
                              }),
                        );
                      } else
                        return     Container(
                          height: 290,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Center(
                            child:   Text("لم يتم نشر بوستات الى الان",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold,color: kSecondColor),),
                          ),
                        );

                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  SizedBox(width: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[

                        FlatButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileMedicineMoreScreen()));
                        },
                          child: Text("المزيد",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
                        ),

                        Spacer(),
                        Text("الأدويه",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),


                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child:
                  StreamBuilder<List<MedicineModel>>(
                    stream: _bloc.streamMedicineProfile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 290,
                          child: new ListView.builder(

                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              shrinkWrap: false,
                              addAutomaticKeepAlives: false,
                              itemBuilder: (BuildContext context, index) {
                                var data = snapshot.data[index];

                                return Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 10),
                                  child: PostMedicineProfileMaterial(
                                    medicineModel: data,
                                    onsSelect: (kPostPopMenu result){

                                      if(result == kPostPopMenu.delete){
                                        setState(() {
                                          delete.deleteDocument('medicine', data.documentId);
                                          _bloc.fetchMedicineProfileData(context);
                                        });
                                      }

                                    },
                                  ),
                                );
                              }),
                        );
                      } else
                        return     Container(
                          height: 290,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Center(
                            child:   Text("لم يتم نشر بوستات الى الان",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold,color: kSecondColor),),
                          ),
                        );

                    },
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
            ],
          ),
        )

      ),
    );
  }
}



class TopProfileHeader implements SliverPersistentHeaderDelegate {
  TopProfileHeader({this.maxxExtent, this.minnExtent,});
  final double minnExtent;
  final double maxxExtent;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return ProfileHeader();
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => minExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => maxxExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}

class ProfileHeader extends StatelessWidget {

Bloc _bloc = Bloc();

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<InfoProvider>(context);

    return Container(
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
       color: kMainColor
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
//                    onTap: () {
//                      Provider.of<InfoProvider>(context, listen: false)
//                              .modifyImage =
//                          Provider.of<InfoProvider>(context, listen: false)
//                              .updatedImage;
//                      Navigator.pushNamed(context, ProfileImageScreen.id);
//                    },
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
                                color: kSecondColor,
                                fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',//Color(0xff2CC696),
                              ),
                            ),
                          ),
//                          PopupMenuButton(
//                            icon: Icon(
//                              Icons.more_vert,
//                              color: kSecondColor,
//                            ),
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(6.0),
//                            ),
//                            onSelected: (kMainPopMenu result) {
//                              if (result == kMainPopMenu.editProfile) {
//                                Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .modifyImage =
//                                    Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .updatedImage;
//
//                                Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .modifyStatus =
//                                    Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .updatedStatus;
//                                Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .modifyGender =
//                                    Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .updatedGender;
//
//                                Provider.of<InfoProvider>(context,
//                                        listen: false)
//                                    .modifyDay = Provider.of<InfoProvider>(
//                                        context,
//                                        listen: false)
//                                    .updatedDay;
//
//                                Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .modifyMonth =
//                                    Provider.of<InfoProvider>(context,
//                                            listen: false)
//                                        .updatedMonth;
//
//                                Provider.of<InfoProvider>(context,
//                                        listen: false)
//                                    .modifyYear = Provider.of<InfoProvider>(
//                                        context,
//                                        listen: false)
//                                    .updatedYear;
//                              }
//                              result == kMainPopMenu.moreInfo
//                                  ? showModalBottomSheet(
//                                      context: context,
//                                      builder: (context) => MoreInfo(),
//                                    )
//                                  : Navigator.pushNamed(
//                                      context, EditScreen.id);
//                            },
//                            itemBuilder: (BuildContext context) =>
//                                <PopupMenuEntry<kMainPopMenu>>[
//                              PopupMenuItem<kMainPopMenu>(
//                                value: kMainPopMenu.moreInfo,
//                                child: Text('More Information'),
//                              ),
//                              PopupMenuItem<kMainPopMenu>(
//                                value: kMainPopMenu.editProfile,
//                                child: Text('Edit Profile'),
//                              ),
//                            ],
//                          )
                        ],
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.work, color: kSecondColor),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            '${profileProvider.jopProfile}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: kSecondColor,
                              fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.location_on, color: kSecondColor),
                          SizedBox(
                            width: 12.0,
                          ),
                          Text(
                           '${profileProvider.locationProfile}',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: kSecondColor,
                              fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            ),
                          ),
                        ],
                      ),
//                      Row(
//                        children: <Widget>[
//                          Image.asset(
//                            'assets/donate.png',
//                            color: kSecondColor,
//                          ),
//                          SizedBox(
//                            width: 6.0,
//                          ),
//                          Text(
//                            '${}',
//                            style: TextStyle(
//                              fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
//                              fontSize: 18.0,
//                              fontWeight: FontWeight.w600,
//                              color: kSecondColor,
//                            ),
//                          ),
//                        ],
//                      ),
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

class PostMedicineProfileMaterial extends StatelessWidget {

  const PostMedicineProfileMaterial({
    this.medicineModel,
    this.onsSelect,
  });

   final MedicineModel medicineModel;
   final Function onsSelect;

  @override
  Widget build(BuildContext context) {
    return
     Column(
       children: <Widget>[
         SizedBox(
           height: 10,
         ),
         Material(
           elevation: 4,
           borderRadius: BorderRadius.circular(10),
           child: Container(
             width: MediaQuery.of(context).size.width/2.21,
             height: 270,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: kSecondColor
             ),
             child: Container(

               child: Column(
                 children: <Widget>[
                   Container(
                     width: MediaQuery.of(context).size.width/2,
                     height: 130,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                         color: kSecondColor
                     ),
                     child: Stack(
                       children: <Widget>[
                         Positioned(

                           top: 0,
                           left: 0,
                           child:  ClipRRect(
                             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                             child:CachedNetworkImage(
                               imageUrl: '${medicineModel.imageUrl}',
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
                         Positioned(
                           top: 0,
                           right: 0,
                           child:
                           PopupMenuButton(
                             icon: Icon(
                               Icons.more_vert,
                               color: Colors.black,
                             ),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(6.0),
                             ),
                             onSelected: onsSelect,
                             itemBuilder: (BuildContext context) =>
                             <PopupMenuEntry<kPostPopMenu>>[

                               PopupMenuItem<kPostPopMenu>(
                                 value: kPostPopMenu.delete,
                                 child: Text("إزاله",style: TextStyle(
                                   fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                 ),),
                               ),
                             ],
                           ),
                         ),

                       ],
                     ),
                   ),
                   SizedBox(height: 5,),
                   Column(
                     children: <Widget>[
                       Row(
                         textDirection: TextDirection.rtl,
                         children: <Widget>[
                           Text(' : الدواء  ',style: kPostStyleArabicBase,),
                           AutoSizeText(
                             '${medicineModel.name}',
                             textAlign: TextAlign.right,

                             presetFontSizes: [ 14, 12,8],
                             style: kPostStyleArabicChange,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                           )   ,                             ],
                       ),
                       Row(
                         textDirection: TextDirection.rtl,
                         children: <Widget>[
                           Text(' :المالك  ',style: kPostStyleArabicBase,),
                           AutoSizeText(
                             '${medicineModel.owner}',
                             textAlign: TextAlign.right,

                             presetFontSizes: [ 14, 12,8],
                             style: kPostStyleArabicChange,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                           )   ,                             ],
                       ),
                       Row(
                         textDirection: TextDirection.rtl,
                         children: <Widget>[
                           Text(' :الحاله ',style: kPostStyleArabicBase,),
                           AutoSizeText(
                             '${medicineModel.state}',
                             textAlign: TextAlign.right,

                             presetFontSizes: [ 14, 12,8],
                             style: kPostStyleArabicChange,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                           )   ,                             ],
                       ),
                       Row(
                         textDirection: TextDirection.rtl,
                         children: <Widget>[
                           Text(' :الهاتف   ',style: kPostStyleArabicBase,),
                           AutoSizeText(
                             '${medicineModel.phone}',
                             textAlign: TextAlign.right,

                             presetFontSizes: [ 14, 12,8],
                             style: kPostStyleArabicChange,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                           )   ,                          ],
                       ),
                     ],
                   )
                 ],
               ),
             ),
           ),
         ),
         SizedBox(
           height: 10,
         )
       ],
     )
      ;
  }
}

class PostClothProfileMaterial extends StatelessWidget {

  const PostClothProfileMaterial({
    this.clothModel,
    this.onsSelect,
  });

  final ClothModel clothModel;
  final Function onsSelect;

  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width/2.21,
            height: 270,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kSecondColor
            ),
            child: Container(

              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                        color: kSecondColor
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(

                          top: 0,
                          left: 0,
                          child:  ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            child:CachedNetworkImage(
                              imageUrl: '${clothModel.imageUrl}',
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
                        Positioned(
                          top: 0,
                          right: 0,
                          child:
                          PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            onSelected: onsSelect,
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<kPostPopMenu>>[

                              PopupMenuItem<kPostPopMenu>(
                                value: kPostPopMenu.delete,
                                child: Text("إزاله",style: TextStyle(
                                  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                ),),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Column(
                    children: <Widget>[
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' : الملبس     ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${clothModel.name}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )   ,                         ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' :المالك   ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${clothModel.owner}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )   ,                         ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' :الحاله  ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${clothModel.state}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )   ,                         ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' :الهاتف    ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${clothModel.phone}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )   ,                      ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    )
  ;
  }
}
class PostFurnitureProfileMaterial extends StatelessWidget {

  const PostFurnitureProfileMaterial({
    this.furnitureModel,
    this.onsSelect,
  });

  final FurnitureModel furnitureModel;
  final Function onsSelect;

  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width/2.21,
            height: 270,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kSecondColor
            ),
            child: Container(

              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                        color: kSecondColor
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(

                          top: 0,
                          left: 0,
                          child:  ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            child:CachedNetworkImage(
                              imageUrl: '${furnitureModel.imageUrl}',
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
                        Positioned(
                          top: 0,
                          right: 0,
                          child:
                          PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            onSelected: onsSelect,
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<kPostPopMenu>>[

                              PopupMenuItem<kPostPopMenu>(
                                value: kPostPopMenu.delete,
                                child: Text("إزاله",style: TextStyle(
                                  fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                                ),),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Column(
                    children: <Widget>[
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' : الأثاث       ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${furnitureModel.name}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )  ,
                        ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' :المالك   ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${furnitureModel.owner}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )  ,                          ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' :الحاله  ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${furnitureModel.state}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )  ,                          ],
                      ),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Text(' :الهاتف    ',style: kPostStyleArabicBase,),
                          AutoSizeText(
                            '${furnitureModel.phone}',
                            textAlign: TextAlign.right,

                            presetFontSizes: [ 14, 12,8],
                            style: kPostStyleArabicChange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )  ,                          ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10,)
      ],
    )
      ;
  }
}

class MenuItem{
  String menuValue;

  MenuItem({this.menuValue});



}





