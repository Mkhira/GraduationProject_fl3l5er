
import 'package:company_task/Block/Block.dart';
import '../Furinture/AddFurniturePost.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/models/FurintureModel.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/AddPostfurnitureProvider.dart';
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
import 'package:provider/provider.dart';

import '../ItemsContent.dart';

class FurnitureScreen extends StatefulWidget {
  static const String id = 'FurnitureScreenPost';

  @override
  _FurnitureScreenState createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  Bloc _bloc;
  String x = '';
  @override
  void initState() {
    // TODO: implement initState
    Bloc();
    _bloc = Bloc();
    _bloc.fetchFurniture();
    _bloc.fetchFurnitureFinish();
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
                return AddFurniturePostScreen();
              }));
            },blocStream: _bloc.furnitureTextStream,state: (String text) {
              setState(() {_bloc.updateFurnitureText(text);
              print(_bloc.FurnitureTextController.value);
                print(_bloc.FurnitureTextController.value.length);x = text;
                if (_bloc.FurnitureTextController.value.length >=
                    1) {
                  _bloc.FurnitureSearch();
                } else if (_bloc.FurnitureTextController.value.length == 0 || _bloc.FurnitureTextController.value.trim() == ""
                    || _bloc.FurnitureTextController.value == null) {
                  _bloc.fetchFurniture();
                }});},),
            preferredSize: Size.fromHeight(80)),
        backgroundColor: kMainColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: TopFurniturePostHeader(
                  maxxExtent: 300,
                  minnExtent: 100,
                  stream: _bloc.streamFurnitureFinish),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[SizedBox(
                    height: 15,
                  ), Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      SizedBox(width: 35,),
                      Text("الأثاث",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ), SizedBox(height: 15), Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: (_bloc.FurnitureTextController.value == null ||
                          _bloc.FurnitureTextController.value.trim() == "" ||
                          _bloc.FurnitureTextController.value.length == 0)
                          ? StreamBuilder<List<FurnitureModel>>(
                        stream: _bloc.streamFurniture,
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
                                  furnitureModel: data,
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
                          : StreamBuilder<List<FurnitureModel>>(
                        stream: _bloc.streamFurnituresearch,
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
                                  furnitureModel: data,
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
                  ), SizedBox(
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
class TopFurniturePostHeader implements SliverPersistentHeaderDelegate {
  TopFurniturePostHeader({this.maxxExtent, this.minnExtent, this.stream});
  final double minnExtent;
  final double maxxExtent;
  final Stream stream;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return PostFurniturePersistantHeader(stream: stream);
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
  final FurnitureModel furnitureModel;
  ContentWidget({this.furnitureModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ItemContent(
            phone: furnitureModel.phone,
            name: furnitureModel.name,
            location: furnitureModel.location,
            imageUrl: furnitureModel.imageUrl,
            amount: furnitureModel.amount,
            dayLeft: furnitureModel.dayLeft,
            owner: furnitureModel.owner,
            state: furnitureModel.state,userImage: furnitureModel.userImage,
            information: "معلومات عن الأثاث",
            description: furnitureModel.description,
            userId: furnitureModel.userID,
            ownerName: furnitureModel.ownerName,
            typeState: furnitureModel.furnitureState,
          );
        }));
      },
      child: PostsMaterial(
        type: " الأثاث   ",
        state: furnitureModel.state,
        owner: furnitureModel.owner,
        imageUrl: furnitureModel.imageUrl,
        name: furnitureModel.name,
        phone: furnitureModel.phone,
      ),
    );
  }
}