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
  ClassName? className;
  Shift? shift;
  ScholarShip? scholarShip;
  Info? motherInfo;
  Info? guardianInfo;
  HouseInfo? houseInfo;
  Transporation? transporation;
  PickDropLocation? pickDropLocation;
  String? studentType;
  List<dynamic>? languages;
  List<String>? documets;
  String? group;
  bool? status;
  bool? isArchived;
  String? id;
  String? studentId;
  String? libraryId;
  String? fullName;
  String? profileImage;
  String? email;
  String? username;
  int? contactNumber;
  String? motherTongue;
  DateTime? joiningDate;
  String? session;
  String? gender;
  DateTime? dob;
  String? religion;
  String? rollNo;
  String? bloodGroup;
  String? schoolName;
  String? fatherName;
  String? occupation;
  List<dynamic>? languageKnown;
  String? lisenceNo;
  String? citizenshipNo;
  int? experiencedYear;
  List<Shift>? teacherShift;
  List<dynamic>? teacherClassName;
  List<dynamic>? childrens;
  List<dynamic>? educationBackground;
  List<dynamic>? subject;
  String? fcmToken;
  String? createdBy;
  DateTime? createdAt;
  int? v;
  DateTime? modifiedAt;
  String? modifiedBy;

  Result({
    this.address,
    this.className,
    this.shift,
    this.scholarShip,
    this.motherInfo,
    this.guardianInfo,
    this.houseInfo,
    this.transporation,
    this.pickDropLocation,
    this.studentType,
    this.languages,
    this.documets,
    this.group,
    this.status,
    this.isArchived,
    this.id,
    this.studentId,
    this.libraryId,
    this.fullName,
    this.profileImage,
    this.email,
    this.username,
    this.contactNumber,
    this.motherTongue,
    this.joiningDate,
    this.session,
    this.gender,
    this.dob,
    this.religion,
    this.rollNo,
    this.bloodGroup,
    this.schoolName,
    this.fatherName,
    this.occupation,
    this.languageKnown,
    this.lisenceNo,
    this.citizenshipNo,
    this.experiencedYear,
    this.teacherShift,
    this.teacherClassName,
    this.childrens,
    this.educationBackground,
    this.subject,
    this.fcmToken,
    this.createdBy,
    this.createdAt,
    this.v,
    this.modifiedAt,
    this.modifiedBy,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        className: json["className"] == null
            ? null
            : ClassName.fromJson(json["className"]),
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        scholarShip: json["scholarShip"] == null
            ? null
            : ScholarShip.fromJson(json["scholarShip"]),
        motherInfo: json["motherInfo"] == null
            ? null
            : Info.fromJson(json["motherInfo"]),
        guardianInfo: json["guardianInfo"] == null
            ? null
            : Info.fromJson(json["guardianInfo"]),
        houseInfo: json["houseInfo"] == null
            ? null
            : HouseInfo.fromJson(json["houseInfo"]),
        transporation: json["transporation"] == null
            ? null
            : Transporation.fromJson(json["transporation"]),
        pickDropLocation: json["pickDropLocation"] == null
            ? null
            : PickDropLocation.fromJson(json["pickDropLocation"]),
        studentType: json["studentType"],
        languages: json["languages"] == null
            ? []
            : List<dynamic>.from(json["languages"]!.map((x) => x)),
        documets: json["documets"] == null
            ? []
            : List<String>.from(json["documets"]!.map((x) => x)),
        group: json["group"],
        status: json["status"],
        isArchived: json["isArchived"],
        id: json["_id"],
        studentId: json["studentId"],
        libraryId: json["libraryId"],
        fullName: json["fullName"],
        profileImage: json["profileImage"],
        email: json["email"],
        username: json["username"],
        contactNumber: json["contactNumber"],
        motherTongue: json["motherTongue"],
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
        occupation: json["occupation"],
        languageKnown: json["languageKnown"] == null
            ? []
            : List<dynamic>.from(json["languageKnown"]!.map((x) => x)),
        lisenceNo: json["lisenceNo"],
        citizenshipNo: json["citizenshipNo"],
        experiencedYear: json["experiencedYear"],
        teacherShift: json["teacherShift"] == null
            ? []
            : List<Shift>.from(
                json["teacherShift"]!.map((x) => Shift.fromJson(x))),
        teacherClassName: json["teacherClassName"] == null
            ? []
            : List<dynamic>.from(json["teacherClassName"]!.map((x) => x)),
        childrens: json["childrens"] == null
            ? []
            : List<dynamic>.from(json["childrens"]!.map((x) => x)),
        educationBackground: json["educationBackground"] == null
            ? []
            : List<dynamic>.from(json["educationBackground"]!.map((x) => x)),
        subject: json["subject"] == null
            ? []
            : List<dynamic>.from(json["subject"]!.map((x) => x)),
        fcmToken: json["fcmToken"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        modifiedAt: json["modifiedAt"] == null
            ? null
            : DateTime.parse(json["modifiedAt"]),
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "className": className?.toJson(),
        "shift": shift?.toJson(),
        "scholarShip": scholarShip?.toJson(),
        "motherInfo": motherInfo?.toJson(),
        "guardianInfo": guardianInfo?.toJson(),
        "houseInfo": houseInfo?.toJson(),
        "transporation": transporation?.toJson(),
        "pickDropLocation": pickDropLocation?.toJson(),
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
        "studentId": studentId,
        "libraryId": libraryId,
        "fullName": fullName,
        "profileImage": profileImage,
        "email": email,
        "username": username,
        "contactNumber": contactNumber,
        "motherTongue": motherTongue,
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
        "occupation": occupation,
        "languageKnown": languageKnown == null
            ? []
            : List<dynamic>.from(languageKnown!.map((x) => x)),
        "lisenceNo": lisenceNo,
        "citizenshipNo": citizenshipNo,
        "experiencedYear": experiencedYear,
        "teacherShift": teacherShift == null
            ? []
            : List<dynamic>.from(teacherShift!.map((x) => x.toJson())),
        "teacherClassName": teacherClassName == null
            ? []
            : List<dynamic>.from(teacherClassName!.map((x) => x)),
        "childrens": childrens == null
            ? []
            : List<dynamic>.from(childrens!.map((x) => x)),
        "educationBackground": educationBackground == null
            ? []
            : List<dynamic>.from(educationBackground!.map((x) => x)),
        "subject":
            subject == null ? [] : List<dynamic>.from(subject!.map((x) => x)),
        "fcmToken": fcmToken,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "modifiedAt": modifiedAt?.toIso8601String(),
        "modifiedBy": modifiedBy,
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

class ClassName {
  String? id;
  String? classNameClass;
  String? section;

  ClassName({
    this.id,
    this.classNameClass,
    this.section,
  });

  factory ClassName.fromJson(Map<String, dynamic> json) => ClassName(
        id: json["_id"],
        classNameClass: json["class"],
        section: json["section"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "class": classNameClass,
        "section": section,
      };
}

class Info {
  String? name;
  String? email;
  String? contactNumber;
  String? address;
  String? occupation;
  String? relation;

  Info({
    this.name,
    this.email,
    this.contactNumber,
    this.address,
    this.occupation,
    this.relation,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        name: json["name"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        address: json["address"],
        occupation: json["occupation"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "contactNumber": contactNumber,
        "address": address,
        "occupation": occupation,
        "relation": relation,
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

class PickDropLocation {
  String? id;
  String? busRoute;
  dynamic busCharge;

  PickDropLocation({
    this.id,
    this.busRoute,
    this.busCharge,
  });

  factory PickDropLocation.fromJson(Map<String, dynamic> json) =>
      PickDropLocation(
        id: json["_id"],
        busRoute: json["busRoute"],
        busCharge: json["busCharge"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "busRoute": busRoute,
        "busCharge": busCharge,
      };
}

class ScholarShip {
  String? id;
  String? scholarshipName;
  dynamic value;

  ScholarShip({
    this.id,
    this.scholarshipName,
    this.value,
  });

  factory ScholarShip.fromJson(Map<String, dynamic> json) => ScholarShip(
        id: json["_id"],
        scholarshipName: json["scholarshipName"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "scholarshipName": scholarshipName,
        "value": value,
      };
}

class Shift {
  String? shift;
  String? startTime;
  String? endTime;
  String? id;

  Shift({
    this.shift,
    this.startTime,
    this.endTime,
    this.id,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        shift: json["shift"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "shift": shift,
        "startTime": startTime,
        "endTime": endTime,
        "_id": id,
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
