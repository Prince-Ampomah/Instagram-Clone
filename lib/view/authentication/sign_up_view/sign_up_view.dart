import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/view/authentication/sign_up_view/sign_up_name_and_password_view.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_circular_image.dart';
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

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
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
              CircularImageContainer(
                height: 0.2,
                width: 0.2,
                border: Border.all(
                  width: 1.5,
                ),
              ),
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
                              hintText: 'Phone Number',
                              filled: true,
                              fillColor: AppColors.textFieldColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // login button
                            MainButton(
                              onPressed: () {
                                tabController.animateTo(1);
                              },
                              title: 'Next',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CustomFormField(
                            hintText: 'Email',
                            filled: true,
                            fillColor: AppColors.textFieldColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // login button
                          MainButton(
                            onPressed: () {
                              Get.to(const CreateNameAndPasswordView());
                            },
                            title: 'Next',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Get.to(const SignInView()),
                      child: CustomRichText(
                        text1: 'Already have an account? ',
                        text2: 'Log in.',
                        text1Style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 11,
                                ),
                        text2Style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.deepButtonColor,
                                  fontSize: 11,
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
}
