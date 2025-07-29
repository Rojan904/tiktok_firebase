import 'package:flutter/material.dart';
import 'package:tiktok_firebase/core/constants.dart';
import 'package:tiktok_firebase/core/size_config.dart';
import 'package:tiktok_firebase/view/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _pwController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tiktok Clone',
              style: TextStyle(
                fontSize: 35,
                color: buttonColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
                isObscure: false,
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextInputField(
                controller: _pwController,
                labelText: 'Password',
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: InkWell(
                onTap: () {
                  authController.loginUser(
                    _emailController.text,
                    _pwController.text,
                  );
                },
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?', style: TextStyle(fontSize: 20)),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 20, color: buttonColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
