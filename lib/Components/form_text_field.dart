import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Themes/main_colors.dart';

class TextFieldForForm extends StatefulWidget {
  const TextFieldForForm({
    super.key,
    required this.width,
    required this.maxLength,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.height,
    required this.readOnly,
    required this.opacity,
    required this.heading,
  });
  final double width;
  final double height;

  final int maxLength;

  final TextEditingController controller;

  final String hintText;
  final String heading;
  final int maxLines;
  final bool readOnly;
  final double opacity;

  @override
  State<TextFieldForForm> createState() => _TextFieldForFormState();
}

class _TextFieldForFormState extends State<TextFieldForForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.heading,
                  style: context.textTheme.bodySmall,
                ),
              ),
              Opacity(
                opacity: widget.opacity,
                child: TextFormField(
                  readOnly: widget.readOnly,
                  maxLines: widget.maxLines,
                  keyboardType: TextInputType.name,
                  maxLength: widget.maxLength,
                  style: context.textTheme.bodyMedium,
                  controller: widget.controller,
                  decoration: InputDecoration(
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
            ],
          ),
        ),
      ],
    );
  }
}
