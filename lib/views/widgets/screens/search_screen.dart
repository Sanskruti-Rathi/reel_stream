import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reel_stream/controllers/search_controller.dart';
import 'package:reel_stream/models/user.dart';
import 'package:reel_stream/views/widgets/screens/profile_screen.dart';



class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final UserSearchController searchController =
      Get.put(UserSearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            style: const TextStyle(color: Colors.white),
            onFieldSubmitted: (value) =>
                searchController.searchUser(value),
          ),
        ),

        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user =
                      searchController.searchedUsers[index];

                  return InkWell(
                    onTap: () => Navigator.of(context).push(  
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(uid: user.uid),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage:
                            NetworkImage(user.profilePhoto),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
