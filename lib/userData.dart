import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final int age;
  final double weight;

  UserModel({
    required this.uid,
    required this.username,
    required this.age,
    required this.weight
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      uid: documentSnapshot.id,
      username: documentSnapshot.get('username'),
      age: documentSnapshot.get('age'),
      weight: documentSnapshot.get('weight'),
    );
  }
}

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromDocumentSnapshot(userSnapshot);
  }

  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot userSnapshot = await _firestore.collection('users').get();
    return userSnapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList();
  }

}




