import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monetization_system/data/services/cloud_functions/pay_points.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPagePremium extends StatefulWidget {
  const PaymentPagePremium({Key? key}) : super(key: key);

  @override
  State<PaymentPagePremium> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPagePremium> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: TextRegular(
            text: 'Premium Account', fontSize: 18, color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextBold(
                  text: 'Premium Account Benefits',
                  fontSize: 24,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                title: TextRegular(
                    text: 'Ulimited Points', fontSize: 18, color: Colors.black),
                subtitle: TextRegular(
                    text:
                        'You will acquire infinity points. You can post as many as you want',
                    fontSize: 12,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                  text: 'Fee and Payment Method',
                  fontSize: 24,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: const Icon(
                  Icons.payment_rounded,
                  color: Colors.green,
                ),
                title: TextRegular(
                    text: '999.00php', fontSize: 18, color: Colors.black),
                subtitle: TextRegular(
                    text: 'One time Subscription Fee',
                    fontSize: 12,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: const Icon(
                  Icons.g_mobiledata_rounded,
                  color: Colors.green,
                ),
                title: TextRegular(
                    text: 'GCash Payment', fontSize: 18, color: Colors.black),
                subtitle: TextRegular(
                    text: 'Mode of Payment', fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                  text: 'Where to send payment?',
                  fontSize: 24,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: '+639058876944'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('GCash number copied succesfully'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.black,
                  ),
                ),
                title: TextRegular(
                    text: '+639058876944', fontSize: 18, color: Colors.black),
                subtitle: TextRegular(
                    text: 'Our GCash Number', fontSize: 12, color: Colors.grey),
              ),
              TextBold(text: 'Note:', fontSize: 24, color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: const Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                title: TextRegular(
                    text: 'Dont Forget the Amount of Fee and the GCash Number',
                    fontSize: 15,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () async {
                    payPremium(name, profilePicture, box.read('email'),
                        subscription, points);
                    String gcash =
                        'play.google.com/store/apps/details?id=com.globe.gcash.android';
                    final _text = 'https://' + gcash;
                    if (await canLaunch(_text)) {
                      await launch(_text);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextRegular(
                        text: 'Pay via GCash',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
