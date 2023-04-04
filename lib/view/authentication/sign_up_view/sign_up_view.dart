import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/controller/auth_controller/auth_controller.dart';
import 'package:instagram_clone/core/widgets/cus_image_picker.dart';
import 'package:instagram_clone/view/authentication/sign_up_view/sign_up_name_and_password_view.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/form_validator.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../core/widgets/cus_rich_text.dart';
import '../../../core/widgets/cus_tab_bar.dart';
import '../sign_in_view/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? profileImage;

  void _getUserProfilePic(imageSource) async {
    var imagePath = await getImagePicker(imageSource);
    if (imagePath.isNotEmpty) {
      setState(() {
        profileImage = imagePath;
      });
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.13),
              CustomImagePicker(
                imagePath: profileImage,
                height: 160,
                width: 160,
                placeHolder: Image.asset(Const.userImage),
                borderRadius: BorderRadius.circular(100),
                cameraOnTap: () {
                  _getUserProfilePic(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                galleryOnTap: () {
                  _getUserProfilePic(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              // CircularImageContainer(
              //   height: 0.2,
              //   width: 0.2,
              //   border: Border.all(width: 1.5),
              // ),
              const SizedBox(height: 20),
              CustomTabBar(
                tabController: tabController,
                indicatorWeight: .8,
                labelColor: AppColors.blackColor,
                indicatorColor: AppColors.blackColor,
                unselectedLabelColor: const Color(0xFFA7A7A7),
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('PHONE'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('EMAIL'),
                  ),
                ],
              ),
              Expanded(
                child: Form(
                  key: formKey,
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: tabController,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              CustomFormField(
                                controller: phoneNumberController,
                                hintText: 'Phone Number',
                                filled: true,
                                fillColor: AppColors.textFieldColor,
                                keyboardType: TextInputType.phone,
                                autofillHints: const [
                                  AutofillHints.telephoneNumber
                                ],
                                onSaved: (value) {
                                  phoneNumberController.text = value!.trim();
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              MainButton(
                                onPressed: () => tabController.animateTo(1),
                                title: 'Next',
                                bgColor: AppColors.buttonColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              CustomFormField(
                                controller: emailController,
                                hintText: 'Email',
                                filled: true,
                                fillColor: AppColors.textFieldColor,
                                autofillHints: const [AutofillHints.email],
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.none,
                                validator: FormValidator.validateEmail,
                                onSaved: (value) {
                                  emailController.text = value!.trim();
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              // login button
                              MainButton(
                                onPressed: validateForm,
                                title: 'Next',
                                bgColor: AppColors.buttonColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () => Get.off(() => const SignInView()),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomRichText(
                          text1: 'Already have an account? ',
                          text2: 'Log in.',
                          text1Style:
                              AppTheme.textStyle(context).titleSmall!.copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: 11,
                                  ),
                          text2Style:
                              AppTheme.textStyle(context).titleSmall!.copyWith(
                                    color: AppColors.deepButtonColor,
                                    fontSize: 11,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (profileImage != null) {
        AuthController.instance.userModel.profileImage = profileImage;
      }

      AuthController.instance.userModel.phoneNumber =
          phoneNumberController.text;
      AuthController.instance.userModel.email = emailController.text;
      Get.to(() => const CreateNameAndPasswordView());
    } else {
      showToast(msg: 'Email is required');
    }
  }
}
