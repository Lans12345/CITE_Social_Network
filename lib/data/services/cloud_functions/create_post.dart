import 'package:cloud_firestore/cloud_firestore.dart';

Future createPost(String name, String profilePicture, String email,
    String caption, String imageURL, String date, String time) async {
  final docUser = FirebaseFirestore.instance.collection('Posts').doc();

  final json = {
    'name': name,
    'email': email,
    'profilePicture': profilePicture,
    'caption': caption,
    'imageURL': imageURL,
    'date': date,
    'time': time,
    'likes': 0,
    'id': docUser.id,
  };

  await docUser.set(json);
}
