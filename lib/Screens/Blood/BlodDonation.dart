import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/Blood/AddBloodPostScreen.dart';
import 'package:company_task/Screens/Blood/NeedyData.dart';
import 'package:company_task/Screens/Profile/profile_screen.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/BloodNeedyModel.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import '../../style/constent.dart';
import '../../wedgit/BloodHeaderWidget.dart';
import '../../wedgit/caruselWedgit.dart';
import '../../wedgit/bloodWedgit.dart';

class BloodDonation extends StatefulWidget {
  @override
  _BloodDonationState createState() => _BloodDonationState();
}

class _BloodDonationState extends State<BloodDonation> {
  Bloc _bloc;
  User _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Bloc();
    _bloc = Bloc();
    _bloc.fetchBloodNeedy();
  }
  String tokne;

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<InfoProvider>(context);
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: kSecondColor,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBloodPostScreen()));
            },
            child: Icon(Icons.add),
          ),
      backgroundColor: kMainColor,
      body: CustomScrollView(
        slivers: <Widget>[


          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: TopClothesPostHeader(
                maxxExtent: 300,
                minnExtent: 100,
                stream: _bloc.streamClothFinish),
          ),


          SliverList(

            delegate: SliverChildListDelegate(
              <Widget>[
                StreamBuilder<List<BloodNeedyModel>>(
                    stream: _bloc.streamNeedy,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final list = snapshot.data[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              child: donationList(
                                name: list.name,
                                description: list.description,
                                imageUrl: list.imageUrl,
                                blood: list.bloodType,
                                onPressed: () async{


                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return BloodNeedyData(
                                      phone: list.phone,
                                      userId: list.userId,
                                      name: list.name,location: list.location,gander: list.gander,age: list.age,
                                    bankAccount: list.bloodBankId,bloodCollected: list.collectedAmount,bloodNeed: list.neededAmount,bloodType: list.bloodType,description: list.description,hospitalName: list.hospitalName,postOwnerName: list.postOwnerName,imageUrl: list.imageUrl,);
                                  }));
                                },
                              ),
                            );
                          },
                          itemCount: snapshot.data.length,
                        );
                      } else
                        return Container();
                    }),

              ],
            ),
          ),
        ],
      ),
    ));
  }
}


class TopClothesPostHeader implements SliverPersistentHeaderDelegate {
  TopClothesPostHeader({this.maxxExtent, this.minnExtent, this.stream});
  final double minnExtent;
  final double maxxExtent;
  final Stream stream;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var profileProvider = Provider.of<InfoProvider>(context);

    // TODO: implement build
    return    Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
              color: Color(0xffe6e6ea),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Spacer(
                    flex: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kMainColor,
                    ),
                    width:
                    MediaQuery.of(context).size.width / 1.5,
                    height: 60,
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(Provider.of<InfoProvider>(context).nameProfile != null ? "${Provider.of<InfoProvider>(context).nameProfile}" : "من فضلك اضغط هنا >>",style: TextStyle(
                            fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            color: kSecondColor,
                            fontSize: 20
                        ),)
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context,ProfileScreen.id);
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      width: 65.0,
                      height: 65.0,
                      child:  profileProvider.imageUrlProfile ==
                          null
                          ? Center(
                          child: Text(
                            'Click',
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
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),


        Container(
          padding: EdgeInsets.all(15),
           color: kMainColor,
          width: MediaQuery.of(context).size.width,
          child: Text("الهروب من الموت قد يتطلب كيس دم واحد ، أنقذ حياة مريض واليوم أنت المتبرع وغدًا قد تكون من يحتاج إلى التبرع ، بادر بإنقاذ مريض",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: Colors.black),),
        ),

      ],
    );
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