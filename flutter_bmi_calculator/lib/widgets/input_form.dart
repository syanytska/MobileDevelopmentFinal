import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final VoidCallback onSubmit;

  const InputForm({
    super.key,
    required this.usernameController,
    required this.heightController,
    required this.weightController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: heightController,
          decoration: InputDecoration(labelText: 'Height (cm)'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: weightController,
          decoration: InputDecoration(labelText: 'Weight (kg)'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text('Calculate BMI'),
        ),
      ],
    );
  }
}
