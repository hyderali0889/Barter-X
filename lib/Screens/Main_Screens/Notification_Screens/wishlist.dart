import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Models/wishlist.dart';
import '../../../Routes/routes.dart';
import '../../../main.dart';
import '../../../objectbox.g.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  NavigationController navController = Get.find<NavigationController>();
  Box<WishlistModel> wishlist = objectBox.store.box<WishlistModel>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: wishlist.getAll().length.toString().isNotEmpty
                  ? ListView.builder(
                      itemCount: wishlist.count(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Container();
                        }
                        return Text(wishlist.get(index)!.productCategory);
                      })
                  : PlaceHolderWidget(
                      size: size,
                      image: "B3",
                      mainText: "Nothing in your Wishlist.",
                      buttonText: "Go Home",
                      isLoading: false,
                      buttonFunc: () {
                        Get.offAllNamed(Routes().navigationScreen,
                            arguments: [0]);
                      },
                    )),
        ],
      )),
    );
  }
}
