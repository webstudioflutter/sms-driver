// To parse this JSON data, do
//
//     final studentDetailListModel = studentDetailListModelFromJson(jsonString);

import 'dart:convert';

StudentDetailListModel studentDetailListModelFromJson(String str) =>
    StudentDetailListModel.fromJson(json.decode(str));

String studentDetailListModelToJson(StudentDetailListModel data) =>
    json.encode(data.toJson());

class StudentDetailListModel {
  String? message;
  List<Result>? result;
  int? count;
  String? error;

  StudentDetailListModel.withError(String errorValue) : error = errorValue;
  StudentDetailListModel({
    this.message,
    this.result,
    this.count,
  });

  factory StudentDetailListModel.fromJson(Map<String, dynamic> json) =>
      StudentDetailListModel(
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "count": count,
      };
}

class Result {
  Address? address;
  ClassName? className;
  dynamic shift;
  dynamic scholarShip;
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
  String? fullName;
  String? profileImage;
  String? email;
  String? username;
  int? contactNumber;
  DateTime? joiningDate;
  String? gender;
  DateTime? dob;
  String? religion;
  String? bloodGroup;
  String? schoolName;
  String? fatherName;
  String? occupation;
  List<LanguageKnown>? languageKnown;
  String? motherName;
  String? lisenceNo;
  List<ShiftElement>? teacherShift;
  List<dynamic>? childrens;
  List<EducationBackground>? educationBackground;
  String? aboutMe;
  List<Subject>? subject;
  String? createdBy;
  DateTime? createdAt;
  int? v;
  String? studentId;
  String? libraryId;
  String? motherTongue;
  String? session;
  String? rollNo;
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
    this.fullName,
    this.profileImage,
    this.email,
    this.username,
    this.contactNumber,
    this.joiningDate,
    this.gender,
    this.dob,
    this.religion,
    this.bloodGroup,
    this.schoolName,
    this.fatherName,
    this.occupation,
    this.languageKnown,
    this.motherName,
    this.lisenceNo,
    this.teacherShift,
    this.childrens,
    this.educationBackground,
    this.aboutMe,
    this.subject,
    this.createdBy,
    this.createdAt,
    this.v,
    this.studentId,
    this.libraryId,
    this.motherTongue,
    this.session,
    this.rollNo,
    this.modifiedAt,
    this.modifiedBy,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        className: json["className"] == null
            ? null
            : ClassName.fromJson(json["className"]),
        shift: json["shift"],
        scholarShip: json["scholarShip"],
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
        fullName: json["fullName"],
        profileImage: json["profileImage"],
        email: json["email"],
        username: json["username"],
        contactNumber: json["contactNumber"],
        joiningDate: json["joiningDate"] == null
            ? null
            : DateTime.parse(json["joiningDate"]),
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        religion: json["religion"],
        bloodGroup: json["bloodGroup"],
        schoolName: json["schoolName"],
        fatherName: json["fatherName"],
        occupation: json["occupation"],
        languageKnown: json["languageKnown"] == null
            ? []
            : List<LanguageKnown>.from(
                json["languageKnown"]!.map((x) => LanguageKnown.fromJson(x))),
        motherName: json["motherName"],
        lisenceNo: json["lisenceNo"],
        teacherShift: json["teacherShift"] == null
            ? []
            : List<ShiftElement>.from(
                json["teacherShift"]!.map((x) => ShiftElement.fromJson(x))),
        childrens: json["childrens"] == null
            ? []
            : List<dynamic>.from(json["childrens"]!.map((x) => x)),
        educationBackground: json["educationBackground"] == null
            ? []
            : List<EducationBackground>.from(json["educationBackground"]!
                .map((x) => EducationBackground.fromJson(x))),
        aboutMe: json["aboutMe"],
        subject: json["subject"] == null
            ? []
            : List<Subject>.from(
                json["subject"]!.map((x) => Subject.fromJson(x))),
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        studentId: json["studentId"],
        libraryId: json["libraryId"],
        motherTongue: json["motherTongue"],
        session: json["session"],
        rollNo: json["rollNo"],
        modifiedAt: json["modifiedAt"] == null
            ? null
            : DateTime.parse(json["modifiedAt"]),
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "className": className?.toJson(),
        "shift": shift,
        "scholarShip": scholarShip,
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
        "fullName": fullName,
        "profileImage": profileImage,
        "email": email,
        "username": username,
        "contactNumber": contactNumber,
        "joiningDate":
            "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "religion": religion,
        "bloodGroup": bloodGroup,
        "schoolName": schoolName,
        "fatherName": fatherName,
        "occupation": occupation,
        "languageKnown": languageKnown == null
            ? []
            : List<dynamic>.from(languageKnown!.map((x) => x.toJson())),
        "motherName": motherName,
        "lisenceNo": lisenceNo,
        "teacherShift": teacherShift == null
            ? []
            : List<dynamic>.from(teacherShift!.map((x) => x.toJson())),
        "childrens": childrens == null
            ? []
            : List<dynamic>.from(childrens!.map((x) => x)),
        "educationBackground": educationBackground == null
            ? []
            : List<dynamic>.from(educationBackground!.map((x) => x.toJson())),
        "aboutMe": aboutMe,
        "subject": subject == null
            ? []
            : List<dynamic>.from(subject!.map((x) => x.toJson())),
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "studentId": studentId,
        "libraryId": libraryId,
        "motherTongue": motherTongue,
        "session": session,
        "rollNo": rollNo,
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

class EducationBackground {
  String? id;
  String? fieldOfStudy;

  EducationBackground({
    this.id,
    this.fieldOfStudy,
  });

  factory EducationBackground.fromJson(Map<String, dynamic> json) =>
      EducationBackground(
        id: json["_id"],
        fieldOfStudy: json["fieldOfStudy"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fieldOfStudy": fieldOfStudy,
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

class LanguageKnown {
  String? id;
  String? language;

  LanguageKnown({
    this.id,
    this.language,
  });

  factory LanguageKnown.fromJson(Map<String, dynamic> json) => LanguageKnown(
        id: json["_id"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "language": language,
      };
}

class PickDropLocation {
  String? id;
  int? busCharge;
  String? busRoute;

  PickDropLocation({
    this.id,
    this.busCharge,
    this.busRoute,
  });

  factory PickDropLocation.fromJson(Map<String, dynamic> json) =>
      PickDropLocation(
        id: json["_id"],
        busCharge: json["busCharge"],
        busRoute: json["busRoute"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "busCharge": busCharge,
        "busRoute": busRoute,
      };
}

class ScholarShipElement {
  String? id;
  String? scholarshipName;
  String? value;

  ScholarShipElement({
    this.id,
    this.scholarshipName,
    this.value,
  });

  factory ScholarShipElement.fromJson(Map<String, dynamic> json) =>
      ScholarShipElement(
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

class PurpleScholarShip {
  String? id;
  String? scholarshipName;
  int? value;

  PurpleScholarShip({
    this.id,
    this.scholarshipName,
    this.value,
  });

  factory PurpleScholarShip.fromJson(Map<String, dynamic> json) =>
      PurpleScholarShip(
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

class ShiftElement {
  String? id;
  ShiftEnum? shift;
  StartTime? startTime;
  EndTime? endTime;

  ShiftElement({
    this.id,
    this.shift,
    this.startTime,
    this.endTime,
  });

  factory ShiftElement.fromJson(Map<String, dynamic> json) => ShiftElement(
        id: json["_id"],
        shift: shiftEnumValues.map[json["shift"]]!,
        startTime: startTimeValues.map[json["startTime"]]!,
        endTime: endTimeValues.map[json["endTime"]]!,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shift": shiftEnumValues.reverse[shift],
        "startTime": startTimeValues.reverse[startTime],
        "endTime": endTimeValues.reverse[endTime],
      };
}

enum EndTime { EMPTY, THE_1230, THE_1600 }

final endTimeValues = EnumValues(
    {"": EndTime.EMPTY, "12:30": EndTime.THE_1230, "16:00": EndTime.THE_1600});

enum ShiftEnum { DAY_SHIFT, EMPTY, MORNING_SHIFT }

final shiftEnumValues = EnumValues({
  "Day Shift": ShiftEnum.DAY_SHIFT,
  "": ShiftEnum.EMPTY,
  "Morning Shift": ShiftEnum.MORNING_SHIFT
});

enum StartTime { EMPTY, THE_1100, THE_1830 }

final startTimeValues = EnumValues({
  "": StartTime.EMPTY,
  "11:00": StartTime.THE_1100,
  "18:30": StartTime.THE_1830
});

class Subject {
  String? subjectName;

  Subject({
    this.subjectName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectName: json["subjectName"],
      );

  Map<String, dynamic> toJson() => {
        "subjectName": subjectName,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
