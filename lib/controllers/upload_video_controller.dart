import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reel_stream/cloudinary_web_service.dart';
import 'package:reel_stream/models/video.dart';
import 'package:video_compress/video_compress.dart';
import 'package:reel_stream/constants.dart';
import 'package:flutter/foundation.dart';


class UploadVideoController extends GetxController {

  /// ---------------- MOBILE ONLY ----------------
  Future<File> _compressVideoMobile(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file!;
  }

  /// ---------------- GET THUMBNAIL ----------------
  Future<File> _getThumbnailMobile(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  /// ---------------- MAIN UPLOAD FUNCTION ----------------
  /// For Web → pass videoBytes
  /// For Mobile → pass videoPath
  uploadVideo({
    required String songName,
    required String caption,
    String? videoPath,        // for mobile
    Uint8List? videoBytes,    // for web
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(uid).get();

      var allDocs = await firestore.collection("videos").get();
      int len = allDocs.docs.length;
      String id = "Video $len";

      String videoUrl;
      String thumbnailUrl;

      /// ===================== WEB =====================
      if (kIsWeb) {
        if (videoBytes == null) {
          throw "Web upload requires video bytes";
        }

        /// Upload Video
        videoUrl = (await CloudinaryWebService.uploadVideoWeb(
          videoBytes,
          "video_$id.mp4",
        ))!;

        /// Create thumbnail from first frame (simple trick)
        thumbnailUrl = videoUrl; // optional fallback thumbnail
      }

      /// ===================== MOBILE =====================
      else {
        if (videoPath == null) {
          throw "Mobile upload requires video path";
        }

        /// Compress Video
        File compressedVideo = await _compressVideoMobile(videoPath);
        Uint8List videoData = await compressedVideo.readAsBytes();

        videoUrl = (await CloudinaryWebService.uploadVideoWeb(
          videoData,
          "video_$id.mp4",
        ))!;

        /// Thumbnail
        File thumbFile = await _getThumbnailMobile(videoPath);
        Uint8List thumbData = await thumbFile.readAsBytes();

        thumbnailUrl = (await CloudinaryWebService.uploadImageWeb(
          thumbData,
          "thumb_$id.jpg",
        ))!;
      }

      /// ===================== SAVE TO FIRESTORE =====================
      Video video = Video(
        username: (userDoc.data() as Map<String, dynamic>)["name"],
        uid: uid,
        id: id,
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnailUrl,
        profilePhoto:
            (userDoc.data() as Map<String, dynamic>)["profilePhoto"],
      );

      await firestore.collection("videos").doc(id).set(video.toJson());

      Get.back();

    } catch (e) {
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }
}
