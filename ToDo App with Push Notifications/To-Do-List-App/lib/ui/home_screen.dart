// ignore_for_file: prefer_const_constructors

import "package:firebase/ui/posts/post_screen.dart";
import "package:firebase/widgets/round_button.dart";
import "package:flutter/material.dart";

import "../api/api_screen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton(
                title: 'Go for API Service',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ApiScreen()));
                }),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 20,
            ),
            RoundButton(
                title: 'Go for Post Service',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
