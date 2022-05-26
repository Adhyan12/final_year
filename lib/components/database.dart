import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createDocument(userMap, collection) async {
    await firestore
        .collection(collection)
        .doc(auth.currentUser!.uid)
        .set(userMap);
  }

  searchDocument(number)async {
    print(number);
    final pharm = firestore.collection('pharmacy');
    QuerySnapshot val = await pharm.where('PhoneNo', isEqualTo: number).get();
    if (val.docs.isEmpty) {
      final user = firestore.collection('user');
      QuerySnapshot val1 = await user.where('PhoneNo', isEqualTo: number).get();
      if (val1.docs.isEmpty) {
        final vet = firestore.collection('vet');
        QuerySnapshot val3 = await vet.where('PhoneNo', isEqualTo: number).get();
        if (val3.docs.isEmpty)
          return 'not registered';
        else
          return 'vet';
      } else
        return 'user';
    } else
      return 'pharmacy';
  }

  getDocuments(collection) async {
    return await firestore.collection(collection).get();
  }

  getDocumentsByPhoneNumber(number, collection) async {
    return await firestore
        .collection(collection)
        .where('phoneNo', isEqualTo: number)
        .get();
  }

  createChatRoom(chatMap, chatRoomId) {
    firestore.collection('ChatRoom').doc(chatRoomId).set(chatMap);
  }

  addConversationMessages(chatRoomId, messageMap) {
    firestore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(chatRoomId) async {
    return firestore
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time',descending: false)
        .snapshots();
  }

  getChatRooms(userName)async{
    return firestore.collection('ChatRoom')
        .where('users', arrayContains: userName)
        .snapshots();
  }
}
