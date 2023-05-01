import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/form_text_field.dart';
import '../../../Components/top_row.dart';
import '../../../Controllers/Main_Controllers/Form_Controllers/main_form_controller.dart';
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
  TextEditingController desController = TextEditingController();

  TextEditingController userEmailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  TextEditingController userPhoneController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.phoneNumber);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          InkWell(
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
                          desController: desController,
                          userEmailController: userEmailController,
                          userPhoneController: userPhoneController,
                          allDistricts: allDistricts,
                          categories: categories,
                          controller: controller,
                        ),
                      ],
                    ),
                  )
                ],
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
  });
  final TextEditingController titleController;
  final TextEditingController desController;
  final TextEditingController userEmailController;
  final TextEditingController userPhoneController;
  final List<String> allDistricts;
  final List<String> categories;
  final MainFormController controller;

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
                                Future<XFile?> pickedImage = ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                print(pickedImage);
                              },
                              child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColors().secSoftGrey,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                Future<XFile?> pickedImage = ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                              },
                              child: Container(
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: AppColors().secSoftGrey,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(UniconsLine.image),
                    Text('Add Image'),
                  ],
                )),
          ),
          TextFieldForForm(
            opacity: 1.0,
            readOnly: false,
            maxLines: 1,
            width: size.width * 0.9,
            height: 100,
            maxLength: 64,
            hintText: "Enter Title",
            controller: titleController,
          ),
          TextFieldForForm(
            opacity: 1.0,
            readOnly: false,
            maxLines: 5,
            width: size.width * 0.9,
            height: 150,
            maxLength: 150,
            hintText: "Enter Description",
            controller: desController,
          ),
          TextFieldForForm(
            opacity: 0.5,
            readOnly: true,
            maxLines: 5,
            width: size.width * 0.9,
            height: 100,
            maxLength: 150,
            hintText: "",
            controller: userEmailController,
          ),
          TextFieldForForm(
            opacity: 0.5,
            readOnly: true,
            maxLines: 5,
            width: size.width * 0.9,
            height: 100,
            maxLength: 150,
            hintText: "",
            controller: userPhoneController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                            if (para == null) {
                              return;
                            }

                            controller.selectDistrict(para);
                          }),
                    ),
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
                            if (para == null) {
                              return;
                            }

                            controller.selectCat(para);
                          }),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
