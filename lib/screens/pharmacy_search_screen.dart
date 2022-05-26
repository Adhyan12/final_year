import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/database.dart';
import 'package:final_year_project/screens/screens.dart';

import '../components/constants.dart';

class PharmSearchScreen extends StatefulWidget {
  const PharmSearchScreen({Key? key}) : super(key: key);
  static const String id = 'PharmSearchScreen';

  @override
  State<PharmSearchScreen> createState() => _PharmSearchScreenState();
}

class _PharmSearchScreenState extends State<PharmSearchScreen> {
  Database database = Database();
  late QuerySnapshot searchSnapshot;
  bool flag = false;

  Widget searchList() {
    return ListView.builder(
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context, index) {
          return searchTile(
            name: searchSnapshot.docs[index]["UserName"],
            number: searchSnapshot.docs[index]["PhoneNo"],
            location: searchSnapshot.docs[index]["Location"],
          );
        });
  }

  void initiateSearch() async {
    searchSnapshot = await database.getDocuments('pharmacy');
    setState(() {
      flag = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initiateSearch();
  }
  createChatRoom({ required String userName}){
    List <String> users = [userName,Constants.myName];
    String chatRoomId = getChatRoomId(userName, Constants.myName);

    Map<String, dynamic> chatRoomMap = {
      'users': users,
      'chatRoomId': chatRoomId
    };
    Database().createChatRoom(chatRoomMap, chatRoomId);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  ConversationScreen(chatRoomId: chatRoomId),
        ));
  }

  Widget searchTile({required String name, required String location, required String number}){
    return Container(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          createChatRoom(userName: name);
        },
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  location,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Text(
              number,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_sharp,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 35,
            )
          ],
        ),
      ),
      body: flag ? searchList() : Container(),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return '$b\_$a';
  } else {
    return "$a\_$b";
  }
}
