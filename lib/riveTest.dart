import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() => runApp(MaterialApp(
      home: MyRiveAnimation(),
    ));

class MyRiveAnimation extends StatelessWidget {

  // final riveFile = await RiveFile.asset('assets/rive/dumble_heart.riv');

// RiveAnimation.direct(riveFile);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        height: 200,
        width: 200,
        child: Center(
          heightFactor: ArtboardBase.heightInitialValue,
          widthFactor: ArtboardBase.widthInitialValue,
          child: RiveAnimation.asset(
            'assets/rive/dumble_heart.riv',
          ),
        ),
      ),
    );
  }
}
