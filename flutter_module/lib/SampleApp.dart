import 'dart:ui' as ui; // 调用window拿到route判断跳转哪个界面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default value for toggle
  bool toggle = true;



  void _toggle() {
    setState(() {
      toggle = !toggle;
      Map<String,dynamic> tmp = Map<String,dynamic>();

      try{

        FlutterBoost.singleton.channel.sendEvent('sssss', tmp);

      }catch(e){


      }
    });
  }

  _getToggleChild() {
    if (toggle) {
      return Text('Toggle One');
    } else {
      return RawMaterialButton(
        onPressed: () {},
        child: Text('Toggle Two'),
      );
    }


  }
  @override
  void initState() {
    // TODO: implement initState

    FlutterBoost.singleton.channel.addEventListener('name',
            (name, arguments){
          //todo
          toggle = !toggle;
          return;
        });

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: _getToggleChild(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
}