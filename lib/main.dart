import 'package:flutter/material.dart';
import 'package:my_app/drawer/DrawerLikeGoogle.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          appBar: AppBar(
            title: Text('This is title!'),
            backgroundColor: Colors.blue,
          ),
          drawer: DrawerLikeGoogle(),
          body: HomePage(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            child: Container(
              child: Icon(
                Icons.add,
                size: 25,
                textDirection: TextDirection.ltr,
              ),
            ),
            backgroundColor: Colors.red,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final a = 0;

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Hello World!")));
  }
}
