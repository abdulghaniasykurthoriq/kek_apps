import 'package:flutter/material.dart';
import 'package:kek_app/theme.dart';

AppBar specialAppbar2(String label1, String label2, String label3) {
  return AppBar(
    toolbarHeight: 150,
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    title: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label1,
                style: redTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                label2,
                style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            label3,
            style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
