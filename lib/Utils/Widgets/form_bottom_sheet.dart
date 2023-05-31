import 'dart:io';

import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../Themes/main_colors.dart';

class FormModelBottomSheet{


 Future<void> selectImage(context,controller ,ImageSource source) async {
      try {
        controller.startLoading(true);

        XFile? imagePath = await ImagePicker().pickImage(source: source);
        controller.startLoading(false);

        if (imagePath == null) {
          ReturnWidgets().returnBottomSheet(context, "NO Image Selected");
          return;
        }

        File imgFile = File(imagePath.path);

        controller.addImage(imgFile);

        Get.back();
      } on PlatformException catch (e) {
        ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
      }
    }


  showFormModelBottomSheet(context,controller ){
     showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  selectImage(context,controller ,  ImageSource.gallery);
                                },
                                child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: AppColors().secSoftGrey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 120,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(UniconsLine.image),
                                        Text('Gallery'),
                                      ],
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  selectImage(context,controller ,  ImageSource.camera);
                                },
                                child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: AppColors().secSoftGrey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 120,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(UniconsLine.camera),
                                        Text('Camera'),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
  }
 }