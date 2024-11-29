// To parse this JSON data, do
//
//     final postBillModel = postBillModelFromJson(jsonString);

import 'dart:convert';

PostBillModel postBillModelFromJson(String str) =>
    PostBillModel.fromJson(json.decode(str));

String postBillModelToJson(PostBillModel data) => json.encode(data.toJson());

class PostBillModel {
  String? message;
  Result? result;
  String? error;

  PostBillModel({
    this.message,
    this.result,
  });

  PostBillModel.withError(String errorValue) : error = errorValue;

  factory PostBillModel.fromJson(Map<String, dynamic> json) => PostBillModel(
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  List<dynamic>? partsUsed;
  List<dynamic>? oldPartsImages;
  List<dynamic>? newPartsImages;
  bool? status;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  DateTime? date;
  String? expenseType;
  String? billType;
  String? billTitle;
  int? billAmount;
  String? nextServiceDate;
  dynamic billImage;
  Info? driverInfo;
  Info? vehicleInfo;
  String? createdBy;
  int? v;

  Result({
    this.partsUsed,
    this.oldPartsImages,
    this.newPartsImages,
    this.status,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.date,
    this.expenseType,
    this.billType,
    this.billTitle,
    this.billAmount,
    this.nextServiceDate,
    this.billImage,
    this.driverInfo,
    this.vehicleInfo,
    this.createdBy,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        partsUsed: json["partsUsed"] == null
            ? []
            : List<dynamic>.from(json["partsUsed"]!.map((x) => x)),
        oldPartsImages: json["oldPartsImages"] == null
            ? []
            : List<dynamic>.from(json["oldPartsImages"]!.map((x) => x)),
        newPartsImages: json["newPartsImages"] == null
            ? []
            : List<dynamic>.from(json["newPartsImages"]!.map((x) => x)),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        schoolId: json["schoolId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        expenseType: json["expenseType"],
        billType: json["billType"],
        billTitle: json["billTitle"],
        billAmount: json["billAmount"],
        nextServiceDate: json["nextServiceDate"],
        billImage: json["billImage"],
        driverInfo: json["driverInfo"] == null
            ? null
            : Info.fromJson(json["driverInfo"]),
        vehicleInfo: json["vehicleInfo"] == null
            ? null
            : Info.fromJson(json["vehicleInfo"]),
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "partsUsed": partsUsed == null
            ? []
            : List<dynamic>.from(partsUsed!.map((x) => x)),
        "oldPartsImages": oldPartsImages == null
            ? []
            : List<dynamic>.from(oldPartsImages!.map((x) => x)),
        "newPartsImages": newPartsImages == null
            ? []
            : List<dynamic>.from(newPartsImages!.map((x) => x)),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "expenseType": expenseType,
        "billType": billType,
        "billTitle": billTitle,
        "billAmount": billAmount,
        "nextServiceDate": nextServiceDate,
        "billImage": billImage,
        "driverInfo": driverInfo?.toJson(),
        "vehicleInfo": vehicleInfo?.toJson(),
        "createdBy": createdBy,
        "__v": v,
      };
}

class Info {
  String? id;
  String? name;

  Info({
    this.id,
    this.name,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
