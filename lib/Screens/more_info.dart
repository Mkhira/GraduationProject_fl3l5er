import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          //color: Color(0xFF04022B),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'More Information',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  UserInfo(
                    data: Provider.of<InfoProvider>(context).email,
                    icon: Icons.email,
                    colour: Colors.white,
                    field: 'Email',
                  ),
                  UserInfo(
                    data: Provider.of<InfoProvider>(context).phone,
                    icon: Icons.phone_android,
                    colour: Colors.white,
                    field: 'Phone',
                  ),
                  UserInfo(
                    data:
                    '${Provider.of<InfoProvider>(context).updatedDay}/${Provider.of<InfoProvider>(context).updatedMonth}/'
                        '${Provider.of<InfoProvider>(context).updatedYear}',
                    icon: Icons.cake,
                    colour: Colors.white,
                    field: 'Birth Date',
                  ),
                  UserInfo(
                    data: Provider.of<InfoProvider>(context).updatedGender,
                    icon: Icons.perm_identity,
                    colour: Colors.white,
                    field: 'Gender',
                  ),
                  UserInfo(
                    data: Provider.of<InfoProvider>(context).updatedStatus,
                    icon: Icons.people,
                    colour: Colors.white,
                    field: 'Status',
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border:
                          Border.all(color: Color(0xffDAD9DC), width: 2.0)),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      width: 45,
                      height: 45,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final IconData icon;
  final String data, field;
  final Color colour;

  const UserInfo(
      {@required this.icon,
        @required this.data,
        @required this.colour,
        @required this.field});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: Icon(icon, color: colour),
            title: Text(
              field,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                color: colour,
              ),
            ),
            subtitle: Text(
              data,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                color: colour,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
