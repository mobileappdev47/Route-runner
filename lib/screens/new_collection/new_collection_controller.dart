import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:route_runner/api_call/getAllCollection/get_all_Collection_api.dart';
import 'package:route_runner/api_call/getAllCollection/get_all_collection_model.dart';
import 'package:route_runner/api_call/get_last_collection_api/get_last_collection_model.dart';
import 'package:route_runner/api_call/get_location_api/get_location_api.dart';
import 'package:route_runner/api_call/get_location_api/get_location_model.dart';
import 'package:route_runner/api_call/get_machine_api/get_machine_model.dart';
import 'package:route_runner/model/location_model.dart';
import 'package:route_runner/screens/new_collection/new_collection_screen.dart';

import '../../api_call/get_machine_api/get_machine_api.dart';
import '../../utils/strings.dart';

class NewCollectionController extends GetxController {
  RxBool loader = false.obs;
  ScrollController scrollController = ScrollController();

  LocationModel? locationModel;
  List<CollectionReport> addCampaignData = [];

// <<<<<<< HEAD
//   TextEditingController machineNumberController = TextEditingController();
//   TextEditingController auditNumberController = TextEditingController();
//   TextEditingController enterSerialNumberController = TextEditingController();
//   TextEditingController enterCurrentNumberController = TextEditingController();
// =======
List machineId =[];
  List machineNumberController  =[];
  List enterSerialNumberController  =[];
  List auditNumberController  =[];
  List previousNumberInController  =[];
  List previousNumberOutController  =[];
  List currentNumberInController  =[];
  List currentNumberOutController  =[];
  List totalController  =[];
  TextEditingController locationController = TextEditingController();

  String  downloadUrl = "";
  String  locationId = "";
  int?  locationIndex;
  List<File?> image =[];
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<List<File>?> selectImage = [];
  List<List<String>?> selectImageUrl = [];
  List<Map<String,List<File>>> selectImageTemp = [];
  List<Map<String,List<String>>> selectImageTempUrl = [];

  double calculateProfit({
    double? previousIn,
    double? currentIn,
    double? previousOut,
    double? currentOut,
  }) {
    if(previousIn != 0.0 && currentIn != 0.0 && previousOut != 0.0 && currentOut != 0.0)
      {
        double totalIn = (currentIn ?? 0.0) - (previousIn ?? 0.0);
        double totalOut = (currentOut ?? 0.0) - (previousOut ?? 0.0);

        double profit = totalIn - totalOut;

        update(['collection']);
        return profit;
      }
    else
      {


        update(['collection']);


        return 0.0;
      }

  }


  Future<void> getImageFromCamera(index) async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    loader.value = true;

        List<String> imagesAllIndexUrl =[];
List<File> imagesAllIndex = [];
    if (photo != null) {
      image[index] = File(photo.path);
      if(image[index] != null) {
        for (var element in selectImageTemp) {
        imagesAllIndex = (element['$index']) ?? [];
      }
      }

      imagesAllIndex.add(File(photo.path));

      selectImageTemp.add({
        "$index" :imagesAllIndex
      });

      List<File> data =[];
      for (var element in selectImageTemp) {
     data = (element['$index']) ??[];

      }


      print(selectImageTemp);
      selectImage[index] = data;
      {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        Reference storageReference = _storage.ref().child('images/$fileName');

        UploadTask uploadTask = storageReference.putFile(image[index]!);

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print("downloadUrl ---------->$downloadUrl");
        for (var element in selectImageTempUrl) {
          imagesAllIndexUrl = (element['$index']) ??[];
        }
        imagesAllIndexUrl.add(downloadUrl);


        selectImageTempUrl.add(
          {
            "$index":imagesAllIndexUrl,
          }
        );

        loader.value = false;
        List<String> dataUrl =[];
        for (var element in selectImageTempUrl) {
          dataUrl = (element['$index'])??[];
        }
        selectImageUrl[index] = dataUrl;
      }
    }
    update(['collection']);
  }


  removeImage(i,index){
    selectImage[i]?.removeAt(index);
    selectImageUrl[i]?.removeAt(index);

for (var element in selectImageTemp) {
  element['$index']?.remove(selectImage[index]);
}
    for (var element in selectImageTempUrl) {
      element['$index']?.remove(selectImageUrl[index]);
    }

    update(['collection']);

  }

GetAllCollectionModel getAllCollectionModel = GetAllCollectionModel();
  GetLocationModel getLocationModel= GetLocationModel();
  GetMachinesModel getMachinesModel= GetMachinesModel();
  List<LocationsData> locationsData = [];
  List<LocationDataMachine> machineData = [];
  PageController pageController =PageController(initialPage: 0);
  int pageIndex = 0;


  int currentPage =1;
  int limitPerPage =10;
  getLocation({page, search}) async {
    loader.value = true;
    getLocationModel = await CustomerGetLocationApi.customerGetLocationApi(page: page, search: search);

    if (getLocationModel.locations != null && getLocationModel.locations!.isNotEmpty) {
      // Remove duplicates before adding new locations
      Set<String?> existingIds = locationsData.map((location) => location.id).toSet();
      List<LocationsData> newLocations = getLocationModel.locations!
          .where((location) => !existingIds.contains(location.id))
          .toList();
      locationsData.addAll(newLocations);
print("===========================================$locationsData");
      update(['collection']);
    }

    loader.value = false;
  }
  getMachines({page, search}) async {
    machineData =[];
    loader.value = true;
    getMachinesModel = await CustomerGetMachineApi.customerGetMachineApi(
        page: page, limit: limitPerPage, search: search);

    if (getMachinesModel.locations != null &&
        getMachinesModel.locations!.isNotEmpty) {
      if (getMachinesModel.locations != null) {
      currentPage++;
        for (int i = 0; i < getMachinesModel.locations!.length; i++) {
          Set<String?> existingIds = machineData.map((machine) => machine.id)
              .toSet();
          List<LocationDataMachine> newLocations = getMachinesModel.locations!
              .where((location) => !existingIds.contains(location.id))
              .toList();

          for (var element in newLocations) {
            if(element.id == locationId)
              {
if(element.machines!.isNotEmpty) {
  machineData.add(element);
}
              }
          }
print(machineData);

if(machineData.isNotEmpty && machineData[0].machines!.isNotEmpty) {
  machineNumberController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController(text:machineData[0].machines![index].machineNumber ));
  enterSerialNumberController = List.generate(
      machineData[0].machines!.length, (index) => TextEditingController(text:machineData[0].machines![index].serialNumber ));
  auditNumberController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController(text:machineData[0].machines![index].gameName ));


  previousNumberInController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController());
  previousNumberOutController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController());
  currentNumberInController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController());
  currentNumberOutController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController());
  totalController =
      List.generate(machineData[0].machines!.length, (index) => TextEditingController());

  machineError = List.generate(machineData[0].machines!.length, (index) => '');
  serialError = List.generate(machineData[0].machines!.length, (index) => '');
  auditError = List.generate(machineData[0].machines!.length, (index) => '');
  inPreviousError = List.generate(machineData[0].machines!.length, (index) => '');
  inCurrentError = List.generate(machineData[0].machines!.length, (index) => '');
  outPreviousError = List.generate(machineData[0].machines!.length, (index) => '');
  outCurrentError = List.generate(machineData[0].machines!.length, (index) => '');
  totalError = List.generate(machineData[0].machines!.length, (index) => '');
  imageError = List.generate(machineData[0].machines!.length, (index) => '');
  machineId = List.generate(machineData[0].machines!.length, (index) => machineData[0].machines![index].id );
  image = List.generate(machineData[0].machines!.length, (index) => null);
  selectImage = List.generate(machineData[0].machines!.length, (index) =>null);
  selectImageUrl = List.generate(machineData[0].machines!.length, (index) =>null);

}
          if(machineData.isNotEmpty && machineData[0].machines!.isNotEmpty) {
            for (int index = 0; index <
                machineData[0].machines!.length; index++) {
              previousNumberSetUp(index);
            }
          }
          update(['collection']);
        }
      }

      update(['location']);
      loader.value = false;
    }
    LastCollectionModel lastCollectionModel = LastCollectionModel();








    //
    // File? image;
    // final ImagePicker picker = ImagePicker();
    // Future<void> getImageFromCamera() async {
    //   final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    //
    //   if (photo != null) {
    //
    //       image = File(photo.path);
    //   }
    //   update(['collection']);
    // }
  }




  previousNumberSetUp(index) async {
    loader.value = true;
    getAllCollectionModel = await GetAllCollectionApi.getAllCollectionApi();
    if (getAllCollectionModel.data != null) {
      for (var element in getAllCollectionModel.data!) {
        if (element.machines != null && element.machines!.isNotEmpty) {
          for (var e in element.machines!) {
            if (e.id.toString() == machineId[index].toString()) {
              previousNumberInController[index].text =
                  e.inNumbers!.current.toString();
              previousNumberOutController[index].text =
                  e.outNumbers!.current.toString();

            }
          }
        }
      }
    }
    loader.value = false;
    update(['collection']);

  }


  List machineType = ['4652387645', '876366756', '9576315760'];

  List  machineError = [];
  List serialError = [];
  List auditError = [];
  String locationError = '';
  List inPreviousError = [];
  List inCurrentError = [];
  List outPreviousError = [];
  List outCurrentError = [];
  List totalError = [];
  List imageError =[];

  bool isClick = true;
  bool isClickMachine = false;
  bool isClickSerial= false;

  imageValidation() {

      if (image[pageIndex] == null) {
        imageError[pageIndex] = StringRes.addImage;
      } else {
        imageError[pageIndex] = "";
      }


    update(['newRepair']);
  }

  machineValidation() {

      if (machineNumberController[pageIndex].text.trim() == "") {
        machineError[pageIndex] = StringRes.machineError;
      } else {
        machineError[pageIndex] = '';
      }



    update(['collection']);
  }

  locationValidation() {

    if (locationController.text.trim() == "") {
      locationError = StringRes.selectLocation;
    } else {
      locationError = '';
    }
    update(['collection']);
  }


  serialValidation() {
      if (enterSerialNumberController[pageIndex].text.trim() == "") {
        serialError[pageIndex] = StringRes.serialError;
      } else {
        serialError[pageIndex] = '';
      }


    update(['collection']);
  }

  auditValidation() {

      if (auditNumberController[pageIndex].text.trim() == "") {
        auditError[pageIndex] = StringRes.machineTypeError;
      } else {
        auditError[pageIndex] = '';
      }


    update(['collection']);
  }

  inPreValidation() {

      if (previousNumberInController[pageIndex].text.trim() == "") {
        inPreviousError[pageIndex] = StringRes.previousError;
      } else {
        inPreviousError[pageIndex] = '';
      }


    update(['collection']);
  }

  inCurValidation() {

      if (currentNumberInController[pageIndex].text.trim() == "") {
        inCurrentError[pageIndex] = StringRes.currentError;
      } else {
        inCurrentError[pageIndex] = '';
      }


    update(['collection']);
  }

  outPreValidation() {
      if (previousNumberOutController[pageIndex].text.trim() == "") {
        outPreviousError[pageIndex] = StringRes.previousError;
      } else {
        outPreviousError[pageIndex] = '';
      }


    update(['collection']);
  }

  outCurValidation() {

      if (currentNumberOutController[pageIndex].text.trim() == "") {
        outCurrentError[pageIndex] = StringRes.currentError;
      } else {
        outCurrentError[pageIndex] = '';
      }


    update(['collection']);
  }

  totalValidation() {
      if (totalController[pageIndex].text.trim() == "") {
        totalError[pageIndex] = StringRes.totalError;
      } else {
        totalError[pageIndex] = '';
      }


    update(['collection']);
  }

  val() async {
    locationValidation();
    machineValidation();
    serialValidation();
    auditValidation();
    inCurValidation();
   // inPreValidation();
    outCurValidation();
   // outPreValidation();
    imageValidation();
  }

  validation() {
    val();
    if (machineError[pageIndex] == '' &&
        serialError[pageIndex] == '' &&
        auditError[pageIndex] == '' &&
        inCurrentError[pageIndex] == '' &&
       // inPreviousError[pageIndex] == '' &&
        outCurrentError [pageIndex]== '' &&
       // outPreviousError[pageIndex] == '' &&
        imageError[pageIndex] == '') {
      return true;
    } else {
      return false;
    }
  }

  //
  // File? image;
  // final ImagePicker picker = ImagePicker();
  // Future<void> getImageFromCamera() async {
  //   final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (photo != null) {
  //
  //       image = File(photo.path);
  //   }
  //   update(['collection']);
  // }
}
