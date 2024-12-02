// To parse this JSON data, do
//
//     final studentDetailListModel = studentDetailListModelFromJson(jsonString);

import 'dart:convert';

StudentDetailListModel studentDetailListModelFromJson(String str) => StudentDetailListModel.fromJson(json.decode(str));

String studentDetailListModelToJson(StudentDetailListModel data) => json.encode(data.toJson());

class StudentDetailListModel {
    String? message;
    int? count;
    List<Result>? result;
      String? error;

  StudentDetailListModel.withError(String errorValue) : error = errorValue;

    StudentDetailListModel({
        this.message,
        this.count,
        this.result,
    });

    factory StudentDetailListModel.fromJson(Map<String, dynamic> json) => StudentDetailListModel(
        message: json["message"],
        count: json["count"],
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    Address? address;
    List<ClassName>? className;
    List<Shift>? shift;
    List<ScholarShip>? scholarShip;
    Info? motherInfo;
    Info? guardianInfo;
    HouseInfo? houseInfo;
    Transporation? transporation;
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
    List<LanguageKnown>? languageKnown;
    List<dynamic>? childrens;
    List<dynamic>? educationBackground;
    List<dynamic>? subject;
    String? createdBy;
    DateTime? createdAt;
    int? v;
    DateTime? modifiedAt;
    String? modifiedBy;
    List<dynamic>? teacherShift;
    List<dynamic>? teacherClassName;

    Result({
        this.address,
        this.className,
        this.shift,
        this.scholarShip,
        this.motherInfo,
        this.guardianInfo,
        this.houseInfo,
        this.transporation,
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
        this.languageKnown,
        this.childrens,
        this.educationBackground,
        this.subject,
        this.createdBy,
        this.createdAt,
        this.v,
        this.modifiedAt,
        this.modifiedBy,
        this.teacherShift,
        this.teacherClassName,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        className: json["className"] == null ? [] : List<ClassName>.from(json["className"]!.map((x) => ClassName.fromJson(x))),
        shift: json["shift"] == null ? [] : List<Shift>.from(json["shift"]!.map((x) => Shift.fromJson(x))),
        scholarShip: json["scholarShip"] == null ? [] : List<ScholarShip>.from(json["scholarShip"]!.map((x) => ScholarShip.fromJson(x))),
        motherInfo: json["motherInfo"] == null ? null : Info.fromJson(json["motherInfo"]),
        guardianInfo: json["guardianInfo"] == null ? null : Info.fromJson(json["guardianInfo"]),
        houseInfo: json["houseInfo"] == null ? null : HouseInfo.fromJson(json["houseInfo"]),
        transporation: json["transporation"] == null ? null : Transporation.fromJson(json["transporation"]),
        studentType: json["studentType"],
        languages: json["languages"] == null ? [] : List<dynamic>.from(json["languages"]!.map((x) => x)),
        documets: json["documets"] == null ? [] : List<String>.from(json["documets"]!.map((x) => x)),
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
        joiningDate: json["joiningDate"] == null ? null : DateTime.parse(json["joiningDate"]),
        session: json["session"],
        gender: json["gender"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        religion: json["religion"],
        rollNo: json["rollNo"],
        bloodGroup: json["bloodGroup"],
        schoolName: json["schoolName"],
        fatherName: json["fatherName"],
        languageKnown: json["languageKnown"] == null ? [] : List<LanguageKnown>.from(json["languageKnown"]!.map((x) => LanguageKnown.fromJson(x))),
        childrens: json["childrens"] == null ? [] : List<dynamic>.from(json["childrens"]!.map((x) => x)),
        educationBackground: json["educationBackground"] == null ? [] : List<dynamic>.from(json["educationBackground"]!.map((x) => x)),
        subject: json["subject"] == null ? [] : List<dynamic>.from(json["subject"]!.map((x) => x)),
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        modifiedAt: json["modifiedAt"] == null ? null : DateTime.parse(json["modifiedAt"]),
        modifiedBy: json["modifiedBy"],
        teacherShift: json["teacherShift"] == null ? [] : List<dynamic>.from(json["teacherShift"]!.map((x) => x)),
        teacherClassName: json["teacherClassName"] == null ? [] : List<dynamic>.from(json["teacherClassName"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "className": className == null ? [] : List<dynamic>.from(className!.map((x) => x.toJson())),
        "shift": shift == null ? [] : List<dynamic>.from(shift!.map((x) => x.toJson())),
        "scholarShip": scholarShip == null ? [] : List<dynamic>.from(scholarShip!.map((x) => x.toJson())),
        "motherInfo": motherInfo?.toJson(),
        "guardianInfo": guardianInfo?.toJson(),
        "houseInfo": houseInfo?.toJson(),
        "transporation": transporation?.toJson(),
        "studentType": studentType,
        "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
        "documets": documets == null ? [] : List<dynamic>.from(documets!.map((x) => x)),
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
        "joiningDate": "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "session": session,
        "gender": gender,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "religion": religion,
        "rollNo": rollNo,
        "bloodGroup": bloodGroup,
        "schoolName": schoolName,
        "fatherName": fatherName,
        "languageKnown": languageKnown == null ? [] : List<dynamic>.from(languageKnown!.map((x) => x.toJson())),
        "childrens": childrens == null ? [] : List<dynamic>.from(childrens!.map((x) => x)),
        "educationBackground": educationBackground == null ? [] : List<dynamic>.from(educationBackground!.map((x) => x)),
        "subject": subject == null ? [] : List<dynamic>.from(subject!.map((x) => x)),
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "modifiedAt": modifiedAt?.toIso8601String(),
        "modifiedBy": modifiedBy,
        "teacherShift": teacherShift == null ? [] : List<dynamic>.from(teacherShift!.map((x) => x)),
        "teacherClassName": teacherClassName == null ? [] : List<dynamic>.from(teacherClassName!.map((x) => x)),
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
    String? address;
    String? contactNumber;
    String? email;
    String? name;
    String? occupation;
    String? relation;

    Info({
        this.address,
        this.contactNumber,
        this.email,
        this.name,
        this.occupation,
        this.relation,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        address: json["address"],
        contactNumber: json["contactNumber"],
        email: json["email"],
        name: json["name"],
        occupation: json["occupation"],
        relation: json["relation"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "contactNumber": contactNumber,
        "email": email,
        "name": name,
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

class ScholarShip {
    String? id;
    String? scholarshipName;
    String? value;

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
