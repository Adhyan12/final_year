import 'package:final_year_project/components/helperfunctions.dart';
import 'package:final_year_project/screens/pharmacy_search_screen.dart';
import 'package:final_year_project/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/reusable_card.dart';
import '../components/authservice.dart';
import '../components/constants.dart';
import '../components/database.dart';

class UserDashBoard extends StatefulWidget {
  static const String id = 'UserDashBoard';

  const UserDashBoard({Key? key}) : super(key: key);

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
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
                  return ChatRoomTile(snapShot.data.docs[index]['chatRoomId']
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
      });
    });
    setState(() {
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_sharp,
        //     size: 35,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
      drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.only(top: 40.0, left: 10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff84aeeb), Color(0xffcdeaf6)])),
            child: Column(
              children: [
                ListTile(
                    title: Text(Constants.myName,
                        style: const TextStyle(fontSize: 25)),
                    leading: const Icon(Icons.person, color: Colors.white),
                    trailing: GestureDetector(
                      onTap: () {
                        AuthService().signOut();
                        Navigator.pushReplacementNamed(
                            context, GeneralRegistrationScreen.id);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Icon(
                          Icons.exit_to_app_outlined,
                          size: 30,
                        ),
                      ),
                    ))
              ],
            ),
          )),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: Text(
              flag ? 'Hi ${Constants.myName} !! 🐾 ' : 'Hello',
              style: const TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PharmSearchScreen.id);
                  },
                  child: ReusableCard(
                    colour: Colors.red,
                    cardChild: Column(
                      children: const [
                        Image(
                          image: AssetImage('images/drugstore.png'),
                          width: 75,
                          height: 75,
                        ),
                        SizedBox(
                          height: 8,
                          width: 150,
                        ),
                        Text(
                          'Pharmacies',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, OwnerSearchScreen.id);
                  },
                  child: ReusableCard(colour: Colors.green,
                  cardChild: Column(
                    children: const[
                      Image(
                        image: AssetImage('images/dog-training.png'),
                        width: 75,
                        height: 75,
                      ),
                      SizedBox(
                        height: 8,
                        width: 150,
                      ),
                      Text(
                        'Owners',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, VetSearchScreen.id);
                  },
                  child: ReusableCard(
                    colour: Colors.blue,
                    cardChild: Column(
                      children: const [
                        Image(
                          image: AssetImage('images/veterinarian.png'),
                          width: 75,
                          height: 75,
                        ),
                        SizedBox(
                          height: 8,
                          width: 150,
                        ),
                        Text(
                          'Veterinarians',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ReusableCard(
            cardChild: Container(
              height: MediaQuery.of(context).size.height * 0.47,
              child: chatRoomList(),
            ),
            colour: Colors.lightBlueAccent,
          ),
          const Center(
            child: Text(
              'Crafted with ❤',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String usereName;
  final String chatRoom;
  const ChatRoomTile(this.usereName, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>ConversationScreen(chatRoomId: chatRoom)));
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
