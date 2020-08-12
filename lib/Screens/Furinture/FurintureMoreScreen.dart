











import 'package:company_task/Block/Block.dart';
import 'file:///E:/flater_projects/company_task/lib/Screens/Furinture/FurintureScreen.dart';
import 'package:company_task/models/FurintureModel.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts_arabic/fonts.dart';

class FurnitureMoreScreen extends StatefulWidget {
  @override
  _FurnitureMoreScreenState createState() => _FurnitureMoreScreenState();
}

class _FurnitureMoreScreenState extends State<FurnitureMoreScreen> {
  Bloc _bloc = Bloc();
  @override
  void initState() {
    // TODO: implement initState
    _bloc.fetchFurnitureFinish();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
          backgroundColor: kSecondColor,
          title: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text("  المزيد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic'),),
            ],
          )
      ),
      body: SingleChildScrollView(


        child: Column(
          children: <Widget>[

            SizedBox(
              height: 15,

            ),
            Text("  الأثاث",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: kSecondColor),)
            , SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<List<FurnitureModel>>(
                stream: _bloc.streamFurnitureFinish,
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
                          ContentWidget(furnitureModel:   data,);
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
              ),
            )
          ],
        ),
      ),
    ));
  }
}
