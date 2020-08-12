import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:company_task/Block/Block.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Cloth/AddClothPost.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Furinture/AddFurniturePost.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Medicine/AdingMedicienPost.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Profile/profile_screen.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/provider/AddPostClothProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/PostsWidget/PostMaterialWedgit.dart';
import 'package:company_task/wedgit/PostsWidget/PostPersistantHeader.dart';
import 'package:company_task/wedgit/PostsWidget/PostsAppBarAddAndSearch.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

import '../ItemsContent.dart';

class ClothesPost extends StatefulWidget {
  static const String id = 'ClothesPost';

  @override
  _ClothesPostState createState() => _ClothesPostState();
}

class _ClothesPostState extends State<ClothesPost> {
  Bloc _bloc;
  String x = '';
  @override
  void initState() {
    // TODO: implement initState
    Bloc();
    _bloc = Bloc();
    _bloc.fetchCloth();
    _bloc.fetchClothFinish();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: PreferredSize(
            child: PostsAppBarrHeader(add:  () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddClothPostDataScreen();
              }));
            },blocStream: _bloc.ClothTextStream,state: (String text) {
              setState(() {
                _bloc.updateClothText(text);

                print(_bloc
                    .ClothTextController.value);

                print(_bloc.ClothTextController
                    .value.length);

                x = text;

                if (_bloc.ClothTextController.value
                    .length >=
                    1) {
                  _bloc.ClothSearch();
                } else if (_bloc.ClothTextController
                    .value.length ==
                    0 ||
                    _bloc.ClothTextController.value
                        .trim() ==
                        "" ||
                    _bloc.ClothTextController
                        .value ==
                        null) {
                  _bloc.fetchCloth();
                }
              });
            },),

            preferredSize: Size.fromHeight(80)),
        backgroundColor: kMainColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: TopClothesPostHeader(
                  maxxExtent: 300,
                  minnExtent: 100,
                  stream: _bloc.streamClothFinish),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      SizedBox(width: 15,),
                      Text("الملابس",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),


                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: (_bloc.ClothTextController.value == null ||
                              _bloc.ClothTextController.value.trim() == "" ||
                              _bloc.ClothTextController.value.length == 0)
                          ? StreamBuilder<List<ClothModel>>(
                              stream: _bloc.streamCloth,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return new StaggeredGridView.countBuilder(
                                    crossAxisCount: 4,
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, index) {
                                      var data = snapshot.data[index];

                                      return ContentWidget(
                                        clothModel: data,
                                      );
                                    },
                                    staggeredTileBuilder: (data) =>
                                        new StaggeredTile.count(
                                            2, data.isEven ? 3.25 : 3),
                                    mainAxisSpacing: 15.0,
                                    crossAxisSpacing: 15.0,
                                  );
                                } else
                                  return Container();
                              },
                            )
                          : StreamBuilder<List<ClothModel>>(
                              stream: _bloc.streamClothsearch,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return new StaggeredGridView.countBuilder(
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 4,
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    itemBuilder: (BuildContext context, index) {
                                      var data = snapshot.data[index];

                                      return ContentWidget(
                                        clothModel: data,
                                      );
                                    },
                                    staggeredTileBuilder: (data) =>
                                        new StaggeredTile.count(
                                            2, data.isEven ? 3.25 : 3),
                                    mainAxisSpacing: 15.0,
                                    crossAxisSpacing: 15.0,
                                  );
                                } else
                                  return Container();
                              },
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    // TODO: implement build
    return PostClothPersistantHeader(stream: stream);
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

class ContentWidget extends StatelessWidget {
  final ClothModel clothModel;
  ContentWidget({this.clothModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ItemContent(
            phone: clothModel.phone,
            name: clothModel.name,
            location: clothModel.location,
            imageUrl: clothModel.imageUrl,
            amount: clothModel.amount,
            dayLeft: clothModel.dayLeft,
            owner: clothModel.owner,
            state: clothModel.state,
            userImage: clothModel.userImage,
            information: "معلومات عن الملبس",
            description: clothModel.description,
            ownerName: clothModel.ownerName,
            userId: clothModel.userID,

          );
        }));
      },
      child: PostsMaterial(type: "الملبس  ",
        state: clothModel.state,
        owner: clothModel.owner,
        imageUrl: clothModel.imageUrl,
        name: clothModel.name,
        phone: clothModel.phone,
      ),
    );
  }
}


