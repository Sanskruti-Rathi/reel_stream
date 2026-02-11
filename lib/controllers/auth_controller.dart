import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reel_stream/constants.dart';
import 'package:reel_stream/models/user.dart' as model;
import 'package:reel_stream/views/widgets/screens/auth/login_screen.dart';
import 'package:reel_stream/views/widgets/screens/home_screen.dart';
import 'package:reel_stream/cloudinary_web_service.dart';
import 'dart:typed_data';



class AuthController extends GetxController {
  static AuthController instance = Get.find();

   late Rx<User?>_user;
   late Rx<Uint8List?> _pickedImage;

Uint8List? get profilePhoto => _pickedImage.value;

   @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(()=> LoginScreen());
    }else{
      Get.offAll(()=> HomeScreen());
    }
  }

 void pickImage() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    Uint8List bytes = await pickedImage.readAsBytes();
    _pickedImage = Rx<Uint8List?>(bytes);

    Get.snackbar(
        "Profile Picture", "You have successfully selected your profile picture!");
  }
}

  
//registering the user 
Future<void> registerUser(
    String username,
    String email,
    String password,
    Uint8List? image,
) async {
  try {
    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        image != null) {

      // 1️⃣ Create Firebase Auth user
      UserCredential cred =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2️⃣ Upload image to Cloudinary
      String? downloadUrl =
          await CloudinaryWebService.uploadImageWeb(
        image,
        "${cred.user!.uid}.jpg",
      );

      if (downloadUrl == null) {
        Get.snackbar("Upload Failed", "Image upload failed");
        return;
      }

      // 3️⃣ Save user data in Firestore
      model.User user = model.User(
        name: username,
        email: email,
        uid: cred.user!.uid,
        profilePhoto: downloadUrl,
      );

      await firestore
          .collection("users")
          .doc(cred.user!.uid)
          .set(user.toJson());

    } else {
      Get.snackbar("Error creating account", "Please enter all the fields");
    }
  } catch (e) {
    Get.snackbar("Error creating account", e.toString());
  }
}


void  loginUser (String email,String password) async {
  try{
    if(email.isNotEmpty && password.isNotEmpty){
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    }else {
      Get.snackbar("Error logging in","Please enter all the fields");
    }
      

  }catch(e){
    Get.snackbar("Error logging in",e.toString());
  }
}
}
    
  