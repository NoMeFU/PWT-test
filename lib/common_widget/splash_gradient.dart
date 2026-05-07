import 'package:flutter/material.dart';
import 'package:lawbug829/gen/assets.gen.dart';
class SplashGradient extends StatelessWidget {
  const SplashGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.images.splashGradient.path,
      fit: BoxFit.cover,
    );
  }
}