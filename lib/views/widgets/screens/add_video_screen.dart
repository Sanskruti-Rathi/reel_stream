import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:reel_stream/constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  ShowOptionsDialog(BuildContext context){
    return showDialog(context:context,builder:(context) => SimpleDialog(
      children: [
        SimpleDialogOption(
        onPressed:() {},
        child: Row(
          children: const [
            Icon(Icons.image),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Text(
                "Gallery",
                style: TextStyle(
                  fontSize: 20
                  ),
                  ),
            ),
          ],
        ),

        ),
      ],

    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => ShowOptionsDialog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: const Center(child: Text(
              "Add Video",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold
                ),
                ),

          ),
          
        ),
          ),
          
      ),
    );
  }
}