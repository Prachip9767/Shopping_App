import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_verito_assignment/ui/login_screen/login_screen_controller.dart';
import 'package:tech_verito_assignment/utils/constants.dart';

class LogInScreen extends GetView<LogInScreenController>{
  static const routeName='/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.logInScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(color: Colors.white,
          child:Column(children: [
            TextField(
              controller: controller.logInEditingController,
              decoration: InputDecoration(labelText: 'Enter phone number'),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
                onPressed: () async {
                  controller.temp = await FirebaseAuthentication().sendOTP( controller.logInEditingController.text);
                  // ConfirmationResult confirmationResult = await controller.auth.signInWithPhoneNumber('+44 7123 123 456', RecaptchaVerifier(
                  //   container: 'recaptcha',
                  //   size: RecaptchaVerifierSize.compact,
                  //   theme: RecaptchaVerifierTheme.dark, auth: controller.auth.app,
                  // ));
                },
                child: const Text('Log In')
            ),
            const SizedBox(height: 50,),
            TextFormField(controller: controller.passwordEditingController,),
            const SizedBox(height: 60,),
            ElevatedButton(
                onPressed: () async {
                  FirebaseAuthentication().authenticate(controller.temp, controller.passwordEditingController.text);
                },
                child: const Text('Log In')
            )
          ]),),
      ),
    );
  }

  Widget inputTextField(String labelText, TextEditingController textEditingController, BuildContext context) =>
      Padding(
        padding: EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            obscureText: labelText == "OTP" ? true : false,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: TextStyle(color: Colors.blue),
              filled: true,
              fillColor: Colors.blue[100],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
            ),
          ),
        ),
      );
}


class FirebaseAuthentication {
  String phoneNumber = "";

  sendOTP(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult result = await auth.signInWithPhoneNumber(
      '+91$phoneNumber',
    );
    printMessage("OTP Sent to +91 $phoneNumber");
    return result;
  }

  authenticate(ConfirmationResult confirmationResult, String otp) async {
    UserCredential userCredential = await confirmationResult.confirm(otp);
    userCredential.additionalUserInfo!.isNewUser
        ? printMessage("Authentication Successful")
        : printMessage("User already exists");
  }

  printMessage(String msg) {
    debugPrint(msg);
  }
}