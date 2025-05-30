import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'bmi_controller.dart';
import '../screens/bmi_result_page.dart';

class BmiSubmitButton extends StatelessWidget {
  const BmiSubmitButton({super.key});

  Future<void> _handleSubmit(BuildContext context) async {
    final bmi = Provider.of<BmiController>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final username = prefs.getString('username'); // 👈 grab it here

    if (userId == null || username == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
      return;
    }

    final url = Uri.parse('https://localhost:7144/api/BMIRecords/PostRecords');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('jwt') ?? ''}',
        },
        body: jsonEncode({
          'userId': userId,
          'username': username, 
          'heightCm': bmi.height,
          'weightKg': bmi.weight,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final bmiValue = (data['bmi'] ?? 0).toDouble();

        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BmiResultPage(bmi: bmiValue),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print("BMI POST error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not connect to backend')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleSubmit(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text("Submit BMI"),
    );
  }
}
