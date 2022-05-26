import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/components/database.dart';

class VetSearchScreen extends StatefulWidget {
  const VetSearchScreen({Key? key}) : super(key: key);
  static const String id = 'VetSearchScreen';

  @override
  State<VetSearchScreen> createState() => _VetSearchScreenState();
}

class _VetSearchScreenState extends State<VetSearchScreen> {
  Database database = Database();
  late QuerySnapshot searchSnapshot;
  bool flag = false;

  Widget searchList() {
    return ListView.builder(
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context, index) {
          return VetSearchTile(
            name: searchSnapshot.docs[index]["UserName"],
            number: searchSnapshot.docs[index]["PhoneNo"],
            location: searchSnapshot.docs[index]["add"],
          );
        });
  }
  void initiateSearch()async{
    searchSnapshot = await database.getDocuments('vet');
    setState(() {
      flag=true;
    });
  }

  @override
  void initState(){
    super.initState();
    initiateSearch();
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
      body: flag?searchList():Container(),
    );
  }
}

class VetSearchTile extends StatelessWidget {
  final String name, location, number;
  const VetSearchTile(
      {required this.name, required this.number, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: (){
          // Navigator.pushNamed(context,GeneralRegistrationScreen.id );
        },
        child: Row(
          children: [
            Column(
              children: [
                Text(name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Text(location,style:const  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            ),
            const Spacer(),
            Text(number,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
