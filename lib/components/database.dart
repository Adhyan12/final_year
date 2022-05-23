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

  searchDocument(number) {
    final pharm = firestore.collection('pharmacy');
    final val = pharm.where('shopPhone', isEqualTo: number);
    if (val == null) {
      final user = firestore.collection('user');
      final val1 = user.where('MobNum', isEqualTo: number);
      if (val1 == null) {
        final vet = firestore.collection('vet');
        final val3 = vet.where('mobNum', isEqualTo: number);
        print('{$val  $val1 $val3');
        if (val3 == null)
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
