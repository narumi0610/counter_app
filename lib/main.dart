import 'package:counter_app/utils/animation_path.dart';
import 'package:counter_app/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Artboard _riveArtboard;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            rootBundle.load(AnimationPath.star_animations).then((value) {
              final file = RiveFile();
              if (file.import(value)) {
                final artbord = file.mainArtboard;
                artbord.addController(
                    SimpleAnimation(AnimationPath.star_1_animation));
                setState(() {
                  _riveArtboard = artbord;
                });
              }
            });
          });
        },
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImagePath.night_sky_bg,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: math.Random().nextInt(300).toDouble(),
            left: math.Random().nextInt(300).toDouble(),
            child: Container(
              width: 200,
              height: 200,
              child: Visibility(
                visible: _riveArtboard != null,
                child: Rive(artboard: _riveArtboard),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
