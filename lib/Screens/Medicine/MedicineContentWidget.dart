




import 'package:company_task/Screens/ItemsContent.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/wedgit/PostsWidget/PostMaterialWedgit.dart';
import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  final MedicineModel medicineModel;
  ContentWidget({this.medicineModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ItemContent(
              phone: medicineModel.phone,
              name: medicineModel.name,
              location: medicineModel.location,
              imageUrl: medicineModel.imageUrl,
              amount: medicineModel.amount,
              dayLeft: medicineModel.dayLeft,
              owner: medicineModel.owner,
              state: medicineModel.state,
              userImage: medicineModel.userImage,
              information: "معلومات عن الدواء ",
              description: medicineModel.description,
              userId: medicineModel.userID,
              ownerName: medicineModel.ownerName,
              typeState: "",

            );
          }));
        },
        child:
        PostsMaterial(type: "الدواء",state: medicineModel.state,phone: medicineModel.phone,name: medicineModel.name,imageUrl: medicineModel.imageUrl,owner: medicineModel.owner,)
    );
  }
}