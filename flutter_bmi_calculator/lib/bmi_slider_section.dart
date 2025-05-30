import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bmi_controller.dart';

class BmiSliderSection extends StatelessWidget {
  const BmiSliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bmi = Provider.of<BmiController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEIGHT
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Height", style: TextStyle(color: Colors.white)),
            Text('${bmi.height.toStringAsFixed(0)} cm',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF7FFFD4),
            inactiveTrackColor: Colors.white30,
            thumbColor: Colors.white,
            overlayColor: const Color(0xAA7FFFD4),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            trackHeight: 6,
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider(
            value: bmi.height,
            min: 120,
            max: 220,
            divisions: 20,
            label: bmi.height.toStringAsFixed(0),
            onChanged: (value) => bmi.setHeight(value),
          ),
        ),
        const SizedBox(height: 30),

        // WEIGHT
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Weight", style: TextStyle(color: Colors.white)),
            Text('${bmi.weight.toStringAsFixed(2)} kg',
                style: const TextStyle(color: Colors.white)),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF7FFFD4),
            inactiveTrackColor: Colors.white30,
            thumbColor: Colors.white,
            overlayColor: const Color(0xAA7FFFD4),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            trackHeight: 6,
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider(
            value: bmi.weight,
            min: 30,
            max: 200,
            divisions: 34,
            label: bmi.weight.toStringAsFixed(1),
            onChanged: (value) => bmi.setWeight(value),
          ),
        ),
      ],
    );
  }
}
