import 'package:cloud_firestore/cloud_firestore.dart';

Future createAccount(String password, String name, String email, String type,
    String profilePicture) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc();

  final json = {
    'password': password,
    'name': name,
    'email': email,
    'type': type,
    'profilePicture': profilePicture,
    'subscription': "Classic",
    'points': 20,
    'coverPhoto': "",
    'id': docUser.id,
  };

  await docUser.set(json);
}
