import 'package:driver_app/core/utils/util.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                height: getHeight(context) * 0.35,
              ),
              SizedBox(height: getHeight(context) * 0.01),
              const Text(
                'School Bus Driver Login',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getHeight(context) * 0.01),
              const Text(
                'Already registered? Log in here',
                style: TextStyle(
                  color: Color(0xeeffffff),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: getHeight(context) * 0.03),
              Container(
                padding: EdgeInsets.only(
                  top: getHeight(context) * 0.04,
                  left: getWidth(context) * 0.08,
                  right: getWidth(context) * 0.08,
                ),
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
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
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
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: getHeight(context) * 0.04),
                    ElevatedButton(
                      onPressed: () {
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
            ],
          ),
        ),
      ),
    );
  }
}
