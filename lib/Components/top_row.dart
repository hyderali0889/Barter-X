import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../Themes/main_colors.dart';
import '../Themes/spacing.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
    required this.text,
    required this.icon,
    required this.firstFunc,
  });

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
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(UniconsLine.arrow_left)),
          ),
          Text(
            text,
            style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors().primaryBlack, fontFamily: "medium"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(onTap: firstFunc, child: Icon(icon)),
          ),
        ],
      ),
    );
  }
}
