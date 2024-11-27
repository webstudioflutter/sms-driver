class ServicingModel {
  String? schoolId;
  String? date;
  String? expenseType;
  String? billType;
  String? billTitle;
  int? billAmount;
  String? nextServiceDate;
  List<String>? partsUsed;
  List<String>? billImage;
  List<String>? oldPartsImages;
  List<String>? newPartsImages;
  DriverInfo? driverInfo;
  DriverInfo? vehicleInfo;
  bool? status;
  String? error;

  ServicingModel.withError(String errorValue) : error = errorValue;

  ServicingModel({
    this.schoolId,
    this.date,
    this.expenseType,
    this.billType,
    this.billTitle,
    this.billAmount,
    this.nextServiceDate,
    this.partsUsed,
    this.billImage,
    this.oldPartsImages,
    this.newPartsImages,
    this.driverInfo,
    this.vehicleInfo,
    this.status,
    this.error,
  });

  ServicingModel.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    date = json['date'];
    expenseType = json['expenseType'];
    billType = json['billType'];
    billTitle = json['billTitle'];
    billAmount = json['billAmount'];
    nextServiceDate = json['nextServiceDate'];
    partsUsed = json['partsUsed'].cast<String>();
    billImage = json['billImage'].cast<String>();
    oldPartsImages = json['oldPartsImages'].cast<String>();
    newPartsImages = json['newPartsImages'].cast<String>();
    driverInfo = json['driverInfo'] != null
        ? new DriverInfo.fromJson(json['driverInfo'])
        : null;
    vehicleInfo = json['vehicleInfo'] != null
        ? new DriverInfo.fromJson(json['vehicleInfo'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['date'] = this.date;
    data['expenseType'] = this.expenseType;
    data['billType'] = this.billType;
    data['billTitle'] = this.billTitle;
    data['billAmount'] = this.billAmount;
    data['nextServiceDate'] = this.nextServiceDate;
    data['partsUsed'] = this.partsUsed;
    data['billImage'] = this.billImage;
    data['oldPartsImages'] = this.oldPartsImages;
    data['newPartsImages'] = this.newPartsImages;
    if (this.driverInfo != null) {
      data['driverInfo'] = this.driverInfo!.toJson();
    }
    if (this.vehicleInfo != null) {
      data['vehicleInfo'] = this.vehicleInfo!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class DriverInfo {
  String? sId;
  String? name;

  DriverInfo({this.sId, this.name});

  DriverInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
