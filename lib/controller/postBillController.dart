import 'dart:developer';

import 'package:driver_app/Model/postBillModel.dart';
import 'package:driver_app/Repository/PostBillRepository.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class PostBillController extends GetxController {
  var postbill = Rxn<PostBillModel>();
  var isLoading = false.obs;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Future<void> postGetBills(Map<String, dynamic> data) async {
    isLoading.value = true;

    try {
      var Response = await postBillRepository.postBillData(data);

      if (Response.result != null) {
        log("bill data ${Response.result}");
        postbill.value = Response;
      } else {
        log("bill data ${Response.error}");
        postbill.value =
            PostBillModel.withError(baseController.handleError(Response.error));
      }
    } catch (e) {
      log("Error: $e");
      postbill.value = PostBillModel.withError(baseController.handleError(e));
    } finally {
      isLoading.value = false;
    }
  }
}

var postBillController = PostBillController();
