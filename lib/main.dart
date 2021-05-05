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
      theme: ThemeData(fontFamily: 'Comfortaa'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Artboard _starArtboard;
  Artboard _rabitArtboard;
  final List starAnimations = [
    AnimationPath.star_1_animation,
    AnimationPath.star_2_animation,
    AnimationPath.star_3_animation,
    AnimationPath.star_4_animation,
    AnimationPath.star_5_animation,
  ];
  String starAnimation = '';
  int count = 0;

  @override
  void initState() {
    rootBundle.load(AnimationPath.rabit_roop_animation).then((value) {
      final file = RiveFile();
      if (file.import(value)) {
        final rabitArtbord = file.mainArtboard;
        rabitArtbord
            .addController(SimpleAnimation(AnimationPath.rabit_animation));
        setState(() {
          _rabitArtboard = rabitArtbord;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String shuffle = () {
      starAnimations.shuffle();
      return starAnimation = starAnimations[0];
    }();

    final starsAnimation = Positioned(
      top: math.Random().nextInt(300).toDouble(),
      left: math.Random().nextInt(300).toDouble(),
      child: Container(
        width: 200,
        height: 200,
        child: Visibility(
          visible: _starArtboard != null,
          child: Rive(artboard: _starArtboard),
        ),
      ),
    );

    final rabitAnimation = Container(
      width: 350,
      height: 350,
      child: Visibility(
        visible: _rabitArtboard != null,
        child: Rive(artboard: _rabitArtboard),
      ),
    );

    final countText = Align(
        alignment: Alignment.center,
        child: Opacity(
          opacity: 0.1,
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 200.0,
              color: Colors.white,
              fontFamily: "Comfortaa",
            ),
          ),
        ));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImagePath.night_sky_bg,
              fit: BoxFit.fill,
            ),
          ),
          starsAnimation,
          countText,
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  rootBundle.load(AnimationPath.star_animations).then((value) {
                    final file = RiveFile();
                    if (file.import(value)) {
                      final starArtbord = file.mainArtboard;
                      starArtbord.addController(SimpleAnimation(shuffle));
                      setState(() {
                        _starArtboard = starArtbord;
                      });
                    }
                  });
                });
                count++;
              },
              onLongPress: () {
                setState(() {
                  count = 0;
                });
              },
              child: rabitAnimation,
            ),
          ),
        ],
      ),
    );
  }
}
