import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_dialogs.dart';
import '../services/user_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true; // Enhancement 1
  bool isLoading = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      await _userService.login(
        usernameController.text,
        passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (build) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      customDialog(
        context,
        title: 'Error',
        content: 'Username and password does not matched',
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(40),
            color: const Color.fromARGB(255, 255, 112, 158),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(25),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/B.png',
                          height: ScreenUtil().setHeight(200),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(35)),

                        CustomTextFormField(
                          controller: usernameController,
                          hintText: 'Username',
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your username' : null,
                          fontSize: ScreenUtil().setSp(15),
                          hintTextSize: ScreenUtil().setSp(15),
                          height: ScreenUtil().setHeight(10),
                          width: ScreenUtil().setWidth(10),
                          fontColor: const Color.fromARGB(255, 44, 34, 37),
                        ),

                        SizedBox(height: ScreenUtil().setHeight(10)),

                        CustomTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          isObscure: obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your password' : null,
                          fontSize: ScreenUtil().setSp(15),
                          hintTextSize: ScreenUtil().setSp(15),
                          height: ScreenUtil().setHeight(10),
                          width: ScreenUtil().setWidth(10),
                          fontColor: const Color.fromARGB(255, 255, 112, 158),
                        ),

                        SizedBox(height: ScreenUtil().setHeight(25)),

                        CustomInkWellButton(
                          onTap: isLoading ? null : login,
                          height: ScreenUtil().setHeight(40),
                          width: ScreenUtil().screenWidth,
                          buttonName: isLoading ? 'Logging in...' : 'Login',
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(40),
            color: const Color.fromARGB(255, 255, 112, 158),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You do not have an account? ',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 247, 247),
                    fontSize: ScreenUtil().setSp(15),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    'Register here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
