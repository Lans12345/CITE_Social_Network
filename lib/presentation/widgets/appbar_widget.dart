import 'package:flutter/material.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    backgroundColor: Colors.blue,
    title: TextRegular(text: title, fontSize: 18, color: Colors.white),
    centerTitle: true,
  );
}
