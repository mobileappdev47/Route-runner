import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:route_runner/screens/admin_view/admin_screen.dart';
import 'package:route_runner/screens/collection_report/collection_report.dart';
import 'package:route_runner/screens/dash_board/dash_board_controller.dart';
import 'package:route_runner/screens/home_view/home_controller.dart';
import 'package:route_runner/screens/home_view/widget/appbar_container.dart';
import 'package:route_runner/screens/new_collection/new_collection_controller.dart';
import 'package:route_runner/screens/new_collection/new_collection_screen.dart';
import 'package:route_runner/screens/repair/repair_screen.dart';
import 'package:route_runner/screens/service_report_view/service_report_screen.dart';
import 'package:route_runner/utils/pref_keys.dart';
import '../../service/pref_services.dart';
import '../../utils/asset_res.dart';
import '../../utils/color_res.dart';
import '../../utils/strings.dart';
import '../../utils/text_style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        DashBoardController dashBoardController = Get.put(DashBoardController());

        if(  dashBoardController.currentIndex ==0) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Theme(
                  data: ThemeData(dialogBackgroundColor: ColorRes.white),
                  child: AlertDialog(
                    title: const Text(
                      'Are you sure you want to exit?',
                      style: TextStyle(fontSize: 22, color: ColorRes.mainColor),
                    ),

                    actions: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(ColorRes.mainColor),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          exit(0);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(ColorRes.mainColor),
                        ),
                        child: const Text('Yes', style: TextStyle(color: Colors
                            .white),),
                      ),
                      const SizedBox(width: 2),
                    ],
                  ),
                );
              });
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorRes.bgColor,
        key: homeController.scaffoldKey,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: GetBuilder<HomeController>(
                  id: 'home',
                  builder: (context2) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: Get.height * 0.27,
                              width: Get.width,
                              decoration:
                                  const BoxDecoration(color: ColorRes.mainColor),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Image.asset(
                                    AssetRes.splashLogo,
                                    scale: 11,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  Text(
                                    StringRes.routeRunner,
                                    style: appbarStyle(),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.29,
                                  ),
                                  Image.asset(
                                    AssetRes.locator,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.05,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      homeController.scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                    child: Image.asset(
                                      AssetRes.drawer,
                                      scale: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                             Row(
                              children: [
                                AppbarContainer(
                                  bgColor: ColorRes.lightBlue,
                                  iconColor: ColorRes.mainColor,
                                  image: AssetRes.location,
                                  number: homeController.locationLength,
                                  text: StringRes.locations,
                                ),
                                AppbarContainer(
                                  bgColor: ColorRes.lightYellow,
                                  iconColor: ColorRes.yellow,
                                  image: AssetRes.machine,
                                  number: homeController.machineLength,
                                  text: StringRes.machines,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          height: Get.height * 0.17,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorRes.white),
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 180),
                                child: Text(StringRes.newCollection,
                                    style: commonTitle()
                                        .copyWith(fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(height: 17),
                              SizedBox(
                                width: Get.width*0.8,
                                child: CupertinoButton(
                                  color: ColorRes.mainColor,
                                  borderRadius: BorderRadius.circular(15),
                                    child: Text(StringRes.addNewCollection
                                      ,  style: commonTitle().copyWith(fontSize: 15, color: ColorRes.white, fontWeight: FontWeight.w500),

                                    ),
                                    onPressed: () async {
                                    homeController.loader.value =true;
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
                                    homeController.loader.value =false;



                                   bool refresh = await Navigator.push( context, MaterialPageRoute(builder: (context) => const NewCollectionScreen(),));

                                    if(refresh == true){
                                      context2.init();
                                      context2.update(['home']);
                                      homeController.update(['home']);
                                    }
                                    }),
                              )
                              /* Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      width: Get.width * 0.6,
                                      child: CommonTextField(
                                        type: TextInputType.number,
                                        borderRadius: 7,
                                        contentPadding: 10,
                                        containerHeight: Get.height * 0.06,
                                        color: ColorRes.tffGrey,
                                        controller: homeController.auditController,
                                        hintText: StringRes.auditNumber,
                                      )),
                                  */ /*Container(
                                      height: Get.height * 0.055,
                                      width: Get.width * 0.125,
                                      decoration:
                                          BoxDecoration(color: ColorRes.mainColor, borderRadius: BorderRadius.circular(7)),
                                      child: Center(
                                        child: Text(
                                          StringRes.go,
                                          style: commonTitle().copyWith(fontSize: 14, color: ColorRes.white),
                                        ),
                                      ))*/ /*
                                  Column(
                                    children: [
                                      Container(
                                        height: 7,
                                      ),
                                      Container(
                                          height: Get.height * 0.059,
                                          width: Get.width * 0.12,
                                          decoration: BoxDecoration(
                                              color: ColorRes.mainColor, borderRadius: BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              StringRes.go,
                                              style: commonTitle().copyWith(fontSize: 15, color: ColorRes.white),
                                            ),
                                          ))
                                    ],
                                  )
                                ],
                              )*/
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            right: 10,
                          ),
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorRes.white),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Text(
                                        StringRes.recentCollection,
                                        style: commonTitle().copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: width * 0.042),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.34,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 15, right: 10),
                                    child: Image.asset(
                                      AssetRes.menu,
                                      scale: 3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    StringRes.serialNo,
                                    style: commonSubtitle()
                                        .copyWith(fontSize: width * 0.04),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    AssetRes.arrowDown,
                                    color: ColorRes.grey4,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.1,
                                  ),
                                  Text(
                                    StringRes.location,
                                    style: commonSubtitle()
                                        .copyWith(fontSize: width * 0.04),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.04,
                                  ),
                                  Image.asset(
                                    AssetRes.arrowDown,
                                    color: ColorRes.grey4,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.13,
                                  ),
                                  Text(
                                    StringRes.total,
                                    style: commonSubtitle()
                                        .copyWith(fontSize: width * 0.04),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              homeController.dividers(5, 5),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    homeController.recentCollectionList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width:Get.width *0.3,
                                            child: Text(
                                              "#${homeController.recentCollectionList[index].machineNumber}-${homeController.recentCollectionList[index].serialNumber}",
                                              // 'Moonlight Bar',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunito(
                                                  fontSize: width * 0.034,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorRes.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.09,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.25,
                                            child: Text(
                                              homeController.locationName,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorRes.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.1,
                                            child: Text(
                                              "${homeController.recentCollectionList[index].total}",
                                              style: GoogleFonts.nunito(
                                                  fontSize: width * 0.034,
                                                  fontWeight: FontWeight.w400,
                                                  color: ColorRes.black),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.04,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (homeController
                                                      .isViewData[index] ==
                                                  false) {
                                                homeController
                                                    .isViewData[index] = true;
                                              } else {
                                                homeController
                                                    .isViewData[index] = false;
                                              }
                                              homeController.update(['home']);
                                            },
                                            child: homeController
                                                    .isViewData[index]
                                                ? const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: ColorRes.grey3,
                                                    size: 22,
                                                  )
                                                : const Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color: ColorRes.grey3,
                                                    size: 22,
                                                  ),
                                          )
                                        ],
                                      ),
                                      homeController.isViewData[index]
                                          ? SizedBox(
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.32,
                                                            ),

                                                            SizedBox(
                                                              child: Text(
                                                                // homeController.recentCollectionList[index]
                                                                //     .listData![index].machine
                                                                //     .toString(),
                                                                //   "\$ ${controller.calculateTotalValue(controller.allCollectionData[index].machineDetails?[i].current![0].In, controller.allCollectionData[index].machineDetails?[i].previous?[0].In)}",
                                                                // homeController.recentCollectionList[index]
                                                                //     .locationDetails?[i].current![0].pre as String,
                                                                'Machine: ${homeController.recentCollectionList.length}',
                                                                style: GoogleFonts.nunito(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: ColorRes
                                                                        .grey),
                                                              ),
                                                            ),
                                                            const SizedBox(width: 10,),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Previous',
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: ColorRes
                                                                          .grey),
                                                                ),
                                                                Text(
                                                                  'Current',
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: ColorRes
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.03,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  // '\$${homeController.recentCollectionList[index].inNumbers?.previous ?? 0}',
                                                                  "\$${homeController.calculateSubtractedValue(In: homeController.recentCollectionList[index].inNumbers?.previous ?? 0, out: homeController.recentCollectionList[index].outNumbers?.current ?? 0)}",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: ColorRes
                                                                          .grey),
                                                                ),
                                                                Text(
                                                                  "\$${homeController.calculateSubtractedValue(In: homeController.recentCollectionList[index].inNumbers?.current ?? 0, out: homeController.recentCollectionList[index].outNumbers?.previous ?? 0)}",
                                                                  style: GoogleFonts.nunito(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: ColorRes
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.04,
                                                              height:
                                                                  Get.height *
                                                                      0.05,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorRes.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 20),
                                      child: SizedBox(
                                        width: Get.width * 0.35,
                                        child: Text(
                                          StringRes.pendingRepairs,
                                          style: commonTitle().copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: width * 0.042),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 140, top: 20),
                                      child: Image.asset(
                                        AssetRes.menu,
                                        scale: 3,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                (homeController.getPendingRepairsModel.data != null)?SizedBox(
                                  // height: Get.height * 0.6,
                                  child: ListView.builder(
                                    itemCount: homeController.getPendingRepairsModel.data!.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ( homeController.getPendingRepairsModel.data![index].machines != null)?ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: homeController.getPendingRepairsModel.data![index].machines!.length,
                                          itemBuilder: (context,i){
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.03,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.53,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width:Get.width *0.4,
                                                            child: Text(
                                                              "Serial No:  ${homeController.getPendingRepairsModel.data![index].machines![i].serialNumber}",
                                                              overflow:TextOverflow.ellipsis,
                                                              style: commonSubtitle()
                                                                  .copyWith(
                                                                  fontSize:
                                                                  width * 0.038),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:Get.width*0.2,
                                                      child: Text(
                                                        'Reporter: ${homeController.getPendingRepairsModel.data![index].machines![i].reporterName}',
                                                        style: commonSubtitle().copyWith(
                                                            fontSize: width * 0.038),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.03,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.52,
                                                      child: Text(
                                                        'Location: ${homeController.getPendingRepairsModel.data![index].location!.locationname}',
                                                        style: commonSubtitle()
                                                            .copyWith(
                                                            fontSize:
                                                            width * 0.038),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Date: ${DateFormat('dd MMM, yyyy').format(homeController.getPendingRepairsModel.data![index].machines![i].date ?? DateTime.now())}',
                                                      style: commonSubtitle().copyWith(
                                                          fontSize: width * 0.034),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.03,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.52,
                                                      child: Text(
                                                        'Issue: ${homeController.getPendingRepairsModel.data![index].machines![i].issue}',
                                                        style: commonSubtitle()
                                                            .copyWith(
                                                            fontSize:
                                                            width * 0.038),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Time: ${DateFormat('h:mm a').format(homeController.getPendingRepairsModel.data![index].machines![i].date ?? DateTime.now())}',
                                                      style: commonSubtitle().copyWith(
                                                          fontSize: width * 0.034),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Divider(
                                                  height: 1,
                                                  color: ColorRes.grey,
                                                  thickness: 0.1,
                                                  endIndent: 15,
                                                  indent: 15,
                                                ),
                                                // homeController.dividers(12, 7),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            );
                                          }):const SizedBox();
                                    }
                                  ),
                                ):const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                      ],
                    );
                  }),
            ),
            Obx(() => homeController.loader.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox())
          ],
        ),
        endDrawer: GetBuilder<HomeController>(
          id: 'home',
          builder: (controller) {
            return Drawer(
                width: Get.width * 0.68,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: Get.height * 0.1,
                          bottom: 30),
                      child: Row(
                        children: [
                          Container(
                            height: 43,
                            width: 45,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        AssetRes.profilePhotoDrawer)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jim Gallagher",
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ColorRes.black)),
                              const SizedBox(
                                height: 2,
                              ),
                              Text("Employee",
                                  style: GoogleFonts.nunito(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: ColorRes.grey)),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: homeController.dividers(5, 5),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: homeController.imageList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.back();
                              homeController.Currentindex(index);
                              homeController.update(['home']);
                              if (homeController.currentIndex == 0) {
                                Get.to(() => CollectionReportScreen());
                              } else if (homeController.currentIndex == 1) {
                                Get.to(() => RepairScreen());
                              } else if (homeController.currentIndex == 2) {
                                Get.to(() => const ServiceReportScreen());
                              } else if (homeController.currentIndex == 3) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Theme(
                                        data: ThemeData(dialogBackgroundColor: ColorRes.white),
                                        child: AlertDialog(
                                          title: const Text(
                                            'Are you sure to want to exit?.',
                                            style: TextStyle(fontSize: 22, color: ColorRes.mainColor),
                                          ),

                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(ColorRes.mainColor),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text(
                                                'No',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {

                                                Get.offAll(() => const AdminScreen());
                                                var rememberData  =  PrefService.getString(PrefKeys.remember);

                                                PrefService.clear();

                                                  PrefService.setValue(PrefKeys.remember, rememberData);


                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(ColorRes.mainColor),
                                              ),
                                              child: const Text('Yes',style:  TextStyle(color: Colors.white),),
                                            ),
                                            const SizedBox(width: 2),
                                          ],
                                        ),
                                      );
                                    });

                              }
                            },
                            child: ListTile(
                              leading: Image.asset(
                                homeController.imageList[index],
                                scale: 4,
                              ),
                              title: Text(
                                  homeController.drawerTitle[index].toString(),
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: ColorRes.color9A9AA9)),
                            ));
                      },
                    ))
                  ],
                ));
          },
        ),
      ),
    );
  }
}
