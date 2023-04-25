import 'package:flutter/material.dart';

class TradingHistoryScreen extends StatefulWidget {
  const TradingHistoryScreen({super.key});

  @override
  State<TradingHistoryScreen> createState() => _TradingHistoryScreenState();
}

class _TradingHistoryScreenState extends State<TradingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [Text("Trading History")],
      )),
    );
  }
}
