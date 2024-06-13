import 'package:attendance/constants/appConstants.dart';
import 'package:attendance/constants/assets.dart';
import 'package:attendance/domain/LogInViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final LoginController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (context) {
        return Row(
          children: [
            Obx(() => CircleAvatar(
              radius: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: CachedNetworkImage(
                  imageUrl: '${AppConstants.BASE_URL.toString()}/${controller.photo.value}',
                  filterQuality: FilterQuality.low,
                  errorWidget: (context, url, error) => Image.asset(Assets.imagesUser),
                ),
              ),
              )
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.employee['name'] ?? controller.username.value ,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() => Text(
                  controller.position['name'] ?? controller.userEmail.value,
                  style: const TextStyle(color: Colors.black54),
                ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.notifications, color: Colors.black54),
          ],
        );
      }
    );
  }
}
