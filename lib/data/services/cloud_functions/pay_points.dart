import 'package:cloud_firestore/cloud_firestore.dart';

Future payPoints(String name, String profilePicture, String email,
    String subscription, int points) async {
  final docUser = FirebaseFirestore.instance.collection('Points').doc();

  final json = {
    'name': name,
    'profilePicture': profilePicture,
    'email': email,
    'subscription': subscription,
    'points': points,
    'id': docUser.id,
    'type': "Points"
  };

  await docUser.set(json);
}

Future payPremium(String name, String profilePicture, String email,
    String subscription, int points) async {
  final docUser = FirebaseFirestore.instance.collection('Premium').doc();

  final json = {
    'name': name,
    'profilePicture': profilePicture,
    'email': email,
    'subscription': subscription,
    'points': points,
    'id': docUser.id,
    'type': "Premium"
  };

  await docUser.set(json);
}
