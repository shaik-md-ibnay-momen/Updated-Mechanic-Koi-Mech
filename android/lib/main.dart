import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mechanic_koi_mechanic/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:mechanic_koi_mechanic/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqlcipher/sqlcipher.dart';
import 'package:flutter_sqlcipher/sqlite.dart';
import 'dart:io' as io;
import 'tween.dart';
var user;
Map<dynamic, dynamic> map10;

void main(){
  runApp(MaterialApp(
    home: splashscreen(),
  ));
}
class splashscreen extends StatefulWidget {

  @override
  _splashscreenState createState() => _splashscreenState();

}

class _splashscreenState extends State<splashscreen> {

  static Database db;
  String id;
  @override
  void initState() {
    // chk();
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4),
            () =>getMechdata());

          //  ()=>

           // Navigator.push(context,
            //    MaterialPageRoute(builder: (context)=>LoginPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            //  height: deviceInfo.size.height,
            // width: deviceInfo.size.width,
            /* height: 100,
              width: 100,
              child: Image.asset('images/splashimage.png'),*/
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/splashimage.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
           Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                     /*   CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60.0,
                          child: Image.asset('images/splashicon.png'),
                        )*/
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitFadingCube(),
                   /* CircularProgressIndicator(backgroundColor: Colors.white,),
                    Padding(padding: EdgeInsets.only(top: 20.0),
                    ),*/
                   SizedBox(height: 50,),
                    Text("One click Vehicle Mechanic",style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ],
          )
        ],
      ),

    );

  }





  getMechdata() async {
    user = await FirebaseAuth.instance.currentUser();

    if(user!=null){
      Firestore.instance
          .collection('Mechanic Data')
          .document(user.uid)
          .get()
          .then((DocumentSnapshot ds) {
        // use ds as a snapshot
        map10 = ds.data;
        print(map10['Name']);
        noti=map10['Name'];

        print(map10['Name']);
        print(map10);

        // propage(map2);
        //    clPro();
        chk();
      });


    }

    else{
      chk();

    }


    // meckCheck();
    //propage(map2);
  }


  void chk() async {
    user = await FirebaseAuth.instance.currentUser();
    print("sfzf");
    print("dzff");
    if(user!=null){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => homepage(user)));
    }
    else{
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => LoginPage()));
    };

    //chk2();
    }


}



class SpinKitFadingCube extends StatefulWidget {
  const SpinKitFadingCube({
    Key key,
    this.color= Colors.blue,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2400),
    this.controller,
  })  : assert(!(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
  'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color color;
  final double size;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;
  final AnimationController controller;

  @override
  _SpinKitFadingCubeState createState() => _SpinKitFadingCubeState();
}

class _SpinKitFadingCubeState extends State<SpinKitFadingCube> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: Center(
          child: Transform.rotate(
            angle: -45.0 * 0.0174533,
            child: Stack(
              children: List.generate(4, (i) {
                final _size = widget.size * 0.5, _position = widget.size * .5;
                return Positioned.fill(
                  top: _position,
                  left: _position,
                  child: Transform.scale(
                    scale: 1.1,
                    origin: Offset(-_size * .5, -_size * .5),
                    child: Transform(
                      transform: Matrix4.rotationZ(90.0 * i * 0.0174533),
                      child: Align(
                        alignment: Alignment.center,
                        child: FadeTransition(
                          opacity: DelayTween(begin: 0.0, end: 1.0, delay: 0.3 * i).animate(_controller),
                          child: SizedBox.fromSize(size: Size.square(_size), child: _itemBuilder(i)),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color));
}