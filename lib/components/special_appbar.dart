import 'package:flutter/material.dart';
import 'package:kek_app/theme.dart';

AppBar specialAppbar(String label1, String label2, String label3,
    Function onPressed, String label4) {
  Widget optional() {
    if (label4 != '') {
      return Text(
        label4,
        style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
      );
    }
    return const SizedBox();
  }

  return AppBar(
    toolbarHeight: 150,
    elevation: 0,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    title: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () => onPressed(),
          ),
        ),
        Center(
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
              optional(),
              Text(
                label3,
                style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
