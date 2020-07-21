import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/Screens/Add%20Medicen%20Post.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../Block/Block.dart';
import '../style/constent.dart';
import 'ItemsContent.dart';

class Items extends StatefulWidget {
  static const String id = 'items';

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  Bloc _bloc;
  String x = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Bloc();
    _bloc = Bloc();
    _bloc.fetchMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: MainDrawer(),
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Container(
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
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AddMedicinePostScreen();
                          }));
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
                                    stream: _bloc.textStream,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        onChanged: (String text) {
                                          setState(() {
                                            _bloc.updateText(text);

                                            print(_bloc
                                                .textController.value.length);

                                            x = text;

                                            if (_bloc.textController.value
                                                    .length >=
                                                1) {
                                              _bloc.search();
                                            } else if (_bloc.textController
                                                        .value.length ==
                                                    0 ||
                                                _bloc.textController.value
                                                        .trim() ==
                                                    "" ||
                                                _bloc.textController.value ==
                                                    null) {
                                              _bloc.fetchMedicine();
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 650,
                  child: (_bloc.textController.value == null ||
                          _bloc.textController.value.trim() == "" ||
                          _bloc.textController.value.length == 0)
                      ?
                  StreamBuilder<List<MedicineModel>>(
                          stream: _bloc.streamMedicine,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return new StaggeredGridView.countBuilder(
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
                                        2, data.isEven ? 3.25 : 3),
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
                                        2, data.isEven ? 3.25 : 3),
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



class ContentWidget extends StatelessWidget {
  final MedicineModel medicineModel;
  ContentWidget({this.medicineModel});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ItemContent(phone: medicineModel.phone,name: medicineModel.name,location: medicineModel.location,imageUrl: medicineModel.imageUrl,amount: medicineModel.amount,
          dayLeft: medicineModel.dayLeft,owner: medicineModel.owner,state: medicineModel.state,
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
                    imageUrl: medicineModel.imageUrl,
                    width: MediaQuery.of(context)
                        .size
                        .width /
                        2.18,
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
                top: 195,
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
                        "${medicineModel.name}",
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
                top: 220,
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
                        "${medicineModel.owner}",
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
                top: 245,
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
                        "0${medicineModel.phone}",
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
                top: 270,
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
                        "${medicineModel.state}",
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
