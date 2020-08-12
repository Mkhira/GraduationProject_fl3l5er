


import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/ClothesPost.dart';
import 'package:company_task/Screens/FurintureScreen.dart';
import 'package:company_task/Screens/MedicinePosts.dart';
import 'package:company_task/Screens/profile_screen.dart';
import 'package:company_task/models/charityModel.dart';
import 'package:company_task/models/eventModel.dart';
import 'package:company_task/models/topDonatersmodel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}
class _MainHomePageState extends State<MainHomePage> {
  Bloc _bloc;
  @override
  void initState() {
    Bloc();
    _bloc = Bloc();
    _bloc.fetchEvent();
    _bloc.fetchTopDonators();
    _bloc.fetchcharity();
    _bloc.fetchcharity();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var x = (MediaQuery.of(context).orientation == Orientation.portrait);
    var profileProvider = Provider.of<InfoProvider>(context);
    return  SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
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
                    children: <Widget>[
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          width:
                          MediaQuery.of(context).size.width / 1.5,
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Find your needs',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                              prefix: IconButton(
                                  icon: Icon(
                                    Icons.format_align_left,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {}),
                              border: InputBorder.none,
                            ),
                          )),
                      Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,ProfileScreen.id);
                        },
                        child:Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          width: 65.0,
                          height: 65.0,
                          child:  profileProvider.imageUrlProfile ==
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
              height: MediaQuery.of(context).size.height - 100,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EventHeader(
                      x: x,
                      bloc: _bloc,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 0, left: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Categories",
                              style: HomeHeadreStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          categoryWedgit(
                            onTap: () {
//                                      Provider.of<TaskData>(context)
//                                          .item(context);
                              Navigator.pushNamed(context, MedicinePosts.id);
                              setState(() {
                                Provider.of<InfoProvider>(context).medicineClick = true;

                              });
                            },
                            categoryName: "الدواء",
                          ),
                          categoryWedgit(
                            onTap: () {
                              Navigator.pushNamed(context,ClothesPost.id);
                              setState(() {
                                Provider.of<InfoProvider>(context).medicineClick = false;

                              });
                            },
                            categoryName: "Cloth",
                          ),
                          categoryWedgit(
                            onTap: () {
                              Navigator.pushNamed(context, FurnitureScreen.id);
                              setState(() {
                                Provider.of<InfoProvider>(context).medicineClick = false;

                              });
                            },
                            categoryName: "Furniture",
                          ),
                          categoryWedgit(
                            onTap: () {
                              Provider.of<InfoProvider>(context).Blood(context);

                            },
                            categoryName: "Blood",
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Top Donated Peple",
                              style: HomeHeadreStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: StreamBuilder<List<TopDonatorsModel>>(
                          stream: _bloc.streamtopdonators,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data[index];

                                    return TopDonaorsList(
                                      field: data.field,
                                      image: data.urlImage,
                                      name: data.name,
                                    );
                                  },
                                  itemCount: snapshot.data.length,
                                ),
                              );
                            } else
                              return Container();
                          }),
                    ),
                    Divider(),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20, bottom: 10),
                      child: Text(
                        "Join Charites",
                        style: HomeHeadreStyle,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<List<charityModel>>(
                        stream: _bloc.streamCharity,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CarouselSlider.builder(
                              autoPlay: false,
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 0),
                              height: x ? 220 : 370,
                              itemCount: snapshot.data.length,
                              scrollPhysics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshot.data[index];

                                return Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      .99,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: data.image,
                                            width: (MediaQuery.of(
                                                context)
                                                .orientation ==
                                                Orientation
                                                    .portrait)
                                                ? MediaQuery.of(context)
                                                .size
                                                .width -
                                                100
                                                : 600,
                                            height: (MediaQuery.of(
                                                context)
                                                .orientation ==
                                                Orientation
                                                    .portrait)
                                                ? 150
                                                : 300,
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
                                      Positioned(
                                          left: 15,
                                          bottom: 15,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15),
                                              color: Colors.white,
                                            ),
                                            child: FlatButton(
                                                onPressed: () {},
                                                child: Text("Join")),
                                          ))
                                    ],
                                  ),
                                );
                              },
                            );
                          } else
                            return Container();
                        },
                      ),
                    ),
                    Divider(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF9A110),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: 50,
                                left: x
                                    ? MediaQuery.of(context)
                                    .size
                                    .width /
                                    3.8
                                    : MediaQuery.of(context)
                                    .size
                                    .width /
                                    2.8,
                                child: Text(
                                  "QUTE THE DAY",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Positioned(
                                top: 90,
                                left: x
                                    ? MediaQuery.of(context)
                                    .size
                                    .width /
                                    10
                                    : MediaQuery.of(context)
                                    .size
                                    .width /
                                    3.6,
                                child: Container(
                                  width: x
                                      ? MediaQuery.of(context)
                                      .size
                                      .width /
                                      1.46
                                      : MediaQuery.of(context)
                                      .size
                                      .width /
                                      3,
                                  child:
                                  Center(
                                    child: AutoSizeText(
                                      "يَسْأَلُونَكَ مَاذَا يُنْفِقُونَ قُلْ مَا أَنْفَقْتُمْ مِنْ خَيْرٍ فَلِلْوَالِدَيْنِ وَالْأَقْرَبِينَ وَالْيَتَامَى وَالْمَسَاكِينِ وَابْنِ السَّبِيلِ وَمَا تَفْعَلُوا مِنْ خَيْرٍ فَإِنَّ اللَّهَ بِهِ عَلِيمٌ",
                                      style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,),
                                      minFontSize: 15,
                                      stepGranularity: 15,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                ),
                              ),
                              Positioned(
                                bottom: 110,
                                left:
                                MediaQuery.of(context).size.width /
                                    10,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      1.46,
                                  child: Center(
                                      child: Text(
                                        "صدق اللَّهُ العظيم",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )),
                                ),
                              ),
                              Positioned(
                                bottom: 50,
                                left:
                                MediaQuery.of(context).size.width /
                                    10,
                                child: Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      1.46,
                                  child: Center(
                                      child: Text(
                                        "(QURAN 2:215)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class TopDonaorsList extends StatelessWidget {
  final String name;
  final String image;
  final String field;

  TopDonaorsList({this.name, this.field, this.image});

  @override
  Widget build(BuildContext context) {
    var x = (MediaQuery.of(context).orientation == Orientation.portrait);

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 20, bottom: 5),
      child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  height: 150,
                  width: x
                      ? MediaQuery.of(context).size.width * .25
                      : MediaQuery.of(context).size.width * .15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      imageUrl: "$image",
                      placeholderFadeInDuration: Duration(days: 30),
                      useOldImageOnUrlChange: true,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 35),
                  Text(
                    "$name",
                    style: HomeHeadreStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Container(
                        width: x
                            ? MediaQuery.of(context).size.width / 2
                            : MediaQuery.of(context).size.width / 2,
                        child: Text(
                            "This week $name is the first donater in $field field")),
                  ),
                ],
              )
//
            ],
          )),
    );
  }
}
class categoryWedgit extends StatelessWidget {
  categoryWedgit({this.categoryName, this.onTap});

  Function onTap;
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            child: Center(
                child: Text(
                  '$categoryName',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )),
          ),
        ),
      ),
    );
  }
}
class EventHeader extends StatelessWidget {
  const EventHeader({
    Key key,
    @required Bloc bloc,
    @required this.x,
  })  : _bloc = bloc,
        super(key: key);

  final Bloc _bloc;
  final bool x;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: x ? 395 : 500,
      color: Color(0xffe6e6ea),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
            child: Row(
              children: <Widget>[
                Text(
                  "Trending",
                  style: HomeHeadreStyle,
                ),
                Spacer(
                  flex: 1,
                ),
                Text(
                  "MORE",
                  style: homeLittleHeaderStyle,
                ),
              ],
            ),
          ),
          StreamBuilder<List<EventModel>>(
            stream: _bloc.streamEvent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CarouselSlider.builder(
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    height: x ? 320 : 420,
                    itemCount: snapshot.data.length,
                    scrollPhysics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = snapshot.data[index];

                      return Container(
                        width:
                        x ? MediaQuery.of(context).size.width - 100 : 600,
                        height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                            ? 300
                            : 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: data.imageUrl,
                                  width: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                      ? MediaQuery.of(context).size.width - 100
                                      : 600,
                                  height: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                      ? 200
                                      : 300,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  placeholderFadeInDuration: Duration(days: 30),
                                  useOldImageOnUrlChange: true,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xffffffff).withOpacity(.2),
                                ),
                                width: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                    ? MediaQuery.of(context).size.width - 100
                                    : 600,
                                height: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                    ? 200
                                    : 300,
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: x ? 150 : 240,
                              child: Container(
                                width: 120,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${data.duration}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(" Days left")
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: x ? 135 : 230,
                              child: FlatButton(
                                shape: CircleBorder(),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      color: Color(0xff757575),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffe6e6ea),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              top: 0,
                                              right: 30,
                                              child: RaisedButton(
                                                shape: CircleBorder(),
                                                color: Color(0xffF9A110),
                                                child: Icon(
                                                  Icons.bookmark_border,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Positioned(
                                              top: 60,
                                              left: 20,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 100,
                                                  child: Text(
                                                    data.eventName,
                                                    style: HomeHeadreStyle,
                                                  )),
                                            ),
                                            Positioned(
                                              top: 120,
                                              left: 0,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                          left: 20,
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              1.1,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                "Organized by: ",
                                                                style:
                                                                homeLittleHeaderStyle,
                                                              ),
                                                              Text(
                                                                "Sona3 El hua",
                                                                style:
                                                                HomeHeadreStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SliderEvent(data: data),
                                                      Container(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                  width: 50,
                                                                ),
                                                                Text(
                                                                  "Raisd so far",
                                                                  style:
                                                                  kTitleHeadLine,
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                  "Target",
                                                                  style:
                                                                  kTitleHeadLine,
                                                                ),
                                                                SizedBox(
                                                                  width: 50,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                  width: 65,
                                                                ),
                                                                Text(
                                                                  "${data.amount}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                                Spacer(),
                                                                Text(
                                                                    "(%${((data.amount / data.need) * 100).round()})",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight.w300)),
                                                                SizedBox(
                                                                  width: 50,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(),
                                                      Center(
                                                        child: Container(
                                                          height: 260,
                                                          color:
                                                          Color(0xffe6e6ea),
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              .9,
//                                                              color: Colors.red,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                    20),
                                                                child: Text(
                                                                  "Recent donors",
                                                                  style:
                                                                  kTitleHeadLine,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  CircleAvatar(
                                                                    radius: 35,
                                                                    backgroundImage:
                                                                    AssetImage(
                                                                        "assets/me.jpg"),
                                                                  ),
                                                                  Spacer(
                                                                    flex: 1,
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 32,
                                                                    backgroundImage:
                                                                    AssetImage(
                                                                        "assets/me.jpg"),
                                                                  ),
                                                                  Spacer(
                                                                    flex: 1,
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 30,
                                                                    backgroundImage:
                                                                    AssetImage(
                                                                        "assets/me.jpg"),
                                                                  ),
                                                                  Spacer(
                                                                    flex: 1,
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 27,
                                                                    backgroundImage:
                                                                    AssetImage(
                                                                        "assets/me.jpg"),
                                                                  ),
                                                                  Spacer(
                                                                    flex: 1,
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 24,
                                                                    backgroundColor:
                                                                    Color(
                                                                        0xffF9A110),
                                                                    child: Text(
                                                                      "99+",
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.white),
                                                                    ),
                                                                  ),
                                                                  Spacer(
                                                                    flex: 2,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    200),
                                                                child:
                                                                Container(
                                                                  height: 50,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        20),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Center(
                                                                      child:
                                                                      Text(
                                                                        "Event Details",
                                                                        style:
                                                                        HomeHeadreStyle,
                                                                      )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                  "This event is about bulding a mosqueue in "),
                                                              Text(
                                                                  "quisna where there is no mosque to help people "),
                                                              Text(
                                                                  "to pray try to help us bulding god hous in earth"),
                                                              Text(
                                                                  "god build u house in heven "),
                                                              SizedBox(
                                                                height: 90,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: MaterialButton(
                                                onPressed: () {},
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 3,
                                                      color: Colors.white,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                  BorderRadius.all(
                                                    Radius.circular(30),
                                                  ),
                                                ),
                                                height: 40,
                                                minWidth: 100,
                                                child: Text(
                                                  "Donate",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                elevation: 5,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                color: Colors.white,
                                child: Icon(
                                  Icons.bookmark,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 90,
                              left: 15,
                              child: Text(
                                "${data.eventName}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              left: x ? -15 : -15,
                              child: Container(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: SliderEvent(data: data)),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 100,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Total collected",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Text(
                                      "${data.amount}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        "(%${((data.amount / data.need) * 100).round()})",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300)),
                                    Spacer(
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
class SliderEvent extends StatelessWidget {
  const




  SliderEvent({
    Key key,
    @required this.data,
  }) : super(key: key);

  final EventModel data;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        inactiveTickMarkColor: Colors.grey,
        activeTickMarkColor: Colors.orange,
        disabledActiveTickMarkColor: Colors.grey,
        disabledActiveTrackColor: Colors.orange,
        trackHeight: 10,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
      ),
      child: Slider(
        inactiveColor: Colors.purple,
        activeColor: Colors.orange,
        value: data.amount.toDouble(),
        min: 0.0,
        max: data.need.toDouble(),
        onChanged: null,
      ),
    );
  }
}