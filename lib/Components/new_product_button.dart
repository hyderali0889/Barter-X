import 'package:flutter/material.dart';

import '../Themes/main_colors.dart';

class ProductButton {
  InkWell newProductButton(textTheme, size, mainText, mainIcon, func, color) {
    return InkWell(
        onTap: func,
        child: Container(
            width: size.width * 0.45,
            height: 60,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(14)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(mainText,
                    style: textTheme.bodyMedium!
                        .copyWith(color: AppColors().primaryWhite)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(
                    mainIcon,
                    color: AppColors().primaryWhite,
                  ),
                )
              ],
            )));
  }
}
