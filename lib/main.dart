import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

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
    rootBundle.load('assets/star.riv').then((value) {
      final file = RiveFile();
      if (file.import(value)) {
        final artbord = file.mainArtboard;
        artbord.addController(SimpleAnimation('star_1'));
        setState(() {
          _riveArtboard = artbord;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset('assets/star_bg_2.jpg'),
            // Rive(
            //   artboard: _riveArtboard,
            // ),
          ],
        ),
      ),
    );
  }
}
