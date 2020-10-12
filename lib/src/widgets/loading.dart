import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eRestaurant/src/helpers/style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: bg,
        child: SpinKitCircle(
          color: black,
          size: 50,
        ));
  }
}
