
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../style/constent.dart';




class BloodListBuilder extends StatelessWidget {
  const BloodListBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InfoProvider>(
      builder: (context, BloodList, chilid) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final list = BloodList.bloodList[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: donationList(
                name: list.name,
                description: list.description,
                imageUrl: list.imageUrl,
                icon: list.icon,
                blood: list.blood,
              ),
            );
          },
          itemCount: BloodList.bloodListCount,
        );
      },
    );
  }
}

class donationList extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final String blood;
  final IconData icon;
  donationList(
      {this.imageUrl, this.icon, this.name, this.description, this.blood});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kMainColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imageUrl),
              ),
              Spacer(
                flex: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    name,
                    style: bigHeadLine,
                  ),
                  Text(
                    description,
                    style: kTitleHeadLine,
                  ),
                ],
              ),
              Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    blood,
                    style: kBlood,
                  ),
                  Icon(
                    icon,
                    color: kSecondColor,
                    size: 15,
                  )
                ],
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

