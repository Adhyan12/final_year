import 'package:flutter/material.dart';
import 'package:final_year_project/components/authservice.dart';
import '../components/constants.dart';
import '../components/database.dart';
import '../components/helperfunctions.dart';
import 'conversation_screen.dart';

class VetDashBoard extends StatefulWidget {
  const VetDashBoard({Key? key}) : super(key: key);
  static const String id = 'VetDashBoard';

  @override
  State<VetDashBoard> createState() => _VetDashBoardState();
}

class _VetDashBoardState extends State<VetDashBoard> {
  Database database = Database();
  bool flag = false;

  late Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, AsyncSnapshot snapShot) {
        return snapShot.hasData
            ? ListView.builder(
            itemCount: snapShot.data.docs.length,
            itemBuilder: (context, index) {
              return VetChatRoomTile(
                  snapShot.data.docs[index]['chatRoomId']
                      .toString()
                      .replaceAll('_', '')
                      .replaceAll(Constants.myName, ''),
                  snapShot.data.docs[index]['chatRoomId']);
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    database.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
        if(Constants.myName!=''){
          flag=true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app_outlined,
            size: 25,
            color: Colors.black,
          ),
          onPressed: () async {
            await AuthService().signOut();
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              flag ? 'Welcome Dr. ${Constants.myName} !! 🐾 ' : 'Hello',
              style: const TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.bottomLeft,
            child: const Text('Chats',style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding:const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.65,
            child: chatRoomList(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Colors.blue,width:1.5),
            ),
          ),


        ],
      ),
    );
  }
}

class VetChatRoomTile extends StatelessWidget {
  final String usereName;
  final String chatRoom;
  const VetChatRoomTile(this.usereName, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConversationScreen(chatRoomId: chatRoom)));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  usereName.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(usereName),
            ],
          )),
    );
  }
}
