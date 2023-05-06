// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();
 final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushNamed('/'); 
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == 
    _confirmPasswordController.text.trim()) {
      return true;
      
    } else {
      return false;
    }
  }

  void openLoginScreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

@override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     backgroundColor: Colors.white,
     body: SafeArea(
       child: Center(
         child: SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Image.asset('images/IMG_4953.png', 
              height: 150,
              ),
              SizedBox(height: 20),
              //title
              Text(
                'تسجيل',style: GoogleFonts.robotoCondensed(
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              ),
              
              //subtitle
               Text(
                'مرحبا! هنا يمكنك التسجيل',style: GoogleFonts.robotoCondensed(
                  fontSize: 18),
              ),
              SizedBox(height: 50,),
              
              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'البريد الالكتروني'
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height:10),


              //password textfield
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ' كلمة المرور'
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 10),


              //Confirm password textfield
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'تأكيد كلمة المرور'
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 15),



              //sigup button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 43, 138, 159),
                      borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'تسجيل ', 
                       style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    )),
                  ),
                ),
              ),
              
              SizedBox(height: 25),
         
              // text sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: openLoginScreen,
                    child: Text('تسجيل الدخول',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      ),),
                  ),
                    Text(' عضو فعلاً؟ ', style: GoogleFonts.robotoCondensed(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    ),),
                ],
              )
            ],
           ),
         ),
       ),
     ),
    );
  }
}