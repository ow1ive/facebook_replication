import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/constants.dart';
import '../services/user_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    getIsLogin();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void getIsLogin() {
    Timer(const Duration(seconds: 4), () async {
      final isLoggedIn = await _userService.isLoggedIn();
      if (!mounted) return;
      Navigator.popAndPushNamed(context, isLoggedIn ? '/home' : '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF0F5), Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/B.png',
                height: ScreenUtil().setHeight(150),
              ),
              SizedBox(height: ScreenUtil().setHeight(60)),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(10, (index) {
                        // Calculate angle for each dot
                        double angle = (index * 2 * 3.14159) / 10;
                        // Calculate animation delay for each dot
                        double delay = index / 10;
                        // Calculate opacity based on animation progress
                        double progress = (_controller.value + delay) % 1.0;
                        double opacity = progress < 0.5
                            ? progress * 2
                            : (1 - progress) * 2;
                        // Calculate size based on animation progress
                        double size = 8 + (opacity * 4);

                        return Transform.translate(
                          offset: Offset(
                            30 * (1 + (opacity * 0.2)) * math.cos(angle),
                            30 * (1 + (opacity * 0.2)) * math.sin(angle),
                          ),
                          child: Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: FB_PRIMARY.withValues(alpha: opacity),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
