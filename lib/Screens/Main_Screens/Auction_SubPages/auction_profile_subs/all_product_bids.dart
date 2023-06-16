import 'package:flutter/material.dart';

class AllProductBids extends StatefulWidget {
  const AllProductBids({super.key});

  @override
  State<AllProductBids> createState() => _AllProductBidsState();
}

class _AllProductBidsState extends State<AllProductBids> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
         width:size.width,
         height:size.height,
          child:const Column(
            children: [],
        ),
       )
      ),
    );
  }
}