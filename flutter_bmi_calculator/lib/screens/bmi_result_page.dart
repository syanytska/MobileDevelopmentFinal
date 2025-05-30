import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bmi_tips_page.dart';

class BmiResultPage extends StatelessWidget {
  final double bmi;

  const BmiResultPage({super.key, required this.bmi});

  String getBmiCategory() {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  String getBmiTip() {
    if (bmi < 18.5) return "Try a nutrient-rich diet and talk to a doctor.";//underweight
    if (bmi < 25) return "You’re in a healthy range! Keep it up.";//normal
    if (bmi < 30) return "Include more physical activity in your routine.";//overweight
    return "Consider working with a healthcare provider for a plan.";//obese
  }

  Color getBmiColor() {
    if (bmi < 18.5) return Colors.orange;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.yellow[700]!;
    return Colors.red;
  }

  double getBmiMarkerPosition(BuildContext context) {
    // Map BMI range (15–40) to screen width
    final min = 15.0;
    final max = 40.0;
    double clamped = bmi.clamp(min, max);
    double relative = (clamped - min) / (max - min);
    return MediaQuery.of(context).size.width * relative - 8;
  }

  Future<void> _launchMoreInfo() async {
    final Uri url = Uri.parse('https://www.cdc.gov/healthyweight/index.html');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = getBmiCategory();
    final color = getBmiColor();
    final tip = getBmiTip();
    final markerPosition = getBmiMarkerPosition(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Your BMI Result")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Your BMI is", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(
              bmi.toStringAsFixed(1),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 12),
            Text(category, style: TextStyle(fontSize: 24, color: color)),
            const SizedBox(height: 24),
            Text(tip, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
            const SizedBox(height: 24),

            const Text("BMI Category Scale", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),

            // Gradient bar with pointer
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.green, Colors.yellow, Colors.red],
                      stops: [0.1, 0.35, 0.65, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  left: markerPosition,
                  child: const Icon(Icons.arrow_drop_up, size: 32, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Under"),
                Text("Normal"),
                Text("Over"),
                Text("Obese"),
              ],
            ),

            const SizedBox(height: 32),

            // Learn more button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BmiTipsPage()),
                );
              },
              child: const Text("Learn more about BMI →"),
            ),

          ],
        ),
      ),
    );
  }
}
