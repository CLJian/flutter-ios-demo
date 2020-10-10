import 'dart:ui' as ui; // 调用window拿到route判断跳转哪个界面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/HomePage.dart';
import 'package:flutter_module/SampleApp.dart';
import 'package:flutter_boost/flutter_boost.dart';


void main() {
  runApp(MyApp());
}

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  @override
//  void initState() {
//    super.initState();
//
//    FlutterBoost.singleton.registerPageBuilders({
//      'embeded': (pageName, params, _)=>SampleApp(),
//      'first': (pageName, params, _) => SampleApp(),
//      'second': (pageName, params, _) => SampleApp(),
//      'tab': (pageName, params, _) => SampleApp(),
//      'platformView': (pageName, params, _) => SampleApp(),
//      'flutterFragment': (pageName, params, _) => SampleApp(),
//      ///可以在native层通过 getContainerParams 来传递参数
//      'flutterPage': (pageName, params, _) {
//        print("flutterPage params:$params");
//        return SampleApp();
//      },
//    });
//    FlutterBoost.singleton.addBoostNavigatorObserver(TestBoostNavigatorObserver());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("Sample App"),
//        )
////        title: 'Flutter Boost example',
////        builder: FlutterBoost.init(postPush: _onRoutePushed),
////        home: Container(
////            color:Colors.white
//        );
//  }
//
//  void _onRoutePushed(
//      String pageName, String uniqueId, Map params, Route route, Future _) {
//  }
//}
//class TestBoostNavigatorObserver extends NavigatorObserver{
//  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
//
//    print("flutterboost#didPush");
//  }
//
//  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print("flutterboost#didPop");
//  }
//
//  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
//    print("flutterboost#didRemove");
//  }
//
//  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
//    print("flutterboost#didReplace");
//  }
//}
//
//
//// 根据iOS端传来的route跳转不同界面
//Widget _widgetForRoute(String route) {
//  switch (route) {
//    case 'myApp':
//      return new SampleApp();
//    case 'home':
//      return new SampleApp();
//    default:
//      return new SampleApp();
//  }
//}
//



class MyApp extends StatelessWidget {



  Widget _home(BuildContext context) {
    return new MyHomePage(title: 'Flutter Demo Home Page');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "/home":(BuildContext context) => new HomePage(),
      },
      home: _home(context),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 创建一个给native的channel (类似iOS的通知）
  static const methodChannel = const MethodChannel('com.pages.your/native_get');


  _iOSPushToVC() async {
    await methodChannel.invokeMethod('iOSFlutter', '参数');
  }

  _iOSPushToVC1() async {
    Map<String, dynamic> map = {"code": "200", "data":[1,2,3]};
    await methodChannel.invokeMethod('iOSFlutter1', map);
  }

  _iOSPushToVC2() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod('iOSFlutter2');
    } on PlatformException {
      result = "error";
    }
    if (result is String) {
      print(result);
      showModalBottomSheet(context: context, builder: (BuildContext context) {
        return new Container(
          child: new Center(
            child: new Text(result, style: new TextStyle(color: Colors.brown), textAlign: TextAlign.center,),
          ),
          height: 40.0,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlatButton(onPressed: () {
              _iOSPushToVC();
            }, child: new Text("跳转ios新界面，参数是字符串111")),
            new FlatButton(onPressed: () {
              _iOSPushToVC1();
            }, child: new Text("传参，参数是map，看log")),
            new FlatButton(onPressed: () {
              _iOSPushToVC2();
            }, child: new Text("接收客户端相关内容")),
          ],
        ),
      ),
    );
  }
}

