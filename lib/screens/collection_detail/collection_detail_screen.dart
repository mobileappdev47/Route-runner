import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:route_runner/screens/collection_report/collection_report.dart';
import 'package:route_runner/screens/new_collection/new_collection_controller.dart';

import '../../utils/asset_res.dart';
import '../../utils/color_res.dart';
import '../../utils/strings.dart';
import '../../utils/text_style.dart';
import 'collection_detail_controller.dart';

class CollectionDetailScreen extends StatelessWidget {
  CollectionDetailScreen({super.key});
  CollectionDetailController controller = Get.put(CollectionDetailController());
  NewCollectionController newCollectionController = Get.put(NewCollectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height * 0.13,
            width: Get.width,
            color: ColorRes.mainColor,
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorRes.white,
                      size: 20,
                    )),
                SizedBox(width: 20),
                Text(
                  StringRes.collectionDetail,
                  style: appbarStyle().copyWith(fontSize: 20),
                ),
                SizedBox(width: 20),
                GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      AssetRes.print,
                      scale: 3,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  AssetRes.photo,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              StringRes.machine,
                              style: title().copyWith(fontSize: 15),
                            ),
                          ),
                          // SizedBox(
                          //   width: Get.width * 0.35,
                          // ),
                          Text(
                            'Date: 15 Dec, 2023',
                            style: subTitle().copyWith(fontSize: 10),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Text(
                            'Time: 11:45 PM',
                            style: subTitle().copyWith(fontSize: 10),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '#1-876364',
                            style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                          ),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          Text(
                            StringRes.current,
                            style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                          ),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          Text(
                            StringRes.previous,
                            style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                          ),
                          SizedBox(
                            width: Get.width * 0.1,
                          ),
                          Text(
                            StringRes.total,
                            style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: 2,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(
                                    width: Get.width * 0.3,
                                    child: Text(
                                      controller.data[index],
                                      style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                    )),
                                SizedBox(
                                    width: Get.width * 0.22,
                                    child: Text(
                                      "\$${newCollectionController.currentNumberInController.text}",
                                      style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                    )),
                                SizedBox(
                                    width: Get.width * 0.25,
                                    child: Text(
                                      "\$${newCollectionController.previousNumberOutController.text}",
                                      style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                    )),
                                Text(
                                  "\$${newCollectionController.previousNumberOutController.text} ",
                                  style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          // width: Get.width * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Profit: ', style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
                              Text(
                                "\$${newCollectionController.previousNumberOutController.text}",
                                style: TextStyle(color: ColorRes.green),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            Get.to(() => CollectionReportScreen());
          },
          child: Container(
              height: Get.height * 0.07,
              width: Get.width * 0.9,
              decoration: BoxDecoration(color: ColorRes.mainColor, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                StringRes.save,
                style: TextStyle(fontSize: 16, color: ColorRes.white),
              ))),
        ),
      ),
    );
  }
}
