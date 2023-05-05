import 'dart:io';

import 'package:barter_x/Components/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/form_text_field.dart';
import '../../../Components/top_row.dart';
import '../../../Controllers/Main_Controllers/Form_Controllers/main_form_controller.dart';
import '../../../Models/trade_form_model.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  MainFormController controller = Get.find<MainFormController>();

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

  void closeBottomBar() {
    controller.changeErrorStatus(false);
  }

  void tryAgainBottomBar() {
    controller.changeErrorStatus(false);
  }

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

  void addToFirebase() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      bool isAuction = Get.arguments == "a" &&
          (tradeWithController.text.isNotEmpty ||
              controller.selectedCat.value == "");
      bool isEWaste = Get.arguments == "e" && tradeWithController.text.isEmpty;
      bool isTrade = Get.arguments == null &&
          (tradeWithController.text.isEmpty ||
              controller.selectedCat.value == "");

      bool sel = (isAuction || isTrade || isEWaste);

      if (sel ||
          controller.image.value == null ||
          titleController.text.isEmpty ||
          controller.selectedDistrict.value == "" ||
          desController.text.isEmpty) {
        controller.errorOcurred(true);
        controller.errorMsg(
            "NO Image Selected or any field is empty. Please fill all the fields and try again.");
        return;
      }
      controller.startLoading(true);
      String path = "file/${DateTime.now()}";
      File file = File(controller.image.value!.path);

      UploadTask fileurl = storage.ref().child(path).putFile(file);

      final snapshot = await fileurl.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      firestore.collection("Barters").doc(DateTime.now().toString()).set({
        TradeFormModel().title: titleController.text.trim(),
        TradeFormModel().tradeWith:
            Get.arguments != null && Get.arguments == "a"
                ? "Auction"
                : tradeWithController.text.trim(),
        TradeFormModel().img: downloadUrl,
        TradeFormModel().des: desController.text.trim(),
        TradeFormModel().email: auth.currentUser!.email,
        TradeFormModel().phone: auth.currentUser!.phoneNumber,
        TradeFormModel().district: controller.selectedDistrict.value,
        TradeFormModel().cat: Get.arguments != null && Get.arguments == "e"
            ? "E-Waste"
            : controller.selectedCat.value
      });
      controller.startLoading(false);
      Get.offAllNamed(Routes().navigationScreen, arguments: 0);
    } on PlatformException catch (e) {
      controller.startLoading(false);

      controller.errorOcurred(true);
      controller.errorMsg("An Error Occured ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          Obx(
            () => Opacity(
              opacity: controller.errorOcurred.value ? 0.6 : 1,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      TopRow(
                        text: "Add Trade",
                        firstFunc: () {},
                        icon: UniconsLine.bell,
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
                              child: MainButton(
                                size: size,
                                buttonText: "Add Trade",
                                actionFunction: addToFirebase,
                                mainController: controller.isLoading.value,
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
          ),
          Obx(
            () => BottomBar(
              controller: controller,
              size: size,
              errorTitle: "An Error Occurred",
              errorMsg: controller.errorMsg.value,
              closeFunction: closeBottomBar,
              tryAgainFunction: tryAgainBottomBar,
              buttonWidget: Text(
                "Try Again",
                style: context.textTheme.displayMedium,
              ),
            ),
          )
        ],
      )),
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
  final MainFormController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<void> selectImage(ImageSource source) async {
      try {
        controller.errorOcurred(false);
        controller.startLoading(true);

        XFile? imagePath = await ImagePicker().pickImage(source: source);
        controller.startLoading(false);

        if (imagePath == null) {
          controller.errorOcurred(true);
          controller.errorMsg("NO Image Selected");
          return;
        }

        File imgFile = File(imagePath.path);

        controller.addImage(imgFile);

        Get.back();
      } on PlatformException catch (e) {
        controller.errorOcurred(true);
        controller.errorMsg("An Error Occured ${e.message}");
      }
    }

    return Padding(
      padding: EdgeInsets.only(
          top: Spacing().md, left: Spacing().sm, right: Spacing().sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
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
                                  selectImage(ImageSource.gallery);
                                },
                                child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: AppColors().secSoftGrey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(UniconsLine.image),
                                        Text('Gallery'),
                                      ],
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  selectImage(ImageSource.camera);
                                },
                                child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: AppColors().secSoftGrey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
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
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                    color: AppColors().secSoftGrey,
                    borderRadius: BorderRadius.circular(20)),
                height: 120,
                child: controller.image.value == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
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
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFieldForForm(
              heading: "Enter Title",
              opacity: 1.0,
              readOnly: false,
              maxLines: 1,
              width: size.width * 0.9,
              height: 115,
              maxLength: 64,
              hintText: "Enter Title",
              controller: titleController,
            ),
          ),
          Get.arguments != null && Get.arguments == "a"
              ? Container()
              : TextFieldForForm(
                  heading: "Trade with",
                  opacity: 1.0,
                  readOnly: false,
                  maxLines: 1,
                  width: size.width * 0.9,
                  height: 115,
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
            height: 210,
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
            height: 115,
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
            height: 115,
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
                        child: Get.arguments != null && Get.arguments == "e"
                            ? Text(
                                "E-Waste",
                                style: context.textTheme.bodySmall,
                              )
                            : Obx(
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
                                      if (para == null ||
                                          para == "Select Category") {
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
          )
        ],
      ),
    );
  }
}
