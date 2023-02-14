import 'package:flutter/material.dart';

class FormValidator {
  final GlobalKey<FormFieldState<String>> passwordFormKey =
      GlobalKey<FormFieldState<String>>();

  static String? validateEmail(String? value) {
    final verifyEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.trim().isEmpty) {
      return 'required*';
    }
    if (!verifyEmail.hasMatch(value.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validateNonRequiredEmail(String? value) {
    final verifyEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!verifyEmail.hasMatch(value!.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validateOptionalEmail(String? value) {
    final verifyEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value!.trim().isNotEmpty && !verifyEmail.hasMatch(value.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final verifyPhoneNum = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

    if (value!.trim().isEmpty) {
      return 'Please Enter Phone Number';
    }
    if (value.trim().length < 10) {
      return 'Number less than 10';
    }
    if (!verifyPhoneNum.hasMatch(value.trim())) {
      return 'Enter a valid Phone Number';
    }
    return null;
  }

  static String? validateNumberValue(String? value) {
    final verifyPhoneNum = RegExp(r'^[0-9]*$');
    if (value!.trim().isEmpty) {
      return 'Please Enter a Number';
    }
    if (!verifyPhoneNum.hasMatch(value.trim())) {
      return 'Enter a valid a Number';
    }
    return null;
  }

  static String? emptyFieldValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'required*';
    }
    return null;
  }

  //validate password
  String? validatePassword(String value) {
    final passwordField = passwordFormKey.currentState;

    if (passwordField!.value == null || passwordField.value!.isEmpty) {
      return 'Password is Required!';
    }
    if (passwordField.value != value) {
      return 'The password don\'t match!';
    }
    return null;
  }
}
