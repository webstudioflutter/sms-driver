class ServicingHistoryModel {
  int? count;
  List<Result>? result;
  String? error;

  ServicingHistoryModel.withError(String errorValue) : error = errorValue;

  ServicingHistoryModel({this.count, this.result});

  ServicingHistoryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }
}

class Result {
  DriverInfo? driverInfo;
  String? billType;
  DriverInfo? vehicleInfo;
  List<String>? partsUsed;
  List<String>? oldPartsImages;
  List<String>? newPartsImages;
  bool? status;
  String? createdAt;
  bool? isArchived;
  String? sId;
  String? date;
  int? billAmount;
  String? billImage;
  String? createdBy;

  Result(
      {this.driverInfo,
      this.billType,
      this.vehicleInfo,
      this.partsUsed,
      this.oldPartsImages,
      this.newPartsImages,
      this.status,
      this.createdAt,
      this.isArchived,
      this.sId,
      this.date,
      this.billAmount,
      this.billImage,
      this.createdBy});

  Result.fromJson(Map<String, dynamic> json) {
    driverInfo = json['driverInfo'] != null
        ? new DriverInfo.fromJson(json['driverInfo'])
        : null;
    billType = json['billType'] ?? "";
    vehicleInfo = json['vehicleInfo'] != null
        ? new DriverInfo.fromJson(json['vehicleInfo'])
        : null;
    partsUsed = json['partsUsed'].cast<String>();
    oldPartsImages = json['oldPartsImages'].cast<String>();
    newPartsImages = json['newPartsImages'].cast<String>();
    status = json['status'];
    createdAt = json['createdAt'];
    isArchived = json['isArchived'];
    sId = json['_id'];
    date = json['date'];
    billAmount = json['billAmount'];
    billImage = json['billImage'];
    createdBy = json['createdBy'];
  }
}

class DriverInfo {
  String? sId;

  DriverInfo({this.sId});
  DriverInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }
}
