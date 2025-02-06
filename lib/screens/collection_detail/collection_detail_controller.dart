import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:route_runner/api_call/add_new_collection_api/add_new_collection_api.dart';
import 'package:route_runner/api_call/add_new_collection_api/add_new_collection_model.dart';

class CollectionDetailController extends GetxController {
  List data = ['In', 'Out'];
  int currentindex=0;

  num calculateTotalValue(num? In, num? out) {
    num total = (In ?? 0) - (out ?? 0);
    return total;
  }

  num calculateSubtractedValue(num? In, num? out) {
    num total = (In ?? 0) - (out ?? 0);
    return total;
  }
  RxBool loader = false.obs;

  PageController pageController = PageController();

  Future<bool> addNewRepair(BuildContext context,{
    required String location,
    required List machines,
  })
  async {
    loader.value = true;
    addNewCollectionModel =  await CustomerNewCollectionApi.customerNewCollectionApi(
      context,
      location: location,
      machines: machines,
    );
    update(['collection']);
    update(['newRepair']);
    loader.value = false;

    return  loader.value;
  }
  AddNewCollectionModel addNewCollectionModel =AddNewCollectionModel();


}
