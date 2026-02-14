import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:reel_stream/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class ConfirmScreen extends StatefulWidget {
  final File? videoFile;
  final Uint8List? videoBytes;
  final String videoPath;

  const ConfirmScreen({
    super.key,
    this.videoFile,
    this.videoBytes,
    required this.videoPath,
  });

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;

  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoPath),
      );
    } else {
      controller = VideoPlayerController.file(widget.videoFile!);
    }

    controller.initialize().then((_) {
      setState(() {});
      controller.play();
      controller.setLooping(true);
      controller.setVolume(1);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: controller.value.isInitialized
                  ? VideoPlayer(controller)
                  : const Center(child: CircularProgressIndicator()),
            ),

            const SizedBox(height: 30),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width - 20,
              child: TextInputField(
                controller: _songController,
                labelText: "Song Name",
                icon: Icons.music_note,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width - 20,
              child: TextInputField(
                controller: _captionController,
                labelText: "Caption",
                icon: Icons.closed_caption,
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => uploadVideoController.uploadVideo(
                _songController.text,
                _captionController.text,
                widget.videoPath,
              ),
              child: const Text(
                "Share",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
