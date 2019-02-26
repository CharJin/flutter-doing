import 'package:flutter/material.dart';

class DrawerLikeGoogle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerLikeGoogle();
}

class _DrawerLikeGoogle extends State<DrawerLikeGoogle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 200.0,
            height: 200.0,
            color: Colors.black12,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              child: Icon(
                Icons.home,
                size: 40.0,
              ),
            )),
      ],
    );
  }
}
