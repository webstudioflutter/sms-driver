import 'dart:async';
import 'dart:developer';

import 'package:driver_app/Model/TransportModel.dart';
import 'package:driver_app/Repository/TransportREpository.dart';
import 'package:rxdart/rxdart.dart';

class TransportBloc {
  final TransportRepository _transportRepository = TransportRepository();
  final BehaviorSubject<TransportationModel> transportinfo =
      BehaviorSubject<TransportationModel>();

  Future<TransportationModel> postlocation(
    String? Id,
    Map<String, dynamic> data,
  ) async {
    try {
      final responses = await _transportRepository.transportdata(Id, data);
      if (responses.result != null) {
        transportinfo.sink.add(responses);
      } else {
        transportinfo.sink.add(TransportationModel.withError('No data found'));
      }
      return responses;
    } catch (e) {
      log(e.toString());
      return TransportationModel.withError('$e');
    }
  }

  BehaviorSubject<TransportationModel> get transportInfoInfo => transportinfo;
}

final transportBloc = TransportBloc();
