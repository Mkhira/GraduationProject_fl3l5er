import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

import 'ItemsContent.dart';

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
        appBar: PreferredSize(child:              Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
              color: Color(0xffe6e6ea),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context){
//                             return AddMedicinePostDataScreen();
//                           }));
                    },
                    heroTag: "vc",
                    child: Icon(
                      Icons.add,
                      color: kSecondColor,
                      size: 40,
                    ),
                    elevation: 3,
                    backgroundColor: Colors.white,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width / 1.6,
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          key: Provider.of<InfoProvider>(context).actionKey,
                          onTap: () {
                            if (Provider.of<InfoProvider>(context)
                                .isDropdownOpened) {
                              Provider.of<InfoProvider>(context)
                                  .floatingDropdown
                                  .remove();
                            } else {
                              Provider.of<InfoProvider>(context)
                                  .floatingDropdown =
                                  Provider.of<InfoProvider>(context)
                                      .createFloatingDropdown();
                              Overlay.of(context).insert(
                                  Provider.of<InfoProvider>(context)
                                      .floatingDropdown);
                              Provider.of<InfoProvider>(context)
                                  .findDropdownData();
                            }
                            Provider.of<InfoProvider>(context)
                                .changeDropdownOpenedState();
                          },
                          child: Container(
                            width: 20,
                            height: 60,
                            child: Icon(
                              Icons.format_align_left,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.9,
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 6.0),
                                 child: StreamBuilder(
                                     stream: _bloc.ClothTextStream,
                                     builder: (context, snapshot) {
                                       return TextField(
                                         onChanged: (String text) {
                                           setState(() {
                                             _bloc.updateClothText(text);

                                             print(_bloc.ClothTextController.value);

                                             print(_bloc
                                                 .ClothTextController.value.length);

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
                                                 _bloc.ClothTextController.value ==
                                                     null) {
                                               _bloc.fetchCloth();
                                             }
                                           });
                                         },
                                         decoration: InputDecoration(
                                           hintText: 'Find your needs',
                                           suffixIcon: IconButton(
                                             icon: Icon(
                                               Icons.search,
                                               color: Colors.grey,
                                             ),
                                             onPressed: () {
                                               setState(() {});
                                             },
                                           ),
                                           border: InputBorder.none,
                                         ),
                                       );
                                     }),
                                     ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                      ),
                      width: 65.0,
                      height: 65.0,
                      child:
                      Provider.of<InfoProvider>(context).updatedImage ==
                          null
                          ? Center()
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          Provider.of<InfoProvider>(context)
                              .updatedImage,
                          fit: BoxFit.cover,
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
            preferredSize: Size.fromHeight(80)),
        backgroundColor: kMainColor,
        body: CustomScrollView(
          slivers: <Widget>[

            SliverPersistentHeader(
                    pinned: false,
                    floating: false,
                    delegate: TopClothesPostHeader(maxxExtent: 250,minnExtent: 100,stream: _bloc.streamClothFinish),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                 SizedBox(height: 15),

                       Padding(
                         padding: const EdgeInsets.only(left: 10.0, right: 10),
                         child: Container(
                             width: MediaQuery.of(context).size.width,
                             height: 650,
                             child: (_bloc.ClothTextController.value == null ||
                                 _bloc.ClothTextController.value.trim() == "" ||
                                 _bloc.ClothTextController.value.length == 0)
                                 ?
                             StreamBuilder<List<ClothModel>>(
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

                                       return

                                         ContentWidget(clothModel: data,);
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
                                 :
                             StreamBuilder<List<ClothModel>>(
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

                                       return
                                         ContentWidget(clothModel: data,);
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
  TopClothesPostHeader({this.maxxExtent, this.minnExtent,this.stream});
  final double minnExtent;
  final double maxxExtent;
  final Stream stream;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
    color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(height: 240,
            child: Padding(
              padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
              child: StreamBuilder<List<ClothModel>>(
                stream: stream,
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return      ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        var data = snapshot.data[index];

                        return    Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kSecondColor,

                            ),
                            width: 180,
                            height: 240,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 130,
                                  width: 197,
                                  child: ClipRRect(

                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl: data.imageUrl,
                                       width: 182,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      placeholder: (context,
                                          url) =>
                                          CircularProgressIndicator(),
                                      errorWidget:
                                          (context, url, error) =>
                                          Icon(Icons.error),
                                      placeholderFadeInDuration:
                                      Duration(days: 30),
                                      useOldImageOnUrlChange:
                                      true,
                                      filterQuality:
                                      FilterQuality.low,
                                    ),
                                  ),
                                ),


                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("${data.name}",style: TextStyle(color: Colors.white),),
                                    Text(" : الملبس",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                                    SizedBox(
                                      width: 5,
                                    ),


                                  ],),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("${data.amount}",style: TextStyle(color: Colors.white),),
                                    Text(" : القطع",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                                    SizedBox(
                                      width: 5,
                                    ),


                                  ],),



                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("${data.state}",style: TextStyle(color: Colors.white),),
                                    Text(" : الحاله",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87),),
                                    SizedBox(
                                      width: 5,
                                    ),


                                  ],),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                  } else return Container();
                },

              ),
            ),
          ),
        ],
      )
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

class ContentWidget extends StatelessWidget {
  final ClothModel clothModel;
  ContentWidget({this.clothModel});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ItemContent(phone: clothModel.phone,name: clothModel.name,location: clothModel.location,imageUrl: clothModel.imageUrl,amount: clothModel.amount,
            dayLeft: clothModel.dayLeft,owner: clothModel.owner,state: clothModel.state,
          );
        }));
      },
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kSecondColor,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: clothModel.imageUrl,
                    width: MediaQuery.of(context)
                        .size
                        .width /2.18,
                    height: 180,
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
                top: 192,
                left: 15,
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      2.2,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Name: ",
                        style: TextStyle(
                            color: Colors.white),
                      ),
                      Text(
                        "${clothModel.name}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                            FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 217,
                left: 15,
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      2.2,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Owner: ",
                        style: TextStyle(
                            color: Colors.white),
                      ),
                      Text(
                        "${clothModel.owner}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                            FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 243,
                left: 15,
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      2.2,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Phone: ",
                        style: TextStyle(
                            color: Colors.white),
                      ),
                      Text(
                        "0${clothModel.phone}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                            FontWeight.bold,fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 260,
                left: 15,
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      2.2,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "State: ",
                        style: TextStyle(
                            color: Colors.white),
                      ),
                      Text(
                        "${clothModel.state}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight:
                            FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
