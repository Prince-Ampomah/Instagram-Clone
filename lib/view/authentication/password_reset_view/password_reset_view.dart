import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/theme/theme.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';
import 'package:instagram_clone/core/widgets/cus_form_field.dart';
import 'package:instagram_clone/core/widgets/cus_main_button.dart';
import 'package:instagram_clone/core/widgets/cus_rich_text.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Login help',
        titleStyle: AppTheme.textStyle(context)
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                CustomRichText(
                  textAlign: TextAlign.center,
                  text1: 'Find your account\n\n',
                  text2: 'Enter your email linked to your account',
                  text1Style: AppTheme.textStyle(context).titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                  text2Style: AppTheme.textStyle(context)
                      .labelMedium!
                      .copyWith(color: AppColors.greyColor),
                ),
                const SizedBox(height: 30),
                const CustomFormField(
                  hintText: 'Email',
                  filled: true,
                  fillColor: AppColors.textFieldColor,
                ),
                const SizedBox(height: 20),
                MainButton(
                  onPressed: () {},
                  title: 'Reset password',
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    const SizedBox(width: 10),
                    Text('OR', style: AppTheme.textStyle(context).labelMedium),
                    const SizedBox(width: 10),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                // facebook widget
                MainButton(
                  onPressed: () {},
                  iconData: FontAwesomeIcons.facebook,
                  title: 'Contiue as Prince Ampomah',
                  bgColor: Colors.blue.shade700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
