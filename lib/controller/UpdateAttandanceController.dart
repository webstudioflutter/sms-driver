import 'dart:developer';

import 'package:driver_app/Repository/vechileAttendanceRepository.dart';
import 'package:rxdart/rxdart.dart';

import '../Model/updateAttandanceModel.dart';

class vechileattandancebyprops {
  final vechileRepository = vechileAttendanceRepository();

  final BehaviorSubject<UpdateAttandanceModel> vechileattendance =
      BehaviorSubject<UpdateAttandanceModel>();
  final BehaviorSubject<UpdateAttandanceModel> patching =
      BehaviorSubject<UpdateAttandanceModel>();

  Future<UpdateAttandanceModel> getbyprops(
      Map<String, dynamic> postdatas) async {
    try {
      final responses = await vechileRepository.getDatabyprops(postdatas);
      if (responses.result != null) {
        vechileattendance.sink.add(responses);
      } else {
        UpdateAttandanceModel.withError('${responses.error}');
      }
      return responses;
    } catch (e) {
      log(e.toString());
      return UpdateAttandanceModel.withError('$e');
    }
  }

  Future<UpdateAttandanceModel> patchattandance(
      String Id, Map<String, dynamic> postdatas) async {
    try {
      final responses = await vechileRepository.attendancepatch(Id, postdatas);
      if (responses.result != null) {
        patching.sink.add(responses);
        log("patching ${responses.result}");
      } else {
        UpdateAttandanceModel.withError('${responses.error}');
      }
      return responses;
    } catch (e) {
      log(e.toString());
      return UpdateAttandanceModel.withError('$e');
    }
  }

  BehaviorSubject<UpdateAttandanceModel> get vechileattendanceinfo =>
      vechileattendance;
  BehaviorSubject<UpdateAttandanceModel> get patchinginfo => patching;
}

final attandancebyprops = vechileattandancebyprops();
