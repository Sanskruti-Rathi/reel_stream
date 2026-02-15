import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reel_stream/controllers/video_controller.dart';
import 'package:reel_stream/views/widgets/circle_animatin.dart';
import 'package:reel_stream/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 50,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(profilePhoto, fit: BoxFit.cover),
            ),
          ),
        ),
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(11),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient:
                const LinearGradient(colors: [Colors.grey, Colors.white]),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(profilePhoto, fit: BoxFit.cover),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final video = videoController.videoList[index];

            return Stack(
              children: [
                /// VIDEO
                VideoPlayerItem(videoUrl: video.videoUrl),

                Column(
                  children: [
                    const SizedBox(height: 100),

                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /// LEFT TEXT
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(video.username,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Text(video.caption,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white)),
                                  Row(
                                    children: [
                                      const Icon(Icons.music_note,
                                          size: 15, color: Colors.white),
                                      Text(video.songName,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight:
                                                  FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// RIGHT SIDE BUTTONS
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(top: size.height / 5),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                buildProfile(video.profilePhoto),

                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () => videoController
                                          .likeVideo(video.id),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 40,
                                        color: video.likes.contains(
                                                authController.user.uid)
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(video.likes.length.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white))
                                  ],
                                ),

                                Column(
                                  children: [
                                    const Icon(Icons.comment,
                                        size: 40, color: Colors.white),
                                    const SizedBox(height: 7),
                                    Text(video.commentCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white))
                                  ],
                                ),

                                Column(
                                  children: [
                                    const Icon(Icons.reply,
                                        size: 40, color: Colors.white),
                                    const SizedBox(height: 7),
                                    Text(video.shareCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white))
                                  ],
                                ),

                                CircleAnimation(
                                  child: buildMusicAlbum(
                                      video.profilePhoto),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
