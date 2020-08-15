import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:company_task/Screens/Cloth/ClothMoreScreen.dart';
import 'package:company_task/Screens/Furinture/FurintureMoreScreen.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Medicine/MoreScreen.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/models/FurintureModel.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class PostClothPersistantHeader extends StatelessWidget {
  const PostClothPersistantHeader({
    Key key,
    @required this.stream,
  }) : super(key: key);

  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffeeeeee),
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 23,
                    ),
                    Text(
                      "البوستات الحرجه",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: ArabicFonts.Amiri,
                          package: 'google_fonts_arabic',
                          color: Colors.black),
                    ),

                    Spacer(),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClothMoreScreen()));
                        },
                        child: Text(
                          "  المزيد",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              fontFamily: ArabicFonts.Amiri,
                              package: 'google_fonts_arabic'),
                        )),
//                  SizedBox(width: 5,)
                  ],
                )),
            Container(
              height: 240,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
                child: StreamBuilder<List<ClothModel>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  width: 175,
                                  height: 220,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: 130,
                                          width: 175,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20)),
                                            child: CachedNetworkImage(
                                              imageUrl: data.imageUrl,
                                              width: 175,
                                              height: 120,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              placeholderFadeInDuration:
                                                  Duration(days: 30),
                                              useOldImageOnUrlChange: true,
                                              filterQuality: FilterQuality.low,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            AutoSizeText(
                                              'الملابس: ${data.name}',
                                              style: TextStyle(
                                                  fontFamily: ArabicFonts.Amiri,
                                                  package:
                                                      'google_fonts_arabic',
                                                  fontWeight: FontWeight.bold),
                                              presetFontSizes: [12.0, 5.0, 4.0],
                                              maxLines: 1,
                                            ),
                                            Text(
                                              "القطع: ${data.amount}",
                                              style: kPostStyleArabicBase,
                                            ),
                                            Text("الحاله: ${data.state}",
                                                style: kPostStyleArabicBase),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else
                      return Container();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class PostMedicinePersistantHeader extends StatelessWidget {
  const PostMedicinePersistantHeader({
    Key key,
    @required this.stream,
  }) : super(key: key);

  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return
      Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffeeeeee),
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 23,
                      ),
                      Text(
                        "البوستات الحرجه",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: ArabicFonts.Amiri,
                            package: 'google_fonts_arabic',
                            color: Colors.black),
                      ),

                      Spacer(),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FurnitureMoreScreen()));
                          },
                          child: Text(
                            "  المزيد",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: ArabicFonts.Amiri,
                                package: 'google_fonts_arabic'),
                          )),
//                  SizedBox(width: 5,)
                    ],
                  )),
              Container(
                height: 240,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10,),
                  child: StreamBuilder<List<MedicineModel>>(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[index];

                            return Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(20),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    width: 175,
                                    height: 220,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 130,
                                            width: 175,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(20)),
                                              child: CachedNetworkImage(
                                                imageUrl: data.imageUrl,
                                                width: 175,
                                                height: 120,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                                placeholderFadeInDuration:
                                                Duration(days: 30),
                                                useOldImageOnUrlChange: true,
                                                filterQuality: FilterQuality.low,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    'الدواء: ${data.name}',
                                                    style: TextStyle(
                                                        fontFamily: ArabicFonts.Amiri,
                                                        package:
                                                        'google_fonts_arabic',
                                                        fontWeight: FontWeight.bold),
                                                    presetFontSizes: [12.0, 5.0, 4.0],
                                                    maxLines: 1,
                                                  ),
                                                  Text(
                                                    "القطع: ${data.amount}",
                                                    style: kPostStyleArabicBase,
                                                  ),
                                                  Text("الحاله: ${data.state}",
                                                      style: kPostStyleArabicBase),
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
            ],
          ));

  }
}

class PostFurniturePersistantHeader extends StatelessWidget {
  const PostFurniturePersistantHeader({
    Key key,
    @required this.stream,
  }) : super(key: key);

  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffeeeeee),
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 23,
                    ),
                    Text(
                      "البوستات الحرجه",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: ArabicFonts.Amiri,
                          package: 'google_fonts_arabic',
                          color: Colors.black),
                    ),

                    Spacer(),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FurnitureMoreScreen()));
                        },
                        child: Text(
                          "  المزيد",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              fontFamily: ArabicFonts.Amiri,
                              package: 'google_fonts_arabic'),
                        )),
//                  SizedBox(width: 5,)
                  ],
                )),
            Container(
              height: 240,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                child: StreamBuilder<List<FurnitureModel>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  width: 175,
                                  height: 220,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: 130,
                                          width: 175,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20)),
                                            child: CachedNetworkImage(
                                              imageUrl: data.imageUrl,
                                              width: 175,
                                              height: 120,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              placeholderFadeInDuration:
                                                  Duration(days: 30),
                                              useOldImageOnUrlChange: true,
                                              filterQuality: FilterQuality.low,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            AutoSizeText(
                                              'الأثاث: ${data.name}',
                                              style: TextStyle(
                                                  fontFamily: ArabicFonts.Amiri,
                                                  package:
                                                      'google_fonts_arabic',
                                                  fontWeight: FontWeight.bold),
                                              presetFontSizes: [12.0, 5.0, 4.0],
                                              maxLines: 1,
                                            ),
                                            Text(
                                              "القطع: ${data.amount}",
                                              style: kPostStyleArabicBase,
                                            ),
                                            Text("الحاله: ${data.state}",
                                                style: kPostStyleArabicBase),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else
                      return Container();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
