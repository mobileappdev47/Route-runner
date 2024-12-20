import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_res.dart';

class AppbarContainer extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final String image;
  final String number;
  final String text;
  const AppbarContainer(
      {super.key,
      required this.iconColor,
      required this.bgColor,
      required this.image,
      required this.number,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 22),
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * 0.17),
        child: Container(
          height: Get.height * 0.1,
          width: Get.width * 0.44,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: ColorRes.white),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: Get.width * 0.03,
              ),
              CircleAvatar(
                backgroundColor: bgColor,
                radius: 22,
                child: Image.asset(
                  image,
                  color: iconColor,
                  scale: 3,
                ),
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Text(
                      number,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.004,
                  ),
                  Text(text, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
