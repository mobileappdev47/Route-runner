
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_runner/common/common_text_fild.dart';
import 'package:route_runner/screens/collection_detail/collection_detail_screen.dart';
import 'package:route_runner/screens/new_collection/new_collection_controller.dart';
import 'package:route_runner/utils/asset_res.dart';
import 'package:route_runner/utils/color_res.dart';
import 'package:route_runner/utils/strings.dart';

import '../../utils/text_style.dart';

class NewCollectionScreen extends StatelessWidget {
  const NewCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewCollectionController newCollectionController =
        Get.put(NewCollectionController());

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                data: ThemeData(dialogBackgroundColor: ColorRes.white),
                child: AlertDialog(
                  title: const Text(
                    'If you will be back from this screen, all your changes will be discarded.',
                    style: TextStyle(fontSize: 22, color: ColorRes.mainColor),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(ColorRes.mainColor),
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
                        Get.back();
                        Get.back();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(ColorRes.mainColor),
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 2),
                  ],
                ),
              );
            });
        return true;
      },
      child: Scaffold(
          backgroundColor: ColorRes.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: ThemeData(dialogBackgroundColor: ColorRes.white),
                        child: AlertDialog(
                          title: const Text(
                            'If you will be back from this screen, all your changes will be discarded.',
                            style: TextStyle(fontSize: 22, color: ColorRes.mainColor),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(ColorRes.mainColor),
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
                                Get.back();
                                Get.back();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(ColorRes.mainColor),
                              ),
                              child: const Text(
                                'Yes',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 2),
                          ],
                        ),
                      );
                    });

                // Get.to(HomeScreen());
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: ColorRes.white,
                size: 20,
              ),
            ),
            centerTitle: true,
            backgroundColor: ColorRes.mainColor,
            title: Text(
              'New Collection',
              style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w600, color: ColorRes.white),
            ),

            // automaticallyImplyLeading: false,
          ),
          body: Stack(
            children: [
              GetBuilder<NewCollectionController>(
                id: 'collection',
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          CommonTextField(
                            readOnly: true,
                            type: TextInputType.number,
                            color: ColorRes.bgColor,
                            isRequired: true,
                            hintText: "Moonlight Bar",
                            titleText: StringRes.location,
                            suffixIcon: AssetRes.arrowDown,
                            suffixIconOnTap: () {
                              newCollectionController.isClick = !newCollectionController.isClick;
                              controller.update(['collection']);},
                            suffixIconSize: 3,
                            isSuffixIcon: true,
                            controller: controller.locationController,
                          ),
                          (newCollectionController.locationError != "")
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      newCollectionController.locationError.tr,
                                      style: commonSubtitle().copyWith(color: ColorRes.red),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          newCollectionController.isClick == false
                              ? const SizedBox()
                              : Container(
                                  width: Get.width * 0.9,
                                  decoration: const BoxDecoration(color: ColorRes.bgColor),
                                  child: ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onTap: () {
                                              controller.locationController.text = controller.locationsData[index].locationname ?? "";
                                              controller.locationId = controller.locationsData[index].id ?? "";
                                              controller.locationIndex = index;
                                              newCollectionController.isClick = false;
                                              controller.machineNumberController = [];
                                              controller.enterSerialNumberController = [];
                                              controller.auditNumberController = [];
                                              controller.previousNumberInController = [];
                                              controller.previousNumberOutController = [];
                                              controller.currentNumberInController = [];
                                              controller.currentNumberOutController = [];
                                              controller.pageIndex = 0;
                                              controller.totalController = [];
                                              controller.selectImage = [];
                                              controller.selectImageUrl = [];
                                              controller.selectImageTemp = [];
                                              controller.selectImageTempUrl = [];
                                              controller.getMachines();
                                              newCollectionController.update(['collection']);
                                            },
                                            child: ListTile(
                                              title: Text(
                                                controller.locationsData[index].locationname ?? "",
                                                style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.color030229),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) => const Divider(color: ColorRes.grey3, endIndent: 10, indent: 10, height: 1),
                                      itemCount: controller.locationsData.length,
                                  ),
                          ),

                          const SizedBox(height: 20),

                          /// --- new flow
                          (controller.machineData.isNotEmpty)
                              ? SizedBox(
                                  height: Get.height * 0.55,
                                  child: PageView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      onPageChanged: (v) {
                                        controller.pageIndex = v;
                                        controller.update(['collection']);
                                      },
                                      itemCount: controller.machineData[0].machines!.length,
                                      controller: controller.pageController,
                                      itemBuilder: (context, i) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: Get.width,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        children: [
                                                          CommonTextField(
                                                              readOnly: true,
                                                              type: TextInputType.number,
                                                              isRequired: true,
                                                              hintText: "#12",
                                                              // suffixIcon:
                                                              //     AssetRes
                                                              //         .arrowDown,
                                                              // suffixIconOnTap:
                                                              //     () {
                                                              //   // newCollectionController
                                                              //   //         .isClickMachine =
                                                              //   //     !newCollectionController
                                                              //   //         .isClickMachine;
                                                              //   //
                                                              //   // controller
                                                              //   //     .update([
                                                              //   //   'collection'
                                                              //   // ]);
                                                              // },
                                                              // suffixIconSize:
                                                              //     3,
                                                              // isSuffixIcon:
                                                              //     true,
                                                              color: ColorRes.bgColor,
                                                              titleText: StringRes.machineNumber,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(2),
                                                                FilteringTextInputFormatter.digitsOnly,
                                                              ],
                                                              controller: controller.machineNumberController[i]),
                                                          /*          newCollectionController.isClickMachine == false
                                                              ? const SizedBox()
                                                              : (controller.locationIndex != null)
                                                                  ? Container(
                                                                      width: Get.width * 0.9,
                                                                      decoration: const BoxDecoration(color: ColorRes.bgColor),
                                                                      child: ListView.separated(
                                                                        physics: const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap: true,
                                                                        separatorBuilder: (context, index) => const Divider(
                                                                            color: ColorRes.grey3,
                                                                            endIndent: 10,
                                                                            indent: 10,
                                                                            height: 1),
                                                                        itemBuilder:
                                                                            (context, index) {
                                                                          return GestureDetector(
                                                                            onTap: () {
                                                                              controller.machineNumberController[i].text = controller.machineData[0].machines?[index].machineNumber ?? "";
                                                                              controller.enterSerialNumberController[i].text = controller.machineData[0].machines?[index].serialNumber ?? "";
                                                                              controller.auditNumberController[i].text = controller.machineData[0].machines?[index].gameName ?? "";

                                                                              newCollectionController.isClickMachine = false;
                                                                              newCollectionController.update([
                                                                                'collection'
                                                                              ]);
                                                                            },
                                                                            child: ListTile(
                                                                              title: Text(controller.machineData[0].machines![index].machineNumber ?? "",
                                                                                  style: GoogleFonts.nunito(
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    color: ColorRes.color030229,
                                                                                  )),
                                                                            ),
                                                                          );
                                                                        },
                                                                        itemCount:
                                                                            controller.machineData[0].machines!.length,
                                                                      ))
                                                                  : const SizedBox(),*/
                                                          (newCollectionController.machineError[i] != "")
                                                              ? Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(top: 3),
                                                                    child: Text(
                                                                      newCollectionController.machineError[i],
                                                                      style: commonSubtitle().copyWith(color: ColorRes.red),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),

                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        children: [
                                                          CommonTextField(
                                                              readOnly: true,
                                                              suffixIcon: AssetRes.arrowDown,
                                                              // suffixIconOnTap:
                                                              //     () {
                                                              //   // newCollectionController
                                                              //   //         .isClickSerial =
                                                              //   //     !newCollectionController
                                                              //   //         .isClickSerial;
                                                              //   // controller
                                                              //   //     .update([
                                                              //   //   'collection'
                                                              //   // ]);
                                                              // },
                                                              // suffixIconSize:
                                                              //     3,
                                                              // isSuffixIcon:
                                                              //     true,
                                                              type: TextInputType.number,
                                                              color: ColorRes.bgColor,
                                                              isRequired: true,
                                                              hintText: StringRes.num3,
                                                              titleText: StringRes.serialNumber,
                                                              controller: controller.enterSerialNumberController[i],
                                                          ),
                                                          /*    newCollectionController
                                                                      .isClickSerial ==
                                                                  false
                                                              ? const SizedBox()
                                                              : (controller
                                                                          .locationIndex !=
                                                                      null)
                                                                  ? Container(
                                                                      // height: Get.height * 0.26,
                                                                      width: Get.width *
                                                                          0.9,
                                                                      decoration:
                                                                          const BoxDecoration(color: ColorRes.bgColor),
                                                                      child: ListView.builder(
                                                                          physics: const NeverScrollableScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          itemBuilder: (context, index) => (controller.machineData[index].id == controller.locationId)
                                                                              ? ListView.separated(
                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                  shrinkWrap: true,
                                                                                  separatorBuilder: (context, index) => const Divider(color: ColorRes.grey3, endIndent: 10, indent: 10, height: 1),
                                                                                  itemBuilder: (context, i) {
                                                                                    return GestureDetector(
                                                                                      onTap: () {
                                                                                        controller.enterSerialNumberController[i].text = controller.machineData[index].machines?[i].serialNumber ?? "";
                                                                                        controller.machineNumberController[i].text = controller.machineData[index].machines?[i].machineNumber ?? "";
                                                                                        controller.auditNumberController[i].text = controller.machineData[index].machines?[i].gameName ?? "";
                                                                                        newCollectionController.isClickSerial = false;
                                                                                        newCollectionController.update(['collection']);
                                                                                      },
                                                                                      child: ListTile(
                                                                                        title: Text(controller.machineData[index].machines![i].serialNumber ?? "",
                                                                                            style: GoogleFonts.nunito(
                                                                                              fontSize: 14,
                                                                                              fontWeight: FontWeight.w400,
                                                                                              color: ColorRes.color030229,
                                                                                            )),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  itemCount: controller.machineData[index].machines!.length,
                                                                                )
                                                                              : const SizedBox(),
                                                                          itemCount: controller.machineData.length))
                                                                  : const SizedBox(),*/
                                                          (newCollectionController.serialError[i] != "")
                                                              ? Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(top: 3),
                                                                    child: Text(
                                                                      newCollectionController.serialError[i],
                                                                      style: commonSubtitle().copyWith(color: ColorRes.red),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),

                                              CommonTextField(
                                                readOnly: true,
                                                type: TextInputType.text,
                                                color: ColorRes.bgColor,
                                                isRequired: true,
                                                hintText: "Game name ",
                                                titleText: StringRes.enterGameName,
                                                controller: controller.auditNumberController[i],
                                              ),

                                              (newCollectionController.auditError[i] != "")
                                                  ? Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 3),
                                                        child: Text(
                                                          newCollectionController.auditError[i],
                                                          style: commonSubtitle().copyWith(color: ColorRes.red),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),

                                              const SizedBox(height: 20),

                                              /// in
                                              Row(
                                                children: [
                                                  Text(
                                                    "In",
                                                    style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.color030229),
                                                  ),
                                                  const Text(
                                                    ' *',
                                                    style: TextStyle(fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 9),

                                              SizedBox(
                                                width: Get.width,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        children: [
                                                          CommonTextField(
                                                              type: TextInputType.number,
                                                              color: ColorRes.bgColor,
                                                              isRequired: true,
                                                              hintText: "0",
                                                              readOnly: true,
                                                              titleText: StringRes.previousNumber,
                                                              controller: controller.previousNumberInController[i]),
                                                          /*          (newCollectionController
                                                                          .inPreviousError[
                                                                      i] !=
                                                                  "")
                                                              ? Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 3),
                                                                    child: Text(
                                                                        newCollectionController.inPreviousError[
                                                                            i],
                                                                        style: commonSubtitle().copyWith(
                                                                            color:
                                                                                ColorRes.red)),
                                                                  ),
                                                                )
                                                              : const SizedBox(),*/
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: Get.width * 0.05),

                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        children: [
                                                          CommonTextField(
                                                              type: TextInputType.number,
                                                              color: ColorRes.bgColor,
                                                              isRequired: true,
                                                              hintText: "0",
                                                              titleText: StringRes.currentNumber,
                                                              onChanged: (value) {
                                                                controller.totalController[i].text = controller.calculateProfit(
                                                                    currentIn: double.parse(value ?? "0.0"),
                                                                    previousIn: controller.previousNumberInController[i].text == ""
                                                                        ? 0.0
                                                                        : double.parse(controller.previousNumberInController[i].text ?? '0.0'),
                                                                    currentOut: double.parse(controller.currentNumberOutController[i].text ?? '0.0'),
                                                                    previousOut: controller.previousNumberOutController[i].text == ""
                                                                        ? 0.0
                                                                        : double.parse(controller.previousNumberOutController[i].text ?? '0.0')).toString();
                                                              },
                                                              controller: controller.currentNumberInController[i]),
                                                          (newCollectionController.inCurrentError[i] != "")
                                                              ? Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(top: 3),
                                                                    child: Text(
                                                                      newCollectionController.inCurrentError[i],
                                                                      style: commonSubtitle().copyWith(color: ColorRes.red),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),

                                              /// out
                                              Row(
                                                children: [
                                                  Text(
                                                    "Out",
                                                    style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.color030229),
                                                  ),
                                                  const Text(
                                                    ' *',
                                                    style: TextStyle(fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 9),
                                              SizedBox(
                                                width: Get.width,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        children: [
                                                          CommonTextField(
                                                            type: TextInputType.number,
                                                            color: ColorRes.bgColor,
                                                            isRequired: true,
                                                            readOnly: true,
                                                            hintText: "0",
                                                            titleText: StringRes.previousNumber,
                                                            controller: controller.previousNumberOutController[i],
                                                          ),
                                                          /*       (newCollectionController
                                                                          .outCurrentError[
                                                                      i] !=
                                                                  "")
                                                              ? Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 3),
                                                                    child: Text(
                                                                        newCollectionController.outCurrentError[
                                                                            i],
                                                                        style: commonSubtitle().copyWith(+-
                                                                            color:
                                                                                ColorRes.red)),
                                                                  ),
                                                                )
                                                              : const SizedBox(),*/
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: Get.width * 0.05),

                                                    SizedBox(
                                                      width: Get.width / 2.5,
                                                      child: Column(
                                                        children: [
                                                          CommonTextField(
                                                              type: TextInputType.number,
                                                              color: ColorRes.bgColor,
                                                              isRequired: true,
                                                              hintText: "0",
                                                              onChanged: (value) {
                                                                controller.totalController[i].text = controller.calculateProfit(
                                                                  currentIn: double.parse(controller.currentNumberInController[i].text ?? "0.0"),
                                                                  previousIn: controller.previousNumberInController[i].text == ""
                                                                      ? 0.0
                                                                      : double.parse(controller.previousNumberInController[i].text ?? '0.0'),
                                                                  currentOut: double.parse(value ?? '0.0'),
                                                                  previousOut: controller.previousNumberOutController[i].text == ''
                                                                      ? 0.0
                                                                      : double.parse(controller.previousNumberOutController[i].text ?? '0.0',
                                                                  ),
                                                                ).toString();
                                                              },
                                                              titleText: StringRes.currentNumber,
                                                              controller: controller.currentNumberOutController[i]),
                                                          (newCollectionController.outCurrentError[i] != "")
                                                              ? Align(
                                                                  alignment: Alignment.centerRight,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(top: 3),
                                                                    child: Text(
                                                                      newCollectionController.outCurrentError[i],
                                                                      style: commonSubtitle().copyWith(color: ColorRes.red),
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),

                                              Row(
                                                children: [
                                                  Text(
                                                    "Total",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                        color: ColorRes.color030229
                                                    ),
                                                  ),
                                                  const Text(
                                                    ' *',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 9),

                                              Container(
                                                height: 52,
                                                width: Get.width,
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: ColorRes.bgColor,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Text(
                                                  controller.totalController[i].text,
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorRes.color030229,
                                                  ),
                                                ),
                                              ),
                                              // CommonTextField(
                                              //   readOnly: true,
                                              //     type: TextInputType.number,
                                              //     color: ColorRes.bgColor,
                                              //     isRequired: true,
                                              //     hintText: StringRes.enterCurrentNumber,
                                              //     titleText: StringRes.total,
                                              //     controller: controller.totalController),

                                              (newCollectionController.totalError[i] != "")
                                                  ? Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 3),
                                                        child: Text(
                                                          newCollectionController.totalError[i].tr,
                                                          style: commonSubtitle().copyWith(color: ColorRes.red),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(height: 20),

                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          FocusScope.of(context).unfocus();
                                                          await controller.getImageFromCamera(i);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                            color: ColorRes.color5B93FF,
                                                            border: Border.all(width: 1, color: ColorRes.color5B93FF),
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: Get.width * 0.06),

                                                              Image.asset(AssetRes.camera, scale: 5),

                                                              const SizedBox(width: 10),

                                                              Text(
                                                                StringRes.captureMachineReading,
                                                                style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.white),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      (controller.imageError[i] != "")
                                                          ? Align(
                                                              alignment: Alignment.centerRight,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 3),
                                                                child: Text(
                                                                  controller.imageError[i],
                                                                  style: commonSubtitle().copyWith(color: ColorRes.red),
                                                                ),
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                              const SizedBox(height: 20),

                                              Align(
                                                alignment: Alignment.center,
                                                child: controller.selectImage[i] != null
                                                    ? Container(
                                                        height: 200,
                                                        width: 400,
                                                        color: Colors.transparent,
                                                        child: ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: controller.selectImage[i]?.length,
                                                          itemBuilder: (context, index) {
                                                            return Stack(
                                                              alignment: Alignment.topRight,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                    height: 150,
                                                                    width: 200,
                                                                    decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                        image: FileImage(controller.selectImage[i]![index]),
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller.removeImage(i, index);
                                                                  },
                                                                  child: Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration: const BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorRes.themeColor,
                                                                    ),
                                                                    alignment: Alignment.center,
                                                                    child: const Icon(
                                                                      Icons.close,
                                                                      color: ColorRes.white,
                                                                      size: 10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox(height: Get.height * 0.55),

                          const SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width / 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.pageIndex != 0) {
                                          controller.pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: ColorRes.color5B93FF),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Text(
                                          "Back",
                                          style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.color5B93FF),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: Get.width / 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.machineData.isNotEmpty) {
                                          if (newCollectionController.validation()) {
                                            newCollectionController.addCampaignData = [];
                                            for (int i = 0; i < newCollectionController.machineNumberController.length; i++) {
                                              newCollectionController.addCampaignData.add(
                                                CollectionReport(
                                                  serialNumber: newCollectionController.enterSerialNumberController[i].text,
                                                  machineId: newCollectionController.machineId[i],
                                                  gameName: newCollectionController.auditNumberController[i].text,
                                                  total: newCollectionController.totalController[i].text,
                                                  imageUrl: newCollectionController.selectImageUrl[i],
                                                  machineNumber: newCollectionController.machineNumberController[i].text,
                                                  inCurrent: newCollectionController.currentNumberInController[i].text,
                                                  inPrevious: newCollectionController.previousNumberInController[i].text,
                                                  outCurrent: newCollectionController.currentNumberOutController[i].text,
                                                  outPrevious: newCollectionController.previousNumberOutController[i].text,
                                                  image: controller.selectImage[i],
                                                ),
                                              );
                                            }

                                            if (controller.machineData.isNotEmpty) {
                                              int length = controller.machineData[0].machines!.length - 1 ;
                                              print(length);
                                              if (controller.pageIndex == length) {
                                                Get.to(() => CollectionDetailScreen());
                                              } else {
                                                controller.pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                                                controller.update(['collection']);
                                              }
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorRes.color5B93FF,
                                          border: Border.all(width: 1, color: ColorRes.color5B93FF),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Text(
                                          (controller.machineData.isNotEmpty)
                                              ? (controller.pageIndex == controller.machineData[0].machines!.length - 1)
                                                  ? StringRes.collect
                                                  : "Next"
                                              : StringRes.collect,
                                          style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.white),
                                        ),
                                      ),
                                      /* Container(
                                        height: 40,
                                        width: 180,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: ColorRes.color5B93FF,
                                            border: Border.all(width: 1, color: ColorRes.color5B93FF),
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Text(
                                          StringRes.next,
                                          style: GoogleFonts.nunito(
                                              fontSize: 14, fontWeight: FontWeight.w400, color: ColorRes.white),
                                        ),
                                      ),*/
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Obx(() => newCollectionController.loader.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox())
            ],
          )),
    );
  }
}

class CollectionReport {
  String? serialNumber;
  String? machineId;
  String? gameName;
  List? imageUrl;
  String? total;
  String? machineNumber;
  String? inPrevious;
  String? inCurrent;
  String? outPrevious;
  String? outCurrent;
  List? image;
  String? data;
  String? time;

  CollectionReport({
    this.serialNumber,
    this.machineId,
    this.gameName,
    this.imageUrl,
    this.total,
    this.machineNumber,
    this.inPrevious,
    this.inCurrent,
    this.outPrevious,
    this.outCurrent,
    this.image,
    this.data,
    this.time,
    Map<String, dynamic>? customParameters,
  }) {
    // Set custom parameters if provided
    customParameters?.forEach((key, value) {
      switch (key) {
        case 'serialNumber':
          serialNumber = value as String?;
          break;
        case 'machineId':
          machineId = value as String?;
          break;
        case 'machineNumber':
          machineNumber = value as String?;
          break;
        case 'gameName':
          gameName = value as String?;
          break;
        case 'imageUrl':
          imageUrl = value as List?;
          break;
        case 'total':
          total = value as String?;
          break;
        case 'inPrevious':
          inPrevious = value as String?;
          break;
        case 'inCurrent':
          inCurrent = value as String?;
          break;
        case 'outPrevious':
          outPrevious = value as String?;
          break;
        case 'outCurrent':
          outCurrent = value as String?;
          break;
        case 'image':
          image = value as List?;
          break;
        case 'data':
          data = value as String?;
          break;
        case 'time':
          time = value as String?;
          break;
        default:
          // Handle unknown parameter
          break;
      }
    });
  }
}
