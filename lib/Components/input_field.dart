import 'package:barter_x/Themes/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../Themes/spacing.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.size,
      required this.controller,
      required this.title,
      required this.hintText,
      required this.obsecureText,
      required this.isEmailField,
      this.mainController,
      required this.width,
      required this.maxLenght});

  final Size size;
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool obsecureText;
  final bool isEmailField;
  final dynamic mainController;
  final double width;
 final int maxLenght;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Spacing().sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: context.textTheme.bodySmall!.copyWith(fontFamily: "bold"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: SizedBox(
              width: widget.width,
              height: 75,
              child: TextFormField(
                maxLength: widget.maxLenght,
                style: context.textTheme.bodyMedium,
                obscureText: widget.obsecureText,
                controller: widget.controller,
                decoration: InputDecoration(
                    suffixIcon: widget.isEmailField
                        ? null
                        : widget.obsecureText
                            ? IconButton(
                                onPressed: () {
                                  widget.mainController
                                      .changeObsecureText(false);
                                },
                                icon: const Icon(UniconsLine.eye))
                            : IconButton(
                                onPressed: () {
                                  widget.mainController
                                      .changeObsecureText(true);
                                },
                                icon: const Icon(UniconsLine.eye_slash)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppColors().labelOffBlack)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppColors().labelOffBlack)),
                    hintStyle: context.textTheme.bodySmall,
                    hintText: widget.hintText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
