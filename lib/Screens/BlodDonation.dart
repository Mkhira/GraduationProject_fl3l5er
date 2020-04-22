import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/constent.dart';
import '../wedgit/BloodHeaderWidget.dart';
import '../wedgit/caruselWedgit.dart';
import '../wedgit/bloodWedgit.dart';

class BloodDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      body: CustomScrollView(),
    ));
  }
}

