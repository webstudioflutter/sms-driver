import 'dart:async';

import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:driver_app/screen/login_and_logout/login.dart';
import 'package:driver_app/screen/navbar/MainNavbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  late Animation<double> _scaleAnimation3;
  late Animation<double> _scaleAnimation4;
  late Animation<double> _scaleAnimation5;
  late Animation<double> _scaleAnimation6;
  late Animation<double> _scaleAnimation7;

  late Animation<double> _opacityAnimation1;
  late Animation<double> _opacityAnimation2;
  late Animation<double> _opacityAnimation3;
  late Animation<double> _opacityAnimation4;
  late Animation<double> _opacityAnimation5;
  late Animation<double> _opacityAnimation6;
  late Animation<double> _opacityAnimation7;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Define the scale animations (burst-out effect for multiple bursts)
    _scaleAnimation1 = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation2 = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation3 = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation5 = Tween<double>(begin: 0.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation6 = Tween<double>(begin: 0.0, end: 2.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation7 = Tween<double>(begin: 2.5, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Define the opacity animations (fade-out effect)
    _opacityAnimation1 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 1.0, curve: Curves.easeOut)),
    );
    _opacityAnimation3 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 1.0, curve: Curves.easeOut)),
    );
    _opacityAnimation4 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation5 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 1.0, curve: Curves.easeOut)),
    );
    _opacityAnimation6 = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 0.3, curve: Curves.easeOut)),
    );
    _opacityAnimation7 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 1.0, curve: Curves.easeIn)),
    );

    // Start the animation
    _controller.forward();

    // Navigate to the next screen after a delay
    Timer(const Duration(seconds: 3), () async {
      bool isAuthenticated = await authenticationRepository.isAuthenticated();
      // bool firstTimeUSer = await authRepository.isFirstTimeUser();

      // if (firstTimeUSer == true) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => const LanguageChoosePage(),
      //     ),
      //   );
      // } else
      if (isAuthenticated == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainNavbar(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DriverLoginScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6bccc1), Color(0xff6fcf99)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     return Opacity(
            //       opacity: _opacityAnimation1.value,
            //       child: Transform.scale(
            //         scale: _scaleAnimation1.value,
            //         child: Container(
            //           width: width,
            //           height: width,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Theme.of(context).shadowColor.withOpacity(0.5),
            //             // color: Colors.white.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     return Opacity(
            //       opacity: _opacityAnimation2.value,
            //       child: Transform.scale(
            //         scale: _scaleAnimation2.value,
            //         child: Container(
            //           width: width,
            //           height: width,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Theme.of(context).shadowColor.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     return Opacity(
            //       opacity: _opacityAnimation3.value,
            //       child: Transform.scale(
            //         scale: _scaleAnimation3.value,
            //         child: Container(
            //           width: width,
            //           height: width,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Theme.of(context).shadowColor.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     return Opacity(
            //       opacity: _opacityAnimation4.value,
            //       child: Transform.scale(
            //         scale: _scaleAnimation4.value,
            //         child: Container(
            //           width: width,
            //           height: width,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Theme.of(context).shadowColor.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     return Opacity(
            //       opacity: _opacityAnimation5.value,
            //       child: Transform.scale(
            //         scale: _scaleAnimation5.value,
            //         child: Container(
            //           width: width,
            //           height: width,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Theme.of(context).shadowColor.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: (context, child) {
            //     return Opacity(
            //       opacity: _opacityAnimation6.value,
            //       child: Transform.scale(
            //         scale: _scaleAnimation6.value,
            //         child: Container(
            //           width: width,
            //           height: width,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: Theme.of(context).shadowColor.withOpacity(0.5),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),

            // Logo in the middle
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation6.value,
                  child: Transform.scale(
                    scale: _scaleAnimation6.value,
                    child: Center(
                      child: Lottie.asset(
                        height: 120,
                        'assets/Animation.json',
                        fit: BoxFit.cover,
                        animate: true,
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation7.value,
                  child: Transform.scale(
                    scale: _scaleAnimation7.value,
                    child: Center(
                      child: Lottie.asset(
                        height: 100,
                        'assets/Animation.json',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
