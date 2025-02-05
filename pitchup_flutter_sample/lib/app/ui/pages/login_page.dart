import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pitchupfluttersample/config/values/colors.dart';

import '../../../mysql/mysql.dart';
import '../../../mysql/user.dart';

class LoginScreen extends StatefulWidget {
  // final ValueNotifier dropdownValueNotifier;
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var db = Mysql();
  var email = '';
  var password = '';
  bool incorrectPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 50),
          CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'),
            radius: 150,
          ),

          SizedBox(height: 50), // Spacing between words

          // Welcome!
          Text(
            'Welcome to Melody!',
            style: GoogleFonts.bebasNeue(
              fontSize: 40,
              color: kBlackColor,
            ),
          ), // Text

          Opacity(
            opacity: incorrectPass ? 1.0 : 0.0,
            child: Text(
              'Email and password do not match!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),
            ),
          ),

          // Email Textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ), //Box Decoration
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black),
                  ), // InputDecoration
                ), //TextField
              ), //Padding
            ), //Container
          ), //Padding

          SizedBox(height: 10), // Spacing between words

          // Password Textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ), //Box Decoration
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black),
                  ), // InputDecoration
                ), //TextField
              ), //Padding
            ), //Container
          ), //Padding

          SizedBox(height: 10), // Spacing between boxes

          // Sign in button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ElevatedButton(
              onPressed: () {
                db.getConnection().then((conn) {
                  String sql = 'select password from `melody-1`.users';
                  sql += ' where email = \'$email\'';
                  conn.query(sql).then((results) {
                    setState(() {
                      for (var row in results) {
                        print(row['password']); // For debugging
                        if (row['password'] == password) {
                          context.go('/page');
                        } else {
                          incorrectPass = true;
                        }
                      }
                      conn.close();
                    });
                  });
                });
              },
              // padding: EdgeInsets.all(25),
              // decoration: BoxDecoration(
              //   color: Colors.lightGreen,
              //   //border: BorderRadius.circular(12),
              // ), // BoxDecoration
              child: Center(
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.green[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ), //TextStyle
                ), //Text
              ), //Center
            ), //Container
          ),
          //Padding

          SizedBox(height: 10),

          // Not a member? Register now
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Not a member?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ), //TextStyle
            ), //Text
            TextButton(
              onPressed: () {
                context.go('/signup');
              },
              child: Text(
                ' Register now',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ), //TextStyle),
              ),
            ), //Text
          ]), // Row
        ]) //Column
            ), // Center
      ), //SafeArea
    ); // Scaffold
  }
} // _LoginScreenState bracket
