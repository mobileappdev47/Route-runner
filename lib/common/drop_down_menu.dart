import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_runner/screens/dash_board/dash_board_controller.dart';
import 'package:route_runner/screens/dash_board/dash_board_screen.dart';

import '../utils/asset_res.dart';
import '../utils/color_res.dart';
import '../utils/strings.dart';
import '../utils/text_style.dart';

Widget DropDownMenu({required bool isLocation}) {
  return PopupMenuButton(
    // clipBehavior: Clip.none,

    // enableFeedback: true,
    enabled: true,
    color: ColorRes.white,
    // splashRadius: 20,
    offset: const Offset(0, 10),
    padding: EdgeInsets.zero,

    constraints: const BoxConstraints(
      maxWidth: 110,
    ),
    position: PopupMenuPosition.under,
    child: Text(
      StringRes.viewMore,
      style: GoogleFonts.nunito(
          decoration: TextDecoration.underline, fontSize: 12, fontWeight: FontWeight.w500, color: ColorRes.grey2),
    ),

    itemBuilder: (context) {
      return [
    /*    PopupMenuItem(
          height: Get.height * 0.04,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Container(
            height: Get.height * 0.04,
            width: Get.width * 0.6,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
              //  color: ColorRes.lightOrange
            ),
            child: InkWell(
              onTap: () async {

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    AssetRes.pin,
                    scale: 2.5,
                  ),
                  Text(
                    StringRes.changeStatus,
                    style: commonSubtitle().copyWith(color: ColorRes.orange, fontSize: 11),
                  )
                ],
              ),
            ),
          ),
        ),*/
        PopupMenuItem(
          height: Get.height * 0.04,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          child: Container(
            height: Get.height * 0.04,
            width: Get.width * 0.6,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
              //  color: ColorRes.lightYellow
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Image.asset(
                  AssetRes.pay,
                  scale: 2.5,
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Text(
                  StringRes.pay,
                  style: commonSubtitle().copyWith(color: ColorRes.yellow, fontSize: 11),
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
            height: Get.height * 0.04,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: (){
                  DashBoardController dashBoardController = Get.put(DashBoardController());
                if(isLocation){
                  Get.offAll(DashBoardScreen());
                  dashBoardController.nextPage(2);
                }
                else
                  {
                    Get.offAll(DashBoardScreen());
                    dashBoardController.nextPage(1);
                  }
              },
              child: Container(
                height: Get.height * 0.04,
                width: Get.width * 0.5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
                  //  color: Colors.grey.shade100
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AssetRes.list,
                      scale: 2.5,
                    ),
                    Text(
                      (isLocation)? StringRes.listOfMachine:StringRes.listOfLocations,
                      style: commonSubtitle().copyWith(color: ColorRes.grey2, fontSize: 11),
                    )
                  ],
                ),
              ),
            ))
      ];
    },
  );
}
//
// Widget popupMenuItem ({required }){
//   return PopupMenuItem(
//       height: Get.height * 0.04,
//       padding: EdgeInsets.symmetric(horizontal: 5),
//       child: Expanded(
//         child: Container(
//           height: Get.height * 0.04,
//           width: Get.width * 0.5,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.grey.shade300),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Image.asset(
//                 AssetRes.list,
//                 scale: 3,
//               ),
//               Text(
//                 StringRes.listOfMachine,
//                 style: commonSubtitle().copyWith(color: ColorRes.grey2, fontSize: 8),
//               )
//             ],
//           ),
//         ),
//       ));
// }
