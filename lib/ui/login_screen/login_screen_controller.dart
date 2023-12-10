import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tech_verito_assignment/routes_and_pages/routes_pages.dart';

class LogInScreenController extends GetxController{
  TextEditingController logInEditingController=TextEditingController();
  TextEditingController passwordEditingController=TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool visible = false;
  var temp;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
}
  void CheckLogInValues(){
    if(logInEditingController.text.isNotEmpty && passwordEditingController.text.isNotEmpty){
      Get.toNamed(ProductRoutesPaths.productHome);
    }
  }
  void verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: passwordEditingController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        CheckLogInValues();
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }

}