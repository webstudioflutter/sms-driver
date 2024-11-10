import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';

class TeacherLoginScreen extends StatelessWidget {
  const TeacherLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6bccc1), Color(0xff6fcf99)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/school_bus.png',
              colorBlendMode: BlendMode.color,
              height: 250,
            ),
            const SizedBox(height: 10),

            const Text(
              'School Bus Driver Login',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Subtitle
            const Text(
              'Already registered? Log in here',
              style: TextStyle(
                color: Color(0xeeffffff),
                fontSize: 16,
              ),
            ),
            // const SizedBox(height: 30),
            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                // height: getHeight(context) * 0.5,
                padding: const EdgeInsets.only(top: 64, left: 26, right: 26),
                // margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(64),
                    topRight: Radius.circular(64),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: getHeight(context) * 0.02),

                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: const Icon(Icons.visibility),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: getHeight(context) * 0.04),

                    // Login button
                    ElevatedButton(
                      onPressed: () {
                        // const MainNavbar();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainNavbar()));
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xff60bf8f),
                      ),
                      child: const Text('Login',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    SizedBox(height: getHeight(context) * 0.02),

                    // Back button

                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainNavbar()));
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.grey),
                      label: const Text(
                        'Back',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
