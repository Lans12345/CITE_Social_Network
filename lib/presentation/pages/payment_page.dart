import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: TextRegular(
            text: 'Purchase Points', fontSize: 18, color: Colors.black),
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
                  text: 'Benefits of Purchasing Points',
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
                    text: '+100 Points', fontSize: 18, color: Colors.black),
                subtitle: TextRegular(
                    text: 'You will earn extra points. You can post more often',
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
                    text: '99/month', fontSize: 18, color: Colors.black),
                subtitle: TextRegular(
                    text: 'Subscription Fee', fontSize: 12, color: Colors.grey),
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
              const SizedBox(
                height: 50,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () async {
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
