import 'package:company_task/Block/Block.dart';
import 'package:company_task/Screens/Blood/NeedyData.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/BloodNeedyModel.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            forceElevated: true,
            elevation: 5,
            backgroundColor: kMainColor,
            expandedHeight: 300,
            leading: Text(""),
            flexibleSpace: Stack(
              children: <Widget>[topHeader()],
            ),
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
