import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../Themes/main_colors.dart';
import '../Themes/spacing.dart';

class TopRowNoBack extends StatelessWidget {
  const TopRowNoBack({super.key, required this.text, required this.icon, required this.firstFunc});

  final String text;
  final IconData icon;

  final VoidCallback firstFunc;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Spacing().sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Text(
              text,
              style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors().primaryBlack, fontFamily: "medium"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(onTap: firstFunc, child:  Icon(icon)),
          ),
        ],
      ),
    );
  }
}
