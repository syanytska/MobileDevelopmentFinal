import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'bmi_controller.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final bmi = Provider.of<BmiController>(context);

    // Uniform scale (weight)
    final double scale = (bmi.weight / 60).clamp(0.8, 1.5);
    // Height stretch
    final double stretchY = (bmi.height / 160).clamp(0.8, 1.5);

    return Center( // <- centers in parent space
      child: Transform(
        alignment: Alignment.center, // <- scales from the center of the image
        transform: Matrix4.identity()
          ..scale(scale, stretchY),
        child: const SizedBox(
          height: 200,
          child: RiveAnimation.asset(
            'assets/animations/character_boy.riv',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
