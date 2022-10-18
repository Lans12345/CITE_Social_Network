import 'package:cloud_firestore/cloud_firestore.dart';

Future addComment(String name, String email, String profilePicture,
    String commentId, String time, String comment) async {
  final docUser = FirebaseFirestore.instance.collection('Comments').doc();

  final json = {
    'name': name,
    'email': email,
    'time': time,
    'comment': comment,
    'profilePicture': profilePicture,
    'commentId': commentId,
    'id': docUser.id,
  };

  await docUser.set(json);
}
