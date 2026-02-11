import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class CloudinaryWebService {

  // YOUR VALUES (from your screenshot)
  static const String cloudName = "dk9etce61";
  static const String uploadPreset = "flutter_upload";

  static Future<String?> uploadWebFile({
    required Uint8List bytes,
    required String fileName,
    required String fileType, // "image" | "video" | "raw"
  }) async {

    String url =
        "https://api.cloudinary.com/v1_1/$cloudName/$fileType/upload";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['upload_preset'] = uploadPreset;

      String? mimeType = lookupMimeType(fileName);

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
          contentType:
              mimeType != null ? http.MediaType.parse(mimeType) : null,
        ),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var json = jsonDecode(responseBody);
        String secureUrl = json["secure_url"];
        print("Uploaded URL: $secureUrl");
        return secureUrl;
      } else {
        print("Upload failed: ${response.statusCode}");
        print(responseBody);
        return null;
      }
    } catch (e) {
      print("Cloudinary Web Error: $e");
      return null;
    }
  }

  // -------- Beginner friendly helpers --------

  static Future<String?> uploadImageWeb(
      Uint8List bytes, String fileName) async {
    return await uploadWebFile(
      bytes: bytes,
      fileName: fileName,
      fileType: "image",
    );
  }

  static Future<String?> uploadVideoWeb(
      Uint8List bytes, String fileName) async {
    return await uploadWebFile(
      bytes: bytes,
      fileName: fileName,
      fileType: "video",
    );
  }

  static Future<String?> uploadPdfWeb(
      Uint8List bytes, String fileName) async {
    return await uploadWebFile(
      bytes: bytes,
      fileName: fileName,
      fileType: "raw",   // Cloudinary treats PDFs as raw
    );
  }
}