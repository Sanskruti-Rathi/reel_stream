import 'package:flutter/material.dart';
import 'dart:io';
import 'package:reel_stream/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';
class ConfirmScreen extends StatefulWidget {
  final File  videoFile;
  final String videoPath;

  const ConfirmScreen({super.key,required this.videoFile, required this.videoPath});

  @override

  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                width:MediaQuery.of(context).size.width,
                child: VideoPlayer(controller),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width:MediaQuery.of(  context).size.width-20,
                  child: TextInputField(
                    controller: songController, 
                    labelText: "Song Name", 
                    icon: Icons.music_note,),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width:MediaQuery.of(  context).size.width-20,
                  child: TextInputField(
                    controller: captionController, 
                    labelText: "Caption", 
                    icon: Icons.closed_caption,),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed:(){}, 
                child: Text("Share",style : TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                ),
                ),

              ],
                ),
              )
        ],
        )
          
      ),



    );
  }
}