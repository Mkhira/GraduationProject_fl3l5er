import 'package:cached_network_image/cached_network_image.dart';
import 'Medicine/AdingMedicienPost.dart';
import 'Medicine/MedicineContentWidget.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/info_provider.dart';
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
import '../Block/Block.dart';
import '../style/constent.dart';
import 'ItemsContent.dart';

class MedicinePosts extends StatefulWidget {
  static const String id = 'items';

  @override
  _MedicinePostsState createState() => _MedicinePostsState();
}

class _MedicinePostsState extends State<MedicinePosts> {
  Bloc _bloc;
  String x = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Bloc();
    _bloc = Bloc();
    _bloc.fetchMedicine();
    _bloc.fetchMedicineFinish();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

      drawer: MainDrawer(),
      appBar: PreferredSize(
          child: PostsAppBarrHeader(
            add: () {
              Provider.of<AddPostMedicineProvider>(context).close(context);

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddMedicinePostDataScreen();
              }));
            },
            blocStream: _bloc.MedicineTextStream,
            state: (String text) {
              setState(() {
                _bloc.updateMedicineText(text);

                print(_bloc.MedicenTextController.value.length);

                x = text;

                if (_bloc.MedicenTextController.value.length >= 1) {
                  _bloc.MedicineSearch();
                } else if (_bloc.MedicenTextController.value.length == 0 ||
                    _bloc.MedicenTextController.value.trim() == "" ||
                    _bloc.MedicenTextController.value == null) {
                  _bloc.fetchMedicine();
                }
              }
              );
            },
          ),
          preferredSize: Size.fromHeight(80)),
      backgroundColor: Color(0xffeeeeee),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: TopMedicinePostHeader(stream: _bloc.streamMedicineFinish,minnExtent: 100,maxxExtent: 300),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Divider(
                  color: kSecondColor,
                ),

                Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    SizedBox(width: 15,),
                    Text("الأدويه",style: TextStyle(fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',fontSize: 20,fontWeight: FontWeight.bold,color: kSecondColor),),
                  ],
                ),

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,

                      child: (_bloc.MedicenTextController.value == null ||
                          _bloc.MedicenTextController.value.trim() == "" ||
                          _bloc.MedicenTextController.value.length == 0)
                          ?
                      StreamBuilder<List<MedicineModel>>(
                        stream: _bloc.streamMedicine,
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

                                return

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ContentWidget(medicineModel: data,),
                                  );
                              },
                              staggeredTileBuilder: (data) =>
                              new StaggeredTile.count(
                                  2, data.isEven ? 3.5 : 3.5),
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0,
                            );
                          } else
                            return Container();
                        },
                      )
                          :
                      StreamBuilder<List<MedicineModel>>(
                        stream: _bloc.streamMedicinesearch,
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

                                return
                                  ContentWidget(medicineModel: data,);
                              },
                              staggeredTileBuilder: (data) =>
                              new StaggeredTile.count(
                                  2, data.isEven ? 3.1 : 3),
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0,
                            );
                          } else
                            return Container();
                        },
                      )),
                ),

              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class SearchDropdownMenu extends StatelessWidget {
  final itemHeight;
  Bloc _bloc;

  SearchDropdownMenu({this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: ClipPath(
              clipper: ArrowClipper(),
              child: Material(
                elevation: 5,
                child: Container(
                  height: 20,
                  width: 30,
                  color: Colors.white,
                ),
              )),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
            elevation: 0,
            child: Container(
              height: 2 * itemHeight + 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  DropdownItems(
                    text: "Donate",
                    onPressed: () {
                      if (Provider.of<InfoProvider>(context).isDropdownOpened) {
                        Provider.of<InfoProvider>(context)
                            .floatingDropdown
                            .remove();
                      }
                      Provider.of<InfoProvider>(context)
                          .changeDropdownOpenedState();
                    },
                  ),
                  DropdownItems(
                    text: "Demond",
                    onPressed: () {
                      if (Provider.of<InfoProvider>(context).isDropdownOpened) {
                        Provider.of<InfoProvider>(context)
                            .floatingDropdown
                            .remove();
                      }
                      Provider.of<InfoProvider>(context)
                          .changeDropdownOpenedState();
                    },
                  ),
                  DropdownItems(
                    text: "Name",
                    onPressed: () {
                      if (Provider.of<InfoProvider>(context).isDropdownOpened) {
                        Provider.of<InfoProvider>(context)
                            .floatingDropdown
                            .remove();
                      }
                      Provider.of<InfoProvider>(context)
                          .changeDropdownOpenedState();
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class DropdownItems extends StatelessWidget {
  final String text;
  final Function onPressed;

  DropdownItems({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      height: 50,
      elevation: 3,
      shape: RoundedRectangleBorder(),
    );
  }
}








class TopMedicinePostHeader implements SliverPersistentHeaderDelegate {
  TopMedicinePostHeader({this.maxxExtent, this.minnExtent, this.stream});
  final double minnExtent;
  final double maxxExtent;
  final Stream stream;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return PostMedicinePersistantHeader(stream: stream);
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












