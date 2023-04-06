import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/utils.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_appbar.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../repository/respository_implementation/auth_implementation.dart';

class VerifyUserEmailView extends StatefulWidget {
  const VerifyUserEmailView({
    super.key,
    this.resendSendEmailLink,
  });

  final VoidCallback? resendSendEmailLink;

  @override
  State<VerifyUserEmailView> createState() => _VerifyUserEmailViewState();
}

class _VerifyUserEmailViewState extends State<VerifyUserEmailView> {
  late Timer timer;

  int startTime = 30;

  void countDownTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (startTime == 0) {
          timer.cancel();
        } else {
          startTime--;
        }
      });
    });
  }

  @override
  void initState() {
    countDownTime();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Verify Email',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'An email verification link has been sent to the email you provided',
              textAlign: TextAlign.center,
              style: AppTheme.textStyle(context).titleMedium,
            ),
            const SizedBox(height: 20),

            //TODO: check the time firebase email auth expires and replace it with time count down
            Text(
              '$startTime ${startTime != 0 ? 'secs' : 'sec'}',
              textAlign: TextAlign.center,
              style: AppTheme.textStyle(context).titleMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: startTime == 0 ? widget.resendSendEmailLink : null,
                icon: const Icon(Icons.mail),
                label: const Text('Resend Verification Link'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  foregroundColor: startTime == 0
                      ? MaterialStateProperty.all<Color>(Colors.white)
                      : null,
                  backgroundColor: startTime == 0
                      ? MaterialStateProperty.all<Color>(AppColors.buttonColor)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MainButton(
              onPressed: () async {
                try {
                  await firebaseAuth.currentUser!.delete();
                } catch (e) {
                  Utils.showErrorMessage(e.toString());
                }
              },
              title: 'Cancel',
              bgColor: const Color(0xFF505050),
            ),
          ],
        ),
      ),
    );
  }
}
