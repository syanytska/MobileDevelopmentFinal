import 'package:flutter/material.dart';

class BmiTipsPage extends StatelessWidget {
  const BmiTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // === Background image ===
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BMIBackground.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),

          // === Foreground content ===
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(40, 200, 40, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tips for a Healthy BMI",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),

                  tipTile("🏋️ Stay Active", "Aim for at least 30 minutes of moderate exercise most days."),
                  tipTile("🥗 Eat Balanced Meals", "Fill your plate with vegetables, lean protein, and whole grains."),
                  tipTile("💧 Drink Water", "Replace sugary drinks with water. Hydration helps metabolism."),
                  tipTile("🛌 Sleep Well", "7–9 hours of sleep improves hormone balance and weight management."),
                  tipTile("📉 Track Progress", "Keep track of your weight and BMI to stay motivated."),
                  tipTile("🧠 Mental Health", "Stress and mental well-being affect physical health too."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tipTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
