import 'package:flutter/material.dart';

class AllAuctionBids extends StatefulWidget {
  const AllAuctionBids({super.key});

  @override
  State<AllAuctionBids> createState() => _AllAuctionBidsState();
}

class _AllAuctionBidsState extends State<AllAuctionBids> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
         width:size.width,
         height:size.height,
          child:Column(
            children: [],
        ),
       )
      ),
    );
  }
}