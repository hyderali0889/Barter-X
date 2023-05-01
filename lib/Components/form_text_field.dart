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
    required this.readOnly, required this.opacity,
  });
  final double width;
  final double height;

  final int maxLength;

  final TextEditingController controller;

  final String hintText;
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
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Opacity(
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
          ),
        ),
      ],
    );
  }
}
