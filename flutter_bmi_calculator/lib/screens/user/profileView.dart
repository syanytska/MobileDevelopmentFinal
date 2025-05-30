import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';

class ProfileView extends StatelessWidget{
  const ProfileView({super.key});

  Future<Map<String, String?>> _loadProfile() async{
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final role = prefs.getString('role');

    return {'username': username, 'role': role};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: _loadProfile(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        else if(!snapshot.hasData || snapshot.data == null){
          return const Center(child: Text('Failed to load user profile', style: TextStyle(color: Colors.white)));
        }

        final data = snapshot.data!;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text("Profile", style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username: ${data['username'] ?? 'N/A'}", style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                Text("Role: ${data['role'] ?? 'N/A'}", style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  child: const Text("Logout", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}