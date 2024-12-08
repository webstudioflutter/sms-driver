import 'dart:developer';

import 'package:driver_app/Model/Authenticationmodel.dart';
import 'package:driver_app/Repository/ProfileRepository.dart';
import 'package:driver_app/Repository/auth/Basecontroller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var profile =
      Rxn<AuthenticationModel>(); // Rxn is used for nullable observable values
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
    String? profileId = await _secureStorage.read(key: 'driverId');
    try {
      final Response =
          await profileRepository.ProfileData(profileId.toString());
      if (Response.result != null) {
        profile.value = Response;
        String? fcmtokens = await _secureStorage.read(key: 'notificationtoken');
        var data = {
          "fcmToken": "${fcmtokens}",
        };
        Future.delayed(Duration(seconds: 1), () {
          updateProfile(data);
        });
      } else {
        profile.value = AuthenticationModel.withError(
            baseController.handleError(Response.error));
      }
    } catch (e) {
      log("Error: $e");
      profile.value =
          AuthenticationModel.withError(baseController.handleError(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    isLoading.value = true;
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
    String? profileId = await _secureStorage.read(key: 'driverId');
    try {
      final Response =
          await profileRepository.updateProfileField("${profileId}", data);
      if (Response.result != null) {
        profile.value = Response; // Assign the fetched profile
        log("thissss${Response.result}");
      } else {
        profile.value = AuthenticationModel.withError(
            baseController.handleError(Response.error));
      }
    } catch (e) {
      log("Error: $e");
      profile.value =
          AuthenticationModel.withError(baseController.handleError(e));
    } finally {
      isLoading.value = false;
    }
  }
}

var profileController = ProfileController();
