import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../widgets/text_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final box = GetStorage();

  @override
  void initState() {
    getData();

    super.initState();
  }

  var dt = DateTime.now();

  late String name = '';
  late String profilePicture = '';
  late String subscription = '';
  late int points = 0;
  late String type = '';
  late String coverPhoto = '';

  late String id = '';

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
          subscription = data['subscription'];
          points = data['points'];
          type = data['type'];

          coverPhoto = data['coverPhoto'];
          id = data['id'];
        }
      });
    }
  }

  var _visible = true;

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
            .ref('CoverPhoto/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('CoverPhoto/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        FirebaseFirestore.instance.collection('Users').doc(id).update({
          'coverPhoto': imageURL,
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

  Future<void> uploadPicture1(String inputSource) async {
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
            .ref('ProfilePicture/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('ProfilePicture/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        FirebaseFirestore.instance.collection('Users').doc(id).update({
          'profilePicture': imageURL,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _visible,
          child: Stack(
            children: [
              coverPhoto == ''
                  ? GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      trailing: const Icon(Icons.upload),
                                      onTap: () {
                                        uploadPicture('gallery');
                                      },
                                      leading: TextRegular(
                                          text: 'Upload Photo',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        color: Colors.black,
                        height: 150,
                        width: double.infinity,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      trailing: const Icon(Icons.upload),
                                      onTap: () {
                                        uploadPicture('gallery');
                                      },
                                      leading: TextRegular(
                                          text: 'Upload Photo',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      trailing: const Icon(Icons.image),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Image.network(
                                                  coverPhoto,
                                                ),
                                              );
                                            });
                                      },
                                      leading: TextRegular(
                                          text: 'View Cover Photo',
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(coverPhoto),
                          ),
                        ),
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 20, bottom: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        profilePicture == ''
                            ? GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                trailing:
                                                    const Icon(Icons.upload),
                                                onTap: () {
                                                  uploadPicture1('gallery');
                                                },
                                                leading: TextRegular(
                                                    text: 'Upload Photo',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  minRadius: 60,
                                  maxRadius: 60,
                                  backgroundImage: NetworkImage(profilePicture),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                trailing:
                                                    const Icon(Icons.upload),
                                                onTap: () {
                                                  uploadPicture1('gallery');
                                                },
                                                leading: TextRegular(
                                                    text: 'Upload Photo',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              const Divider(),
                                              ListTile(
                                                trailing:
                                                    const Icon(Icons.image),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Image.network(
                                                            profilePicture,
                                                          ),
                                                        );
                                                      });
                                                },
                                                leading: TextRegular(
                                                    text:
                                                        'View Profile Picture',
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: CircleAvatar(
                                  minRadius: 60,
                                  maxRadius: 60,
                                  backgroundImage: NetworkImage(profilePicture),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextBold(text: name, fontSize: 18, color: Colors.grey),
                        TextRegular(
                            text: type, fontSize: 14, color: Colors.grey),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star),
                              const SizedBox(
                                width: 5,
                              ),
                              TextBold(
                                  text: subscription,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.confirmation_num_rounded),
                              const SizedBox(
                                width: 25,
                              ),
                              TextBold(
                                  text: "$points",
                                  fontSize: 14,
                                  color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _visible = !_visible;
            });
          },
          child: TextBold(
            text: _visible ? "Hide Profile" : "Show Profile",
            fontSize: 14,
            color: _visible ? Colors.red : Colors.blue,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Posts')
                .where('email', isEqualTo: box.read('email'))
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('waiting');
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                );
              }

              final data = snapshot.requireData;
              return Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: snapshot.data?.size ?? 0,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    minRadius: 30,
                                    maxRadius: 30,
                                    backgroundImage: NetworkImage(
                                        data.docs[index]['profilePicture']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          TextRegular(
                                              text: data.docs[index]['name'],
                                              fontSize: 18,
                                              color: Colors.grey),
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          TextBold(
                                              text: data.docs[index]['date'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ListTile(
                                                            trailing:
                                                                const Icon(Icons
                                                                    .delete),
                                                            onTap: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Posts')
                                                                  .doc(data
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .delete();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            leading: TextRegular(
                                                                text:
                                                                    'Delete Post',
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const Divider(),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: const Icon(
                                                Icons.more_vert_outlined),
                                          ),
                                        ],
                                      ),
                                      TextBold(
                                          text: data.docs[index]['time'],
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 20, top: 10, bottom: 10),
                              child: ExpandableText(
                                data.docs[index]['caption'],
                                style: const TextStyle(
                                  fontFamily: 'QRegular',
                                ),
                                expandText: 'show more',
                                collapseText: 'show less',
                                maxLines: 5,
                                linkColor: Colors.blue,
                              ),
                            ),
                            data.docs[index]['imageURL'] != ""
                                ? Image.network(data.docs[index]['imageURL'])
                                : const SizedBox(),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
