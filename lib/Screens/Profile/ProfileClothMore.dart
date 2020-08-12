



import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/Medicine/MedicineContentWidget.dart';
import 'package:company_task/Screens/Profile/profile_screen.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/service/deleteService.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts_arabic/fonts.dart';

class ProfileClothMoreScreen extends StatefulWidget {
  @override
  _ProfileClothMoreScreenState createState() => _ProfileClothMoreScreenState();
}

class _ProfileClothMoreScreenState extends State<ProfileClothMoreScreen> {
  Bloc _bloc = Bloc();
  Delete delete = Delete();
  @override
  void initState() {
    // TODO: implement initState
    _bloc.fetchClothProfileData(context);

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
            Text("منشورات الأدويه",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',color: kSecondColor),)
            , SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<List<ClothModel>>(
                stream: _bloc.streamClothProfile,
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
                            padding: const EdgeInsets.only(left: 3,right: 0),
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
                      },
                      staggeredTileBuilder: (data) =>
                      new StaggeredTile.count(
                          2, data.isEven ? 3.1 : 3.1),
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
