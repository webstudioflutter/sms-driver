import 'dart:async';
import 'dart:developer';

import 'package:driver_app/Model/TransportModel.dart';
import 'package:driver_app/Repository/TransportREpository.dart';
import 'package:rxdart/rxdart.dart';

class TransportBloc {
  final TransportRepository _transportRepository = TransportRepository();
  final BehaviorSubject<Transportation> transportinfo =
      BehaviorSubject<Transportation>();

  Future<Transportation> postlocation(
    String? Id,
    Map<String, dynamic> data,
  ) async {
    try {
      final responses = await _transportRepository.transportdata(
        Id,
        data,
      );
      if (responses.data != null) {
        transportinfo.sink.add(responses);
      } else {}
      return responses;
    } catch (e) {
      log(e.toString());
      return Transportation.withError('$e');
    }
  }

  BehaviorSubject<Transportation> get transportInfoInfo => transportinfo;

  void dispose() {
    transportinfo.close();
  }
}

final transportBloc = TransportBloc();
