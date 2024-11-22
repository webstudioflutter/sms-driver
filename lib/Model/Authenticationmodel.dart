// To parse this JSON data, do
//
//     final authenticationModel = authenticationModelFromJson(jsonString);

import 'dart:convert';

AuthenticationModel authenticationModelFromJson(String str) =>
    AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) =>
    json.encode(data.toJson());

class AuthenticationModel {
  Result? result;
  String? message;
  String? token;
  String? error;

  AuthenticationModel({
    this.result,
    this.message,
    this.token,
  });
  AuthenticationModel.withError(String errorValue) : error = errorValue;
  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
        "message": message,
        "token": token,
      };
}

class Result {
  Address? address;
  HouseInfo? houseInfo;
  Transporation? transporation;
  String? studentType;
  List<dynamic>? languages;
  List<dynamic>? documets;
  String? group;
  bool? status;
  bool? isArchived;
  String? id;
  String? fullName;
  String? profileImage;
  String? email;
  String? username;
  int? contactNumber;
  DateTime? joiningDate;
  String? session;
  String? gender;
  DateTime? dob;
  String? religion;
  String? rollNo;
  String? bloodGroup;
  String? schoolName;
  String? fatherName;
  List<dynamic>? scholarShip;
  List<dynamic>? languageKnown;
  List<Shift>? shift;
  List<dynamic>? className;
  List<dynamic>? childrens;
  List<dynamic>? educationBackground;
  List<dynamic>? subject;
  String? createdBy;
  DateTime? createdAt;
  int? v;
  DateTime? modifiedAt;
  String? modifiedBy;
  String? citizenshipNo;
  int? experiencedYear;
  String? lisenceNo;

  Result({
    this.address,
    this.houseInfo,
    this.transporation,
    this.studentType,
    this.languages,
    this.documets,
    this.group,
    this.status,
    this.isArchived,
    this.id,
    this.fullName,
    this.profileImage,
    this.email,
    this.username,
    this.contactNumber,
    this.joiningDate,
    this.session,
    this.gender,
    this.dob,
    this.religion,
    this.rollNo,
    this.bloodGroup,
    this.schoolName,
    this.fatherName,
    this.scholarShip,
    this.languageKnown,
    this.shift,
    this.className,
    this.childrens,
    this.educationBackground,
    this.subject,
    this.createdBy,
    this.createdAt,
    this.v,
    this.modifiedAt,
    this.modifiedBy,
    this.citizenshipNo,
    this.experiencedYear,
    this.lisenceNo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        houseInfo: json["houseInfo"] == null
            ? null
            : HouseInfo.fromJson(json["houseInfo"]),
        transporation: json["transporation"] == null
            ? null
            : Transporation.fromJson(json["transporation"]),
        studentType: json["studentType"],
        languages: json["languages"] == null
            ? []
            : List<dynamic>.from(json["languages"]!.map((x) => x)),
        documets: json["documets"] == null
            ? []
            : List<dynamic>.from(json["documets"]!.map((x) => x)),
        group: json["group"],
        status: json["status"],
        isArchived: json["isArchived"],
        id: json["_id"],
        fullName: json["fullName"],
        profileImage: json["profileImage"],
        email: json["email"],
        username: json["username"],
        contactNumber: json["contactNumber"],
        joiningDate: json["joiningDate"] == null
            ? null
            : DateTime.parse(json["joiningDate"]),
        session: json["session"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        religion: json["religion"],
        rollNo: json["rollNo"],
        bloodGroup: json["bloodGroup"],
        schoolName: json["schoolName"],
        fatherName: json["fatherName"],
        scholarShip: json["scholarShip"] == null
            ? []
            : List<dynamic>.from(json["scholarShip"]!.map((x) => x)),
        languageKnown: json["languageKnown"] == null
            ? []
            : List<dynamic>.from(json["languageKnown"]!.map((x) => x)),
        shift: json["shift"] == null
            ? []
            : List<Shift>.from(json["shift"]!.map((x) => Shift.fromJson(x))),
        className: json["className"] == null
            ? []
            : List<dynamic>.from(json["className"]!.map((x) => x)),
        childrens: json["childrens"] == null
            ? []
            : List<dynamic>.from(json["childrens"]!.map((x) => x)),
        educationBackground: json["educationBackground"] == null
            ? []
            : List<dynamic>.from(json["educationBackground"]!.map((x) => x)),
        subject: json["subject"] == null
            ? []
            : List<dynamic>.from(json["subject"]!.map((x) => x)),
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        modifiedAt: json["modifiedAt"] == null
            ? null
            : DateTime.parse(json["modifiedAt"]),
        modifiedBy: json["modifiedBy"],
        citizenshipNo: json["citizenshipNo"],
        experiencedYear: json["experiencedYear"],
        lisenceNo: json["lisenceNo"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "houseInfo": houseInfo?.toJson(),
        "transporation": transporation?.toJson(),
        "studentType": studentType,
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "documets":
            documets == null ? [] : List<dynamic>.from(documets!.map((x) => x)),
        "group": group,
        "status": status,
        "isArchived": isArchived,
        "_id": id,
        "fullName": fullName,
        "profileImage": profileImage,
        "email": email,
        "username": username,
        "contactNumber": contactNumber,
        "joiningDate":
            "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "session": session,
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "religion": religion,
        "rollNo": rollNo,
        "bloodGroup": bloodGroup,
        "schoolName": schoolName,
        "fatherName": fatherName,
        "scholarShip": scholarShip == null
            ? []
            : List<dynamic>.from(scholarShip!.map((x) => x)),
        "languageKnown": languageKnown == null
            ? []
            : List<dynamic>.from(languageKnown!.map((x) => x)),
        "shift": shift == null
            ? []
            : List<dynamic>.from(shift!.map((x) => x.toJson())),
        "className": className == null
            ? []
            : List<dynamic>.from(className!.map((x) => x)),
        "childrens": childrens == null
            ? []
            : List<dynamic>.from(childrens!.map((x) => x)),
        "educationBackground": educationBackground == null
            ? []
            : List<dynamic>.from(educationBackground!.map((x) => x)),
        "subject":
            subject == null ? [] : List<dynamic>.from(subject!.map((x) => x)),
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "modifiedAt": modifiedAt?.toIso8601String(),
        "modifiedBy": modifiedBy,
        "citizenshipNo": citizenshipNo,
        "experiencedYear": experiencedYear,
        "lisenceNo": lisenceNo,
      };
}

class Address {
  String? country;
  String? state;
  String? city;
  String? district;
  String? muncipality;
  String? street;
  String? location;

  Address({
    this.country,
    this.state,
    this.city,
    this.district,
    this.muncipality,
    this.street,
    this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        state: json["state"],
        city: json["city"],
        district: json["district"],
        muncipality: json["muncipality"],
        street: json["street"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
        "district": district,
        "muncipality": muncipality,
        "street": street,
        "location": location,
      };
}

class HouseInfo {
  String? id;
  String? houseName;

  HouseInfo({
    this.id,
    this.houseName,
  });

  factory HouseInfo.fromJson(Map<String, dynamic> json) => HouseInfo(
        id: json["_id"],
        houseName: json["houseName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "houseName": houseName,
      };
}

class Shift {
  String? id;
  String? shift;
  String? startTime;
  String? endTime;

  Shift({
    this.id,
    this.shift,
    this.startTime,
    this.endTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["_id"],
        shift: json["shift"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shift": shift,
        "startTime": startTime,
        "endTime": endTime,
      };
}

class Transporation {
  String? id;
  String? name;

  Transporation({
    this.id,
    this.name,
  });

  factory Transporation.fromJson(Map<String, dynamic> json) => Transporation(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
