import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    var rect = Offset.zero & size;
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..shader = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromARGB(255, 16, 59, 33),
        Colors.white,
      ],
    ).createShader(rect));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key,required this.showRegisterPage}) : super(key:key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  Future signIn() async {
    await FirebaseAuth.instance.
    signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
    );
}

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[300],
          body:
          Column(
            children: [
              Stack( 
                children: [
                  Container(
                    child: CustomPaint(
                      painter: ShapesPainter(),
                      child: Container(height: 250),
                    ),
                  ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Center(
                          child: Text('GEM',
                              style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50
                              )
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Welcome back!\nLog in to continue:',
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            )
                        ),
                      ),
                    ],
                  ),
                ]
              ),
              SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height:25),
                //greetings
                // Text('Hello Again!',
                // style:TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 24
                // )
                // ),
                //         SizedBox(height:10),
                // Text("Welcome to App",
                // style: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 24
                // ),
                // ),
                            SizedBox(height:25),


                //email
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Username/Email',
                        fillColor: Colors.grey[200],
                        filled: true,
                        ),
                      ),
                  ),
                        SizedBox(height:10),



                //password
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                              child: TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Password',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height:10),
                //sign in
        Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 75.0),
        child:   GestureDetector(
              onTap: signIn,
              child: Container(
                padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color:  Colors.teal[900],
                borderRadius: BorderRadius.circular(12),
              ),
                child: Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                  ),
                ),
              ),
  ),
        ),
),
                            SizedBox(height:10),

                            //not a member register
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?",
                                  style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                                ),
                                GestureDetector(
                                  onTap: widget.showRegisterPage,
                                  child: Text(
                                    " Sign Up.",
                                    style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                )
                              ],
                            ),
                ],
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}