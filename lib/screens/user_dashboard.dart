import 'package:flutter/material.dart';
import 'package:final_year_project/components/reusable_card.dart';

class UserDashBoard extends StatelessWidget {
  static const String id = 'UserDashBoard';

  const UserDashBoard({Key? key}) : super(key: key);

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
              children: const [
                ListTile(
                  title: Text('UserName', style: TextStyle(fontSize: 25)),
                  leading: Icon(Icons.person, color: Colors.white),
                )
              ],
            ),
          )),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Hi UserName !! 🐾 ',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReusableCard(
                colour: Colors.red,
                cardChild: Column(
                  children: const [
                    Image(
                      image: AssetImage('images/drugstore.png'),
                      width: 100,
                      height: 100,
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
              ReusableCard(
                colour: Colors.blue,
                cardChild: Column(
                  children: const [
                    Image(
                      image: AssetImage('images/veterinarian.png'),
                      width: 100,
                      height: 100,
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
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          ReusableCard(
              cardChild: Container(
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              colour: Colors.lightBlueAccent),
          const Center(
            child: Text(
              'Crafted with ❤ by Adhyan',
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
