import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim(),);
  }

  void openSignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

@override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                'تسجيل الدخول',style: GoogleFonts.robotoCondensed(
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              ),
              
              //subtitle
               Text(
                ' مرحبا بك',style: GoogleFonts.robotoCondensed(
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
              
              SizedBox(height: 15),


              //sigin in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 43, 138, 159),
                      borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text('تسجيل الدخول', 
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
                    onTap: openSignupScreen,
                    child: Text('إنشاء',
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      ),),
                  ),
                    Text(' ليس لديك حساب؟ ', style: GoogleFonts.robotoCondensed(
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