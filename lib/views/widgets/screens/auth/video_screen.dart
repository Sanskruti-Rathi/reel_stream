import 'package:flutter/material.dart';
import 'package:reel_stream/views/widgets/circle_animatin.dart';
import 'package:reel_stream/views/widgets/video_player_item.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  buildProfile(String profilePhoto){
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

  buildMusicAlbum(String profilePhoto){
    return SizedBox(
      width: 60,
      height:60,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(11),
          height: 50,
          width:50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors:[Colors.grey, Colors.white]),
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

    /// Dummy data just for UI preview
    const demoVideo =
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
    const demoImage =
        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e";

    return Scaffold(
      body: PageView.builder(
        itemCount: 5, // 👈 just for UI preview
        scrollDirection: Axis.vertical,
        itemBuilder:(context, index) {

          return Stack(
            children: [

              /// VIDEO
              VideoPlayerItem(videoUrl: demoVideo),

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("username",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text("caption",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white)),
                                Row(
                                  children: [
                                    Icon(Icons.music_note,
                                        size: 15, color: Colors.white),
                                    Text("song name",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// RIGHT SIDE BUTTONS
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: size.height/5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              buildProfile(demoImage),

                              const Column(
                                children: [
                                  Icon(Icons.favorite,
                                      size:40,color:Colors.red),
                                  SizedBox(height: 7),
                                  Text("2,200",
                                      style: TextStyle(
                                          fontSize: 20,color: Colors.white))
                                ],
                              ),

                              const Column(
                                children: [
                                  Icon(Icons.comment,
                                      size:40,color:Colors.white),
                                  SizedBox(height: 7),
                                  Text("2",
                                      style: TextStyle(
                                          fontSize: 20,color: Colors.white))
                                ],
                              ),

                              const Column(
                                children: [
                                  Icon(Icons.reply,
                                      size:40,color:Colors.white),
                                  SizedBox(height: 7),
                                  Text("2",
                                      style: TextStyle(
                                          fontSize: 20,color: Colors.white))
                                ],
                              ),

                              CircleAnimation(
                                child: buildMusicAlbum(demoImage),
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
      ),
    );
  }
}
