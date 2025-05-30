import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bmi_controller.dart';
import '../bmi_slider_section.dart';
import './bmi_result_page.dart';

class BmiScreen extends StatelessWidget {
  const BmiScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(200, 500, 100, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Track Your BMI',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Sliders
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const BmiSliderSection(),
                  ),

                  const SizedBox(height: 40),

                  // Calculate BMI Button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00FFB0), Color(0xFFEFFF9F)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          final bmiController = Provider.of<BmiController>(context, listen: false);
                          final height = bmiController.height;
                          final weight = bmiController.weight;

                          if (height <= 0) return;

                          final bmi = weight / ((height / 100) * (height / 100));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BmiResultPage(bmi: bmi),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          'Calculate BMI',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
