import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/constent.dart';



class topHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            color: kMainColor,
          ),
          child: Padding(
            padding:
            const EdgeInsets.only(top: 10, bottom: 5, left: 15, right: 15),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 15,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/me.jpg"),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Blood Donation",
                              style: kTitleHeadLine,
                            ),
                            Text(
                              "Mohmed Khira",
                              style: bigHeadLine,
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 3,
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 0,
                  child: headerCotainer(),
                ),
                Positioned(
                  top: 10,
                  right: -45,
                  child: Container(
                    width: 210,
                    height: 150,
                    child: Image(
                      image: AssetImage(
                        "assets/r.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  left: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "People Need Donation",
                          style: kTitleHeader,
                        ),
                        Spacer(),
                        Text(
                          "See All",
                          style: kTitleHeadLine,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class headerCotainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kSecondColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "28",
                  style: bigHeadLine,
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                "orang yang telha kamu bantu!",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}


