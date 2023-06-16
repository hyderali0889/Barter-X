import 'package:flutter/material.dart';

class AllProdBidsDetails extends StatefulWidget {
  const AllProdBidsDetails({super.key});

  @override
  State<AllProdBidsDetails> createState() => _AllProdBidsDetailsState();
}

class _AllProdBidsDetailsState extends State<AllProdBidsDetails> {
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