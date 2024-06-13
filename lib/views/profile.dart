import 'package:attendance/constants/appConstants.dart';
import 'package:attendance/constants/assets.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/views/common_widgets/profileList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // static final Email email = Email(
  //   body: '',
  //   subject: 'subject',
  //   recipients: ['rami.omar.ayache@gmail.com'],
  //   isHTML: false,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(Assets.imagesUser)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Get.theme.primaryColor),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("Guest", style: Theme.of(context).textTheme.headlineSmall),
              Text("user app", style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),

              const Divider(
                thickness: 0.1,
              ),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Profile preferences",
                  icon: Icons.account_circle,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Delivery preferences",
                  icon: Icons.delivery_dining,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Change location",
                  icon: Icons.settings,
                  onPress: () {}),
              const Divider(
                thickness: 0.1,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "terms & conditions",
                  icon: Icons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "About us",
                  icon: Icons.developer_mode_rounded,
                  endIcon: false,
                  onPress: () {
                    Get.dialog(
                      Dialog(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Made With ❤️ By #${AppConstants.projectOwnerName}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              Lottie.asset(
                                Assets.imagesCatThinking,
                                addRepaintBoundary: true,
                                width: 300,
                                repeat: false,
                                //height: 400,
                                decoder: customDecoder,
                              ),
                              const Text(
                                "Rate our app",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 14),
                              // RatingBar.builder(
                              //   initialRating: 5,
                              //   minRating: 1,
                              //   direction: Axis.horizontal,
                              //   allowHalfRating: true,
                              //   itemCount: 5,
                              //   itemPadding:
                              //       const EdgeInsets.symmetric(horizontal: 4.0),
                              //   itemBuilder: (context, _) => const Icon(
                              //     Icons.star,
                              //     color: Colors.amber,
                              //   ),
                              //   onRatingUpdate: (rating) {
                              //     print(rating);
                              //   },
                              // ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      onPressed: () async => {
                                        await Get.to(() =>
                                      print('email'))
                                            // FlutterEmailSender.send(email))
                                      }, // Close the dialog
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Get.theme.primaryColor,
                                        //side: BorderSide.none,
                                      ),
                                      child: const Text(
                                        "Email us",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
