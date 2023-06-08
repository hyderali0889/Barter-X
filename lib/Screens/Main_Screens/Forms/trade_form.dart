import 'dart:io';

import 'package:barter_x/Components/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import '../../../Components/form_text_field.dart';
import '../../../Components/top_row.dart';
import '../../../Controllers/Main_Controllers/Form_Controllers/trade_form_controller.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/Firebase_Functions/add_data_to_firestore.dart';
import '../../../Utils/Widgets/form_bottom_sheet.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

class TradeForm extends StatefulWidget {
  const TradeForm({super.key});

  @override
  State<TradeForm> createState() => _TradeFormState();
}

class _TradeFormState extends State<TradeForm> {
  TradeFormController controller = Get.find<TradeFormController>();

  List<String> allDistricts = [
    "Select District",
    "Abbottabad",
    "Astore",
    "Athmuqam",
    "Attock",
    "Awaran",
    "Azad Kashmir",
    "Badin",
    "Bagh",
    "Bahawalnagar",
    "Bahawalpur",
    "Bannu",
    "Barkhan",
    "Battagram",
    "Bhakkar",
    "Buner",
    "Chaghi",
    "Chakwal",
    "Charsadda",
    "Chiniot",
    "Chitral",
    "Dera Bugti",
    "Dera Ghazi Khan",
    "Dera Ismail Khan",
    "District_City",
    "Faisalabad",
    "Ghotki",
    "Gilgit-Baltistan",
    "Gujranwala",
    "Gujrat",
    "Gwadar",
    "Hafizabad",
    "Hangu",
    "Haripur",
    "Hunza",
    "Hyderabad",
    "Islamabad",
    "Jacobabad",
    "Jaffarabad",
    "Jamshoro",
    "Jhang",
    "Jhelum",
    "Kalat",
    "Kallar Syedan",
    "Karachi",
    "Karak",
    "Kashmore",
    "Kasur",
    "Kech",
    "Khanewal",
    "Kharan",
    "Khushab",
    "Khuzdar",
    "Killa Abdullah",
    "Kohat",
    "Kohlu",
    "Kotli",
    "Kurram",
    "Lahore",
    "Lakki Marwat",
    "Larkana",
    "Lasbela",
    "Layyah",
    "Lodhran",
    "Loralai",
    "Lower Dir",
    "Malakand",
    "Mandi Bahauddin",
    "Mansehra",
    "Mardan",
    "Mastung",
    "Matiari",
    "Mianwali",
    "Mirpur",
    "Mirpur Khas",
    "Multan",
    "Musakhel",
    "Muzaffargarh",
    "Nankana Sahib",
    "Narowal",
    "Nasirabad",
    "Naushahro Firoz",
    "Nowshera",
    "Okara",
    "Pakpattan",
    "Panjgur",
    "Peshawar",
    "Pishin",
    "Poonch",
    "Qila Saifullah",
    "Quetta",
    "Rahim Yar Khan",
    "Rajanpur",
    "Rawalpindi",
    "Sahiwal",
    "Sanghar",
    "Sargodha",
    "Shahdad Kot",
    "Shaheed Benazirabad",
    "Shangla",
    "Sheikhupura",
    "Shekhupura",
    "Shikarpur",
    "Sialkot",
    "Sibi",
    "Sukkur",
    "Swabi",
    "Swat",
    "Tando Allahyar",
    "Tando Muhammad Khan",
    "Tank",
    "Toba Tek Singh",
    "Umerkot",
    "Upper Dir",
    "Upper Kohistan",
    "Vehari",
    "Zhob",
    "Ziarat",
  ];

  List<String> categories = [
    "Select Category",
    "Books",
    "Furniture",
    "Glass-Items",
    "Clothing",
    "Car",
    "Motorcycle",
    "Toys",
    "Others",
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController tradeWithController = TextEditingController();
  TextEditingController desController = TextEditingController();

  TextEditingController userEmailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  TextEditingController userPhoneController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.phoneNumber);

  @override
  void dispose() {
    titleController.dispose();
    tradeWithController.dispose();
    desController.dispose();
    userEmailController.dispose();
    userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                const TopRow(
                  text: "Add Trade",
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TheForm(
                        titleController: titleController,
                        tradeWithController: tradeWithController,
                        desController: desController,
                        userEmailController: userEmailController,
                        userPhoneController: userPhoneController,
                        allDistricts: allDistricts,
                        categories: categories,
                        controller: controller,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Spacing().sm),
                        child: Obx(
                          () => MainButton(
                            size: size,
                            buttonText: "Add Trade",
                            actionFunction: () {
                              try {
                                String path = "file/${DateTime.now()}";
                                File file = File(controller.image.value!.path);

                                AddDataToFirestore().addTradeToFirebase(
                                    context,
                                    path,
                                    file,
                                    controller,
                                    titleController,
                                    tradeWithController,
                                    desController);
                              } catch (e) {
                                ReturnWidgets().returnBottomSheet(context,
                                    "An Error Occurred. Please fill All Fields and try Agains.");
                              }
                            },
                            mainController: controller.isLoading.value,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TheForm extends StatelessWidget {
  const TheForm({
    super.key,
    required this.titleController,
    required this.desController,
    required this.userEmailController,
    required this.userPhoneController,
    required this.allDistricts,
    required this.controller,
    required this.categories,
    required this.tradeWithController,
  });
  final TextEditingController titleController;
  final TextEditingController desController;
  final TextEditingController userEmailController;
  final TextEditingController userPhoneController;
  final TextEditingController tradeWithController;
  final List<String> allDistricts;
  final List<String> categories;
  final TradeFormController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          top: Spacing().md, left: Spacing().sm, right: Spacing().sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                try {
                  FormModelBottomSheet()
                      .showFormModelBottomSheet(context, controller);
                } catch (e) {
                  ReturnWidgets()
                      .returnBottomSheet(context, "An Error Occurred $e");
                }
              },
              child: Obx(
                () => Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: AppColors().secSoftGrey,
                      borderRadius: BorderRadius.circular(20)),
                  height: 120,
                  child: controller.image.value == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(UniconsLine.image),
                            Text('Add Image'),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(controller.image.value!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFieldForForm(
              heading: "Enter Title",
              opacity: 1.0,
              readOnly: false,
              maxLines: 1,
              width: size.width * 0.9,
              height: size.height * 0.14,
              maxLength: 64,
              hintText: "Enter Title",
              controller: titleController,
            ),
          ),
          TextFieldForForm(
            heading: "Trade with",
            opacity: 1.0,
            readOnly: false,
            maxLines: 1,
            width: size.width * 0.9,
            height: size.height * 0.14,
            maxLength: 64,
            hintText: "Enter the title of the desired trade",
            controller: tradeWithController,
          ),
          TextFieldForForm(
            heading: "Enter Description",
            opacity: 1.0,
            readOnly: false,
            maxLines: 5,
            width: size.width * 0.9,
            height: size.height * 0.27,
            maxLength: 150,
            hintText: "Enter Description",
            controller: desController,
          ),
          TextFieldForForm(
            heading: "User's Email",
            opacity: 0.5,
            readOnly: true,
            maxLines: 1,
            width: size.width * 0.9,
            height: size.height * 0.14,
            maxLength: 62,
            hintText: "",
            controller: userEmailController,
          ),
          TextFieldForForm(
            heading: "User's Phone Number",
            opacity: 0.5,
            readOnly: true,
            maxLines: 1,
            width: size.width * 0.9,
            height: size.height * 0.14,
            maxLength: 25,
            hintText: "",
            controller: userPhoneController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Select District",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      width: size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors().primaryBlack),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              value: controller.selectedDistrict.value != ""
                                  ? controller.selectedDistrict.value
                                  : allDistricts[0],
                              hint: const Text("Select District"),
                              style: context.textTheme.bodySmall,
                              borderRadius: BorderRadius.circular(20),
                              items: allDistricts.map((String e) {
                                return DropdownMenuItem<String>(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (String? para) {
                                if (para == null || para == "Select District") {
                                  return;
                                }

                                controller.selectDistrict(para);
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Select Category",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors().primaryBlack),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                          () => DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              value: controller.selectedCat.value != ""
                                  ? controller.selectedCat.value
                                  : categories[0],
                              hint: const Text("Select Category"),
                              style: context.textTheme.bodySmall,
                              borderRadius: BorderRadius.circular(20),
                              items: categories.map((String e) {
                                return DropdownMenuItem<String>(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (String? para) {
                                if (para == null || para == "Select Category") {
                                  return;
                                }

                                controller.selectCat(para);
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
