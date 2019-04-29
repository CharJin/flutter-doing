import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.red),
      home: MyHomePage(title: 'Flutter Demo Home Page', sum: 100),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.sum}) : super(key: key);
  final String title;
  final int sum;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0, _currentIndex = 0;
  var _ipAddress = "192.168.1.254";
  bool _isDrawerUserInfo = false;
  void _incrementCounter() {
    if (this._counter > widget.sum) {
      Fluttertoast.showToast(
          msg: 'greatere than the sum!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 15,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }
    setState(() {
      _counter++;
    });
  }

  _getIPAddress() async {
    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        // json = JsonUtf8Encoder()
        var data = JsonEncoder().convert(json);
        result = data;
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;
    Fluttertoast.showToast(
      msg: result,
    );

    setState(() {
      _ipAddress = result;
    });
  }

  Widget _getDrawerList() {
    if (_isDrawerUserInfo)
      return Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: new Text('Drawer item A'),
            subtitle: new Text("hehe hehe "),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: new Text('Drawer item B'),
            onTap: () => {},
          ),
        ],
      );
    else
      return Column(
        children: <Widget>[
          new ClipRect(
            child: new ListTile(
              leading: new CircleAvatar(child: new Text("A")),
              title: new Text('Drawer item A'),
              onTap: () => Navigator.pop(context),
            ),
          ),
          new ListTile(
            leading: new CircleAvatar(child: new Text("B")),
            title: new Text('Drawer item B'),
            subtitle: new Text("Drawer item B subtitle"),
            onTap: () => {},
          ),
          new AboutListTile(
            icon: new CircleAvatar(child: new Text("Ab")),
            child: new Text("About"),
            applicationName: "Test",
            applicationVersion: "1.0",
            applicationIcon: Icon(Icons.info),
            applicationLegalese: "applicationLegalese",
            aboutBoxChildren: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text("aboutBoxChildren"),
              )
            ],
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                    color: Colors.blue,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Text(
                          "Button",
                          style: TextStyle(color: Colors.white),
                        )),
                    onPressed: () {
                      _getIPAddress();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Text(
              // 'You have pushed the button this many times:',
              '$_ipAddress',
              maxLines: 20,
            ),
          ],
        ),
      ),
      ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemExtent: 20.0,
        itemBuilder: (BuildContext context, int index) {
          return Text('entry $index');
        },
      ),
      Center(
          child: Icon(
        Icons.forum,
        size: 50,
      )),
    ];
    final _kBottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: Colors.transparent,
          title: Text("Home")),
      BottomNavigationBarItem(
          icon: Icon(Icons.alarm),
          backgroundColor: Colors.transparent,
          title: Text("Alarm")),
      BottomNavigationBarItem(
          icon: Icon(Icons.forum),
          backgroundColor: Colors.transparent,
          title: Text("Forum")),
    ];
    var _floatingButton = FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add_box),
    );

    if (_currentIndex != 0) {
      _floatingButton = null;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.red,
        // leading: Icon(Icons.tag_faces),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.terrain),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.watch_later),
            onPressed: () {},
          ),
        ],
      ),
      body: _kTabPages[_currentIndex],
      floatingActionButton: _floatingButton,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        items: _kBottomNavBarItems,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          //点击tap时 会传入所点击的tap的index，然后使用setState更改状态来重新渲染UI
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("charjincser@gmail.com"),
              accountName: Text("Char Jin"),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Image.network("https://timgsa.baidu.com/timg?image&" +
                    "quality=80&size=b9999_10000&sec=1557072371&di=e1793fe4d5c049f310d8fdab64cd3c16&" +
                    "imgtype=jpg&er=1&src=http%3A%2F%2Fwww.kingcamp.com.cn%2Fuploads%2Fallimg%2F110902%2F" +
                    "8-110Z2120623547.jpg"),
              ),

              //  CircleAvatar(
              //   backgroundColor: Colors.red,
              // ),
              margin: EdgeInsets.zero,
              onDetailsPressed: () {
                setState(() {
                  _isDrawerUserInfo = !_isDrawerUserInfo;
                });
              },
            ),
            _getDrawerList(),
          ],
        ),
      ),
    );
  }
}
