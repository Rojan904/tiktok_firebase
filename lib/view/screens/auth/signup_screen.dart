import 'package:flutter/material.dart';
import 'package:tiktok_firebase/core/constants.dart';
import 'package:tiktok_firebase/core/size_config.dart';
import 'package:tiktok_firebase/view/screens/auth/login_screen.dart';
import 'package:tiktok_firebase/view/widgets/text_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _emailController;
  late TextEditingController _pwController;
  late TextEditingController _userNameController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _userNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
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
                'Register',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('url'),
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: () => authController.pickImage(),
                      icon: Icon(Icons.camera),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextInputField(
                  controller: _userNameController,
                  labelText: 'Username',
                  icon: Icons.person,
                  isObscure: false,
                ),
              ),

              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
                    print('photo ${authController.profilePhoto}');
                    authController.registerUser(
                      _userNameController.text,
                      _emailController.text,
                      _pwController.text,
                      authController.profilePhoto,
                    );
                  },
                  child: Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
