import 'package:flutter/material.dart';

class SubNotificationScreen extends StatefulWidget {
  const SubNotificationScreen({super.key});

  @override
  State<SubNotificationScreen> createState() => _SubNotificationScreenState();
}

class _SubNotificationScreenState extends State<SubNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [],
        )
      ),
    );
  }
}