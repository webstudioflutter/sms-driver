import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:driver_app/controller/Auth/AuthenticationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverLoginScreen extends StatefulWidget {
  DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final controller = Get.put(LoginController());
  bool isBiometricEnabled = false;
  late final LocalAuthentication auth;
  bool supportState = false;
  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          supportState = isSupported;
        }));
    getBiometricSetting();
  }

  void getBiometricSetting() async {
    final prefs = await SharedPreferences.getInstance();

    var biometricSetting = prefs.getBool('biomatric');

    setState(() {
      isBiometricEnabled = biometricSetting!;
      print('Biometric Login: $isBiometricEnabled');
    });
  }

  //authenticate biometric login
  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: false));

      if (authenticated) {
        final _secureStorage = const FlutterSecureStorage();
        var email = await _secureStorage.read(key: 'email');
        var password = await _secureStorage.read(key: 'password');

        final authData = {
          "email": email,
          "password": password,
        };
        await authenticationRepository.sendAuthInfo(authData);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: Image.asset(
                'assets/images/school_bus.png',
                colorBlendMode: BlendMode.color,
                height: MediaQuery.of(context).size.height * 0.35,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(62),
                      topRight: Radius.circular(62),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.5, 0.5),
                          blurRadius: 1,
                          spreadRadius: 0.5),
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'email'.tr,
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            decoration: InputDecoration(
                              labelText: 'password'.tr,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (value.length < 6) {
                                return "Please enter a valid password (min. 6 characters)";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => controller.login(),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: const Color(0xff60bf8f),
                            ),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'login'.tr,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                          ),
                        ),
                        if (isBiometricEnabled)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child:
                                Center(child: Text('or', style: TextStyle())),
                          ),
                        if (isBiometricEnabled)
                          GestureDetector(
                            onTap: () {
                              _authenticate();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    size: 24,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Login in with biometrics',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
