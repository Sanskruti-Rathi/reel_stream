import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reel_stream/constants.dart';
import 'package:reel_stream/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

@override
void initState() {
  super.initState();
  profileController.updateUserId(widget.uid);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.user.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black12,
            leading: const Icon(Icons.person_add_alt_1_outlined),
            actions: const [Icon(Icons.more_horiz)],
            title: Text(
              controller.user["name"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.user["profilePhoto"],
                              height: 100,
                              width: 100,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                controller.user["following"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Following",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.black54,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user["followers"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.black54,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.user["likes"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text("Likes", style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 140,
                        height: 47,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              if (widget.uid == authContoller.user.uid) {
                                authContoller.signOut();
                              } else {
                                controller.followUser();
                              }
                            },
                            child: Text(
                              widget.uid == authContoller.user.uid
                                  ? "Sign Out"
                                  : controller.user["isFollowing"] == true
                                  ? "UnFollow"
                                  : "Follow",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Video list
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.user["thumbnails"].length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                            ),
                        itemBuilder: (context, index) {
                          String thumbnail = controller.user["thumbnails"][index];
                          return CachedNetworkImage(
                            imageUrl: thumbnail,
                            fit: BoxFit.cover,
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
