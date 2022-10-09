import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monetization_system/data/services/cloud_functions/create_post.dart';
import 'package:monetization_system/presentation/pages/home_page.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class PostStatus extends StatefulWidget {
  const PostStatus({Key? key}) : super(key: key);

  @override
  State<PostStatus> createState() => _PostStatusState();
}

class _PostStatusState extends State<PostStatus> {
  var hasLoaded = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Posts/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Posts/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  final box = GetStorage();

  @override
  void initState() {
    getData();

    super.initState();
  }

  var dt = DateTime.now();

  late String name = '';
  late String profilePicture = '';
  late String email = '';

  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: box.read('email'));

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          name = data['name'];

          profilePicture = data['profilePicture'];
          email = data['email'];
        }
      });
    }
  }

  late String status = '';

  var hasStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: MaterialButton(
              child:
                  TextRegular(text: 'Post', fontSize: 12, color: Colors.white),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: hasStatus != true
                  ? null
                  : () {
                      createPost(
                          name,
                          profilePicture,
                          email,
                          status,
                          imageURL,
                          dt.month.toString() +
                              '/' +
                              dt.day.toString() +
                              '/' +
                              dt.year.toString(),
                          dt.hour.toString() + ':' + dt.minute.toString());
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                                content: const Text(
                                  'Status Posted Succesfully!',
                                  style: TextStyle(fontFamily: 'QRegular'),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ));
                    },
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
                child: ListTile(
              leading: CircleAvatar(
                minRadius: 35,
                maxRadius: 35,
                backgroundImage: NetworkImage(profilePicture),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  onChanged: (_input) {
                    setState(() {
                      hasStatus = true;
                    });

                    status = _input;
                  },
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                      hintText: 'Write a status...'),
                  maxLines: 20,
                ),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 30),
            child: Row(
              children: [
                TextBold(
                    text: "${status.length}/480",
                    fontSize: 18,
                    color: Colors.blue),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    uploadPicture('gallery');
                  },
                  icon: const Icon(
                    Icons.image,
                    color: Colors.blue,
                  ),
                ),
                TextBold(
                    text: hasLoaded ? "Image Uploaded" : 'No Image',
                    fontSize: 15,
                    color: Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }
}
