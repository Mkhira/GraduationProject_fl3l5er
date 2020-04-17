import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String image,title,subtitle,category;

  ListItem({this.image, this.title, this.subtitle, this.category});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              child: Image.asset(
                image,
                width: 310,
                height: 300,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
