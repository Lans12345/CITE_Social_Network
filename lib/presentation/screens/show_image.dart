import 'package:flutter/material.dart';

class ShowImagePage extends StatelessWidget {
  late String photo = '';

  ShowImagePage({
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(photo);
  }
}
