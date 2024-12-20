import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:route_runner/screens/new_collection/new_collection_controller.dart';
import 'package:route_runner/screens/new_collection/new_collection_screen.dart';

import '../../common/common_text_fild.dart';
import '../../utils/asset_res.dart';
import '../../utils/color_res.dart';
import '../../utils/strings.dart';
import '../../utils/text_style.dart';
import '../location_view/location_controller.dart';
import 'collection_report_controller.dart';

class CollectionReportScreen extends StatelessWidget {
  CollectionReportScreen({super.key});

  LocationController locationController = Get.put(LocationController());
  CollectionReportController controller = Get.put(CollectionReportController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorRes.bgColor,
        // appBar: customAppbar(
        //     title: StringRes.collectionReport,
        //     leadingOnpress: () {
        //       Get.back();
        //     },
        //     action: false,),
        body: Stack(
          children: [
            GetBuilder<CollectionReportController>(
              id: 'collection',
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                      height: 60,
                      color: ColorRes.mainColor,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_sharp,
                                size: 20,
                                color: ColorRes.white,
                              )),
                        ),
                        Text(
                          StringRes.collectionReport,
                          style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w600, color: ColorRes.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                              onTap: () async {
                                controller.loader.value = true;
                                NewCollectionController newCollectionController = Get.put(NewCollectionController());
                                newCollectionController.machineNumberController.clear();
                                newCollectionController.auditNumberController.clear();
                                newCollectionController.locationController.clear();
                                newCollectionController.previousNumberInController.clear();
                                newCollectionController.previousNumberOutController.clear();
                                newCollectionController.currentNumberInController.clear();
                                newCollectionController.currentNumberOutController.clear();
                                newCollectionController.enterSerialNumberController.clear();
                                newCollectionController.totalController.clear();
                                newCollectionController.locationsData = [];
                                 newCollectionController.machineData = [];
                                newCollectionController.locationIndex = null;
                                newCollectionController.pageIndex = 0;
                               newCollectionController.image =[];
                               newCollectionController.selectImage =[];
                               newCollectionController.selectImageTempUrl =[];
                               newCollectionController.selectImageTemp =[];
                               newCollectionController.selectImageUrl =[];
                                await newCollectionController.getLocation();
                                controller.loader.value = false;

                                Get.to(const NewCollectionScreen());
                              },
                              child: Image.asset(
                                AssetRes.addMenu,
                                scale: 3,
                              )),
                        ),

                      ]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            CommonTextField(
                              borderRadius: 12,
                              containerHeight: Get.height * 0.07,
                              isSuffixIcon: true,
                              suffixIcon: AssetRes.search,
                              suffixIconSize: 3,
                              hintText: StringRes.search,
                              controller: controller.searchController,
                              onChanged: (value) {
                                controller.locationsData.clear();
                                controller.currentPage = 1;
                                controller.getLocation(page: controller.currentPage,search: value);
                                controller.searchTerm = 'Moonlight'; // Change this to your desired search term
                                controller.searchResults = controller.searchAllData(controller.allCollectionData, value);
                                print(controller.searchResults);
                                controller.update(['collection']);
                              },
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            controller.locationsData.isNotEmpty?
                             Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        controller.locationsData.clear();
                                        await controller.getLocation(page: 1);
                                        controller.update(['location']);
                                      },
                                      child: ListView.builder(
                                        controller: controller.scrollController,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.locationsData.length,
                                          itemBuilder: (context, index) => Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Container(
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                      color: ColorRes.white, borderRadius: BorderRadius.circular(10)),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(bottom: 51, left: 5, right: 10),
                                                              child: controller.customCheckbox(index),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const SizedBox(height: 20),
                                                                  Text(
                                                                    controller.locationsData[index].locationname?? "",
                                                                    // 'Moonlight Bar',
                                                                    style: title(),
                                                                  ),
                                                                  const SizedBox(height: 2),

                                                                    Text(
                                                                          "Employee: ${controller.firstName[index] ?? ""} ${controller.lastName[index] ?? ""}",
                                                                          // 'Admin: Arrora gaur',
                                                                          style: subTitle(),
                                                                        ),



                                                                  const SizedBox(height: 2),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        'Machine: ${controller.locationsData[index].machines?.length ?? 0}',
                                                                        style: subTitle(),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: 3,
                                                                      ),
                                                                      // Text(
                                                                      //   'Beginning: ${controller.allCollectionData[index].machine}',
                                                                      //   style: subTitle(),
                                                                      // ),
                                                                      // const SizedBox(
                                                                      //   width: 3,
                                                                      // ),
                                                                      // Text(
                                                                      //   'Closed: ${controller.allCollectionData[index].machine}',
                                                                      //   style: subTitle(),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 2),
                                                                  Text(
                                                                    "Address: ${controller.locationsData[index].address ?? ""}",
                                                                    // 'Admin: Arrora gaur',
                                                                    style: subTitle(),
                                                                  ),
                                                                  const SizedBox(height: 10),
                                                                ],
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                // SizedBox(height: Get.height * 0.02),
                                                                Row(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Image.asset(
                                                                          AssetRes.calendar,
                                                                          scale: 2.5,
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 4,
                                                                        ),
                                                                        Text(
                                                                          DateFormat('dd MMM, yyyy').format(controller.locationsData[index].createdAt ?? DateTime.now()),
                                                                          style: TextStyle(
                                                                            fontSize: width * 0.03,
                                                                            fontWeight: FontWeight.w400,
                                                                            color: ColorRes.grey2,
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    Visibility(
                                                                      visible:false,
                                                                      child: GestureDetector(
                                                                          onTap: () {},
                                                                          child: Image.asset(
                                                                            AssetRes.print,
                                                                            scale: 3,
                                                                          )),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: Get.height * 0.05),

                                                                GestureDetector(
                                                                  onTap: () {
                                                                    if (controller.isViewData[index] == false) {
                                                                      controller.isViewData[index] = true;
                                                                    } else {
                                                                      controller.isViewData[index] = false;
                                                                    }
                                                                    controller.update(['collection']);
                                                                  },
                                                                  child: controller.isViewData[index]
                                                                      ? const Icon(
                                                                          Icons.keyboard_arrow_down_sharp,
                                                                          color: ColorRes.grey,
                                                                          size: 22,
                                                                        )
                                                                      : const Icon(
                                                                          Icons.keyboard_arrow_right,
                                                                          color: ColorRes.grey,
                                                                          size: 22,
                                                                        ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                   controller.isViewData[index]
                                                          ? SizedBox(
                                                              child: ListView.separated(
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                shrinkWrap: true,
                                                                itemCount: controller.locationsData[index].machines?.length ??
                                                                    0,
                                                                itemBuilder: (context, i) {
                                                                  return Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                      child: Column(
                                                                        children: [
                                                                          Container(
                                                                            height: 35,
                                                                            width: Get.width * 0.9,
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                    width: 1, color: ColorRes.colorF2F2F2),
                                                                                borderRadius: const BorderRadius.only(
                                                                                  topLeft: Radius.circular(10),
                                                                                  topRight: Radius.circular(10),
                                                                                ),
                                                                                color: ColorRes.colorF2F2F2),
                                                                            child: Padding(
                                                                              padding:
                                                                                  const EdgeInsets.symmetric(horizontal: 10),
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 3,
                                                                                    child: Text(
                                                                                      'Machine- #${controller.locationsData[index].machines?[i].machineNumber}-${controller.locationsData[index].machines?[i].serialNumber}',
                                                                                      style: GoogleFonts.nunito(
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: ColorRes.color030229),
                                                                                    ),
                                                                                  ),
                                                                                  // SizedBox(
                                                                                  //   width: Get.width * 0.03,
                                                                                  // ),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Current',
                                                                                      style: GoogleFonts.nunito(
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: ColorRes.color030229),
                                                                                    ),
                                                                                  ),

                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      'Previous',
                                                                                      style: GoogleFonts.nunito(
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: ColorRes.color030229),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: Get.width * 0.01,
                                                                                  ),
                                                                                  Text(
                                                                                    'Total',
                                                                                    style: GoogleFonts.nunito(
                                                                                        fontSize: 12,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        color: ColorRes.color030229),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height: Get.height * 0.12,
                                                                            width: Get.width * 0.9,
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                    width: 1, color: ColorRes.colorF2F2F2),
                                                                                borderRadius: const BorderRadius.only(
                                                                                  bottomLeft: Radius.circular(10),
                                                                                  bottomRight: Radius.circular(10),
                                                                                ),
                                                                                color: ColorRes.white),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.symmetric(
                                                                                  horizontal: 10, vertical: 5),
                                                                              child: Row(
                                                                                children: [
                                                                                  // Container(
                                                                                  //   width: 80,
                                                                                  //   decoration: BoxDecoration(
                                                                                  //       image:
                                                                                  //       controller.locationsData[index].collectionReports?[i].image ==""?const DecorationImage(
                                                                                  //           fit: BoxFit.fill,
                                                                                  //           image:
                                                                                  //               AssetImage(AssetRes.photo)):DecorationImage(
                                                                                  //           fit: BoxFit.fill,
                                                                                  //           image:
                                                                                  //           NetworkImage(controller.locationsData[index].collectionReports?[i].image ?? "")),
                                                                                  //       borderRadius:
                                                                                  //           BorderRadius.circular(3)),
                                                                                  // ),
                                                                                  ( controller.locationsData[index].machines?[i].image != null &&controller.locationsData[index].machines?[i].image!.length !=0)?CachedNetworkImage(
                                                                                    width: 80,
                                                                                    fit: BoxFit.fill,
                                                                                    imageUrl: controller.locationsData[index].machines?[i].image?[0] ?? "",
                                                                                    placeholder: (context, url) => Image.asset(AssetRes.photo, fit: BoxFit.fill),
                                                                                    errorWidget: (context, url, error) => Image.asset(AssetRes.photo, fit: BoxFit.fill),
                                                                                  ):const SizedBox(),

                                                                                  const SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Column(
                                                                                        mainAxisAlignment:
                                                                                            MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                flex: 7,
                                                                                                child: Text(
                                                                                                  'In',
                                                                                                  style: GoogleFonts.nunito(
                                                                                                      fontSize: width * 0.036,
                                                                                                      fontWeight:
                                                                                                          FontWeight.w500,
                                                                                                      color: ColorRes
                                                                                                          .color030229),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                "\$ ${controller.locationsData[index].machines?[i].inNumbers?.current}",
                                                                                                style: GoogleFonts.nunito(
                                                                                                    fontSize: width * 0.034,
                                                                                                    fontWeight:
                                                                                                        FontWeight.w500,
                                                                                                    color:
                                                                                                        ColorRes.color030229),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: Get.width * 0.07,
                                                                                              ),
                                                                                              Text(
                                                                                                "\$ ${controller.locationsData[index].machines?[i].inNumbers?.previous}",
                                                                                                style: GoogleFonts.nunito(
                                                                                                    fontSize: width * 0.034,
                                                                                                    fontWeight:
                                                                                                        FontWeight.w500,
                                                                                                    color:
                                                                                                        ColorRes.color030229),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: Get.width * 0.05,
                                                                                              ),
                                                                                              Text(
                                                                                                "\$ ${controller.calculateSubtractedValue(controller.locationsData[index].machines?[i].inNumbers?.current,controller.locationsData[index].machines?[i].inNumbers?.previous)}",
                                                                                                style: GoogleFonts.nunito(
                                                                                                    fontSize: width * 0.034,
                                                                                                    fontWeight:
                                                                                                        FontWeight.w500,
                                                                                                    color:
                                                                                                        ColorRes.color030229),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                flex: 7,
                                                                                                child: Text(
                                                                                                  'Out',
                                                                                                  style: GoogleFonts.nunito(
                                                                                                      fontSize: width * 0.036,
                                                                                                      fontWeight:
                                                                                                          FontWeight.w500,
                                                                                                      color: ColorRes
                                                                                                          .color030229),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                "\$ ${controller.locationsData[index].machines?[i].outNumbers?.current ??0}",
                                                                                                style: GoogleFonts.nunito(
                                                                                                    fontSize: width * 0.034,
                                                                                                    fontWeight:
                                                                                                        FontWeight.w500,
                                                                                                    color:
                                                                                                        ColorRes.color030229),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: Get.width * 0.07,
                                                                                              ),
                                                                                              Text(
                                                                                                "\$ ${controller.locationsData[index].machines?[i].outNumbers?.previous ??0}",
                                                                                                style: GoogleFonts.nunito(
                                                                                                    fontSize: width * 0.034,
                                                                                                    fontWeight:
                                                                                                        FontWeight.w500,
                                                                                                    color:
                                                                                                        ColorRes.color030229),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: Get.width * 0.07,
                                                                                              ),
                                                                                              Text(
                                                                                                // "\$ ${ controller.allCollectionData[index].machineDetails?[i].previous?[0].out}",
                                                                                                "\$ ${controller.calculateSubtractedValue(controller.locationsData[index].machines?[i].outNumbers?.current,controller.locationsData[index].machines?[i].outNumbers?.previous)}",
                                                                                                style: GoogleFonts.nunito(
                                                                                                    fontSize: width * 0.034,
                                                                                                    fontWeight:
                                                                                                        FontWeight.w500,
                                                                                                    color:
                                                                                                        ColorRes.color030229),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          Row(
                                                                                            children: [
                                                                                              Expanded(
                                                                                                flex: 7,
                                                                                                child: Text(
                                                                                                  'Total',
                                                                                                  style: GoogleFonts.nunito(
                                                                                                      fontSize: 12,
                                                                                                      fontWeight:
                                                                                                          FontWeight.w500,
                                                                                                      color: ColorRes
                                                                                                          .color030229),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                '\$ ${controller.locationsData[index].machines?[i].total?.toString() ?? ""}',
                                                                                                style: GoogleFonts.nunito(
                                                                                                  fontSize: width * 0.034,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  color: double.parse(controller.locationsData[index].machines?[i].total?.toString() ?? "0") >= 0
                                                                                                      ? ColorRes.color3A974C
                                                                                                      : Colors.red,
                                                                                                ),
                                                                                              ),


                                                                                              SizedBox(
                                                                                                width: Get.width * 0.004,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ]),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ));
                                                                },
                                                                separatorBuilder: (BuildContext context, int index) {
                                                                  return const SizedBox(
                                                                    height: 10,
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      controller.isViewData[index]
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'Total profit- 600',
                                                                    style: GoogleFonts.nunito(
                                                                        fontSize: width * 0.034,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: ColorRes.black),
                                                                  ),
                                                                  Text(
                                                                    '50%- 300',
                                                                    style: GoogleFonts.nunito(
                                                                        fontSize: width * 0.034,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: ColorRes.black),
                                                                  ),
                                                                  Text(
                                                                    'Paid- 300',
                                                                    style: GoogleFonts.nunito(
                                                                        fontSize: width * 0.034,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: ColorRes.black),
                                                                  ),
                                                                  Text(
                                                                    'Due- 0',
                                                                    style: GoogleFonts.nunito(
                                                                        fontSize: width * 0.034,
                                                                        fontWeight: FontWeight.w600,
                                                                        color: ColorRes.black),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    ),
                                  )   :  controller.loader.value == false? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                StringRes.notFound,
                                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ):const SizedBox(),

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Obx(()=> controller.loader.value ? const Center(child: CircularProgressIndicator(),):const SizedBox())
          ],
        ),
      ),
    );
  }
}
