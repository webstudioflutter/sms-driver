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

  Future<void> getProfile() async {
    isLoading.value = true;
    final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
    String? profileId = await _secureStorage.read(key: 'driverId');

    try {
      final Response =
          await profileRepository.ProfileData(profileId.toString());
      if (Response.result != null) {
        profile.value = Response; // Assign the fetched profile
      } else {
        log("Profile data not found");
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
