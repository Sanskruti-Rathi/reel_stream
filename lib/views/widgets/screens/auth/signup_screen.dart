import 'package:flutter/material.dart';
import 'package:reel_stream/constants.dart';
import 'package:reel_stream/views/widgets/text_input_field.dart';


class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Reelstream",
          style: TextStyle(
            fontSize: 35,
            color: buttonColor,
            fontWeight: FontWeight.w900,
              ),),
            Text("Register",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),),
            const SizedBox(height: 25),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      "https://www.shutterstock.com/shutterstock/photos/2470054311/display_1500/stock-vector-avatar-gender-neutral-silhouette-vector-illustration-profile-picture-no-image-for-social-media-2470054311.jpg",
                  ),
                  backgroundColor: Colors.black,
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed:() => authContoller.pickImage(),
                    icon: const Icon(
                        Icons.add_a_photo
                    ),
                  ),
                ),
              ],
            ),
           const SizedBox(height: 15),
           Container(
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.symmetric(horizontal: 20),
             child: TextInputField(
               controller: _usernameController,
               labelText: "Username",
               icon:Icons.person),
            ),
             const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _emailController,
                  labelText: "Email",
                  icon:Icons.email ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                  controller: _passwordController,
                  labelText: "Password",
                  icon: Icons.lock,
                  isObscure: true,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width-40,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: buttonColor,
              ),
              child: InkWell(
                onTap: () => authContoller.registerUser(
                  _usernameController.text,
                   _emailController.text,
                    _passwordController.text, 
                    authContoller.profilePhoto,
                    ),
                  
                
                child: const Center(
                  child: Text("Register",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                style: TextStyle(
                  fontSize: 20,
                ),),
                InkWell(
                  onTap: (){
                    print("navigating user");
                  },
                  child: Text("Login",
                  style: TextStyle(
                    fontSize: 20,
                    color: buttonColor,
                  ),),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }
}
