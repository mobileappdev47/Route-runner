
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:route_runner/screens/Pdf_preview_screen/pdf_preview_screen.dart';
import 'package:route_runner/screens/new_collection/new_collection_controller.dart';
import '../../utils/asset_res.dart';
import '../../utils/color_res.dart';
import '../../utils/strings.dart';
import '../../utils/text_style.dart';
import 'collection_detail_controller.dart';

class CollectionDetailScreen extends StatelessWidget {

  CollectionDetailScreen({super.key,});
  CollectionDetailController controller = Get.put(CollectionDetailController());
  NewCollectionController newCollectionController = Get.put(NewCollectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

         SingleChildScrollView(
           child: Column(
             children: [
               Container(
                 height: Get.height * 0.13,
                 width: Get.width,
                 color: ColorRes.mainColor,
                 padding: const EdgeInsets.only(top: 30),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     IconButton(
                         onPressed: () {
                           Get.back();
                         },
                         icon: const Icon(
                           Icons.arrow_back_ios_new_rounded,
                           color: ColorRes.white,
                           size: 20,
                         )),
                     const SizedBox(width: 20),
                     Text(
                       StringRes.collectionDetail,
                       style: appbarStyle().copyWith(fontSize: 20),
                     ),
                     const SizedBox(width: 20),
                     GestureDetector(
                         onTap: () async {
                           List images =[];
                           //
                           // List flist =newCollectionController.addCampaignData;
                           //
                           //
                           // List images=List.generate(flist.length, (index) => {"$index":[]});
                           //
                           //
                           // for(int r=0;r<flist.length;r++) {
                           //   List iv =[];
                           //   for (int i = 0; i < newCollectionController.addCampaignData[r].image!.length; i++) {
                           //     var t = await File(newCollectionController.addCampaignData[r].image![i].path)
                           //         .readAsBytes();
                           //     iv.add(t);
                           //   }
                           //
                           //
                           //     iv.forEach((element) {
                           //
                           //   images[r]['$r'].add(element);
                           //     });
                           //   iv.clear();
                           //   iv =[];
                           //
                           //
                           // }

                             Get.to(()=>PdfPreviewScreen(data:newCollectionController.addCampaignData,images:images));

                         },
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
               ListView.builder(
                 shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: newCollectionController.addCampaignData.length,
                   itemBuilder: (context,i){
                 return  Column(
                   children: [

                     Padding(
                       padding: const EdgeInsets.all(20),
                       child: Column(
                         children: [
                           SizedBox(
                             height: 200,width: Get.width,
                             child: ListView.builder(
                               controller: controller.pageController,
                               scrollDirection: Axis.horizontal,
                               itemCount: newCollectionController.addCampaignData[i].image?.length ?? 0,
                               itemBuilder: (context, index) =>
                                   Row(
                                     children: [
                                       Container(
                                         height: 200,width: 250,
                                         decoration:  BoxDecoration(
                                           image: DecorationImage(
                                             image: FileImage(
                                                 newCollectionController.addCampaignData[i].image?[index] ??''
                                             ),
                                             fit: BoxFit.cover, // Choose the BoxFit that suits your needs
                                           ),
                                         ),
                                         /*child:

                                                                       newCollectionController.addCampaignData[0].image != ""?
                                        //Image.file(File(newCollectionController.selectImage[index].toString()),height: 180)
                                       Image.file(File(newCollectionController.addCampaignData[0].image ?? ""),height: 180)
                                        :Image.asset(
                                                                         AssetRes.photo,
                                                                       ),*/
                                       ),
                                       const SizedBox(width: 20,),
                                     ],
                                   ),
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           Container(
                             // height: Get.height * 0.25,
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
                                       'Date: ${DateFormat('dd MMM, yyyy').format(DateTime.now())}',
                                       style: subTitle().copyWith(fontSize: 10),
                                     ),
                                     SizedBox(
                                       width: Get.width * 0.02,
                                     ),
                                     Text(
                                       'Time: ${DateFormat('h:mm a').format(DateTime.now())}',
                                       style: subTitle().copyWith(fontSize: 10),
                                     )
                                   ],
                                 ),
                                 const SizedBox(height: 20),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     // SizedBox(
                                     //   width:Get.width*0.15,
                                     //   child: Text(
                                     //     '#${newCollectionController.addCampaignData[i].machineNumber}-${newCollectionController.addCampaignData[i].serialNumber}',
                                     //     overflow: TextOverflow.ellipsis,
                                     //     style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                                     //   ),
                                     // ),
                                     // SizedBox(
                                     //   width: Get.width * 0.1,
                                     // ),
                                     Text(
                                       StringRes.current,
                                       style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                                     ),
                                     // SizedBox(
                                     //   width: Get.width * 0.1,
                                     // ),
                                     Text(
                                       StringRes.previous,
                                       style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                                     ),
                                     // SizedBox(
                                     //   width: Get.width * 0.02,
                                     // ),
                                     Text(
                                       StringRes.total,
                                       style: subTitle().copyWith(fontSize: 14, color: ColorRes.grey2),
                                     ),

                                   ],
                                 ),
                                 const SizedBox(height: 10,),
                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                   Text(
                                     "In",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     "\$${newCollectionController.addCampaignData[i].inCurrent}",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     "\$${newCollectionController.addCampaignData[i].inPrevious}",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     "\$${controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].inCurrent ?? "0"),
                                         int.parse(newCollectionController.addCampaignData[i].inPrevious == "" ? "0" :newCollectionController.addCampaignData[i].inPrevious ?? '0'))}",
                                     // "\$${controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].inCurrent ??"0"),
                                     //     int.parse(newCollectionController.addCampaignData[i].inPrevious ?? '0'))}",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                 ],),
                                 const SizedBox(height: 10,),
                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                   Text(
                                     "Out",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     "\$${newCollectionController.addCampaignData[i].outCurrent}",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     "\$${newCollectionController.addCampaignData[i].outPrevious}",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                   Text(
                                     "\$${controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].outCurrent == ""? "0" :newCollectionController.addCampaignData[i].outCurrent ?? '0'),
                                         int.parse(newCollectionController.addCampaignData[i].outPrevious == ""? "0" :newCollectionController.addCampaignData[i].outPrevious ??'0'))}",
                                     style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                   ),
                                 ],),
                                 const SizedBox(height: 10,),
                                 Padding(
                                   padding: const EdgeInsets.only(right: 0),
                                   child: SizedBox(
                                     // width: Get.width * 0.1,
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       children: [
                                        Text('Profit: ', style: title().copyWith(fontSize: 15, fontWeight: FontWeight.w500)),
                                         Text(
                                           "\$ ${controller.calculateTotalValue(
                                               controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].inCurrent == ""? "0" :newCollectionController.addCampaignData[i].inCurrent ??'0'),
                                                   int.parse(newCollectionController.addCampaignData[i].inPrevious == "" ? "0" :newCollectionController.addCampaignData[i].inPrevious ??'0')),
                                               controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].outCurrent == ""? "0" :newCollectionController.addCampaignData[i].outCurrent ??'0'),
                                                   int.parse(newCollectionController.addCampaignData[i].outPrevious == "" ? "0" :newCollectionController.addCampaignData[i].outPrevious ??'0'))
                                           )}",
                                           style: TextStyle(color:  (controller.calculateTotalValue(
                                               controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].inCurrent == "" ? "0" :newCollectionController.addCampaignData[i].inCurrent ??'0'),
                                                   int.parse(newCollectionController.addCampaignData[i].inPrevious == "" ? "0" :newCollectionController.addCampaignData[i].inPrevious ??'0')),
                                               controller.calculateSubtractedValue(int.parse(newCollectionController.addCampaignData[i].outCurrent == "" ? "0" :newCollectionController.addCampaignData[i].outCurrent ??'0'),
                                                   int.parse(newCollectionController.addCampaignData[i].outPrevious == "" ? "0" :newCollectionController.addCampaignData[i].outPrevious ??'0'))
                                           ) < 0)
                                               ? ColorRes.red
                                               : ColorRes.green,),
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
                 );
               }),
             ],
           ),
         ),
          Obx(()=> controller.loader.value ? const Center(child: CircularProgressIndicator(),):const SizedBox())
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () async {
          /*  {
              "employeeId": "65a60526904b5f4feec37b46",
            "locationId": "65b0dafe64e1e708fa66f3d0",
            "machines": [
          {
            "machineId": "65b49f1b80a9b17735abfb3d",
            "machineNumber": "Machine1Number",
            "serialNumber": "UpdatedMachine3SerialNumber",
            "auditNumber": "UpdatedMachine1AuditNumber",
            "inNumbers": {
            "previous": 250,
            "current": 300
          },
            "outNumbers": {
            "previous": 85,
            "current": 200
          },
            "total": "UpdatedMachine1Total",
            "image": "URL_To_UpdatedImage1",
            "gameName": "UpdatedMachine1GameName"
          }

            ]
          }*/
            List<Map<String,dynamic>> machines =[];
            for (var element in newCollectionController.addCampaignData) {
              machines.add(
                {
                  "machineId": element.machineId,
                  "machineNumber": element.machineNumber,
                  "serialNumber": element.serialNumber,
                  "auditNumber": element.gameName,
                  "inNumbers": {
                    "previous": element.inPrevious,
                    "current": element.inCurrent
                  },
                  "outNumbers": {
                    "previous": element.outPrevious,
                    "current": element.outCurrent
                  },
                  "total": element.total,
                  "image":element.imageUrl,
                  "gameName": element.gameName,
                }
              );
            }



            controller.addNewRepair(
              context,
                location: newCollectionController.locationId,
              machines:machines
          ).then((value) {
                  if(value == false)
                    {
                      // CollectionReportController controller = Get.put(CollectionReportController());
                      // controller.currentPage = 0;
                      // controller.getCollectionReport(page: controller.currentPage);



                    }
            });


            // Get.offAll(CollectionReportScreen());
          },
          child: Container(
              height: Get.height * 0.07,
              width: Get.width * 0.9,
              decoration: BoxDecoration(color: ColorRes.mainColor, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                StringRes.save,
                style: TextStyle(fontSize: 16, color: ColorRes.white),
              ))),
        ),
      ),
    );
  }
}
