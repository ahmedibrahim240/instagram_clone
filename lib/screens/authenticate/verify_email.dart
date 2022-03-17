import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/controllers/verify_email_conttroller.dart';
// import 'package:get/get.dart';
import 'package:instagram_clone/core/core_export.dart';

class VerifyEmail extends GetWidget<VerifyEmailController> {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () => controller.initState(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              text: 'A verification email has been sent to',
              fontSize: 12,
              alignment: Alignment.center,
            ),
            CustomText(
              text: '${firebaseAuth.currentUser!.email}.',
              color: kBlueColor,
              fontSize: 14,
              alignment: Alignment.center,
            ),
            SizedBox(height: defaultSize * 2),
            Obx(
              () => (!controller.reSentEmail.value)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButtom(
                      onPreessed: () {
                        controller.reSendEmailVerification();
                      },
                      bgColor: kBlueColor,
                      cardMargin: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.email,
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            text: 'Resent Email',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
            ),
            SizedBox(height: defaultSize),
            CustomButtom(
              onPreessed: () {
                authControllers.signOut();
              },
              bgColor: kMobileSearchColor,
              margin: const EdgeInsets.all(8),
              cardMargin: const EdgeInsets.symmetric(horizontal: 20),
              child: const CustomText(
                text: 'Cansel',
                color: kBlueColor,
                fontSize: 15,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class VerifyEmail extends StatefulWidget {
//   const VerifyEmail({Key? key}) : super(key: key);

//   @override
//   State<VerifyEmail> createState() => _VerifyEmailState();
// }

// class _VerifyEmailState extends State<VerifyEmail> {
//   bool reSent = false;
//   bool isVerifyEmail = false;
//   late User user;
//   late Timer timer;
//   late Timer reSenttimer;
//   int reSentCont = 1;

//   @override
//   void initState() {
//     super.initState();
//     user = firebaseAuth.currentUser!;
//     isVerifyEmail = user.emailVerified;

//     if (!isVerifyEmail) {
//       user.sendEmailVerification();
//     } else {
//       timer = Timer.periodic(
//         const Duration(seconds: 3),
//         (timer) {
//           checkEmailVerified();
//           reSent = true;
//         },
//       );
//     }
//   }

//   Future<void> checkEmailVerified() async {
//     isVerifyEmail = user.emailVerified;
//     if (isVerifyEmail) {
//       timer.cancel();
//       reSenttimer.cancel();
//       await Future.delayed(
//         const Duration(seconds: 2),
//         () {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (_) => const CustonNavBar(),
//             ),
//           );
//         },
//       );
//     } else {
//       await firebaseAuth.currentUser!.reload();
//     }
//   }

//   sendEmailVerification() async {
//     try {
//       await user.sendEmailVerification();
//     } on FirebaseException catch (e) {
//       customErrorSnakBar(
//         error: e.message.toString(),
//       );
//     }
//   }

//   reSendEmailVerification() {
//     sendEmailVerification();
//     int min = 1;
//     reSent = false;
//     min *= reSentCont;
//     reSentCont++;
//     reSent = false;
//     timer = Timer.periodic(
//       Duration(minutes: min),
//       (timer) {
//         checkEmailVerified();
//         reSent = true;
//       },
//     );
//     setState(() {});
//     if (reSentCont == 3) {
//       authControllers.signOut();
//       customErrorSnakBar(
//         error: """'You are sending too many requests...
//             can't register now...
//             try later'""",
//       );
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     timer.cancel();
//     reSenttimer.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
 
 
//   }
// }
