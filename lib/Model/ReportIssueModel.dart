import 'dart:convert';

// Function to parse JSON data into ReportIssueModel
ReportIssueModel reportIssueModelFromJson(String str) =>
    ReportIssueModel.fromJson(json.decode(str));

// Function to convert ReportIssueModel to JSON string
String reportIssueModelToJson(ReportIssueModel data) =>
    json.encode(data.toJson());

class ReportIssueModel {
  int? count;
  List<Result>? result;
  String? error;

  ReportIssueModel({
    this.count,
    this.result,
  });

  // Error constructor
  ReportIssueModel.withError(String errorValue) : error = errorValue;

  // Factory method to parse JSON
  factory ReportIssueModel.fromJson(Map<String, dynamic> json) =>
      ReportIssueModel(
        count: json["count"] as int?,
        result: json["result"] != null && json["result"] is List
            ? List<Result>.from(
                json["result"].map((x) => Result.fromJson(x)),
              )
            : [], // Handle null or unexpected types
      );

  // Method to convert object to JSON
  Map<String, dynamic> toJson() => {
        "count": count,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Info? driverInfo;
  Info? vehicleInfo;
  List<String>? issues;
  List<dynamic>? issuesImages;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  DateTime? date;
  String? issuesStatus;
  String? createdBy;
  int? v;

  Result({
    this.driverInfo,
    this.vehicleInfo,
    this.issues,
    this.issuesImages,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.date,
    this.issuesStatus,
    this.createdBy,
    this.v,
  });

  // Factory method to parse JSON
  factory Result.fromJson(Map<String, dynamic> json) => Result(
        driverInfo: json["driverInfo"] != null
            ? Info.fromJson(json["driverInfo"])
            : null,
        vehicleInfo: json["vehicleInfo"] != null
            ? Info.fromJson(json["vehicleInfo"])
            : null,
        issues: json["issues"] != null && json["issues"] is List
            ? List<String>.from(json["issues"].map((x) => x.toString()))
            : [],
        issuesImages:
            json["issuesImages"] != null && json["issuesImages"] is List
                ? List<dynamic>.from(json["issuesImages"].map((x) => x))
                : [],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        isArchived: json["isArchived"] as bool?,
        id: json["_id"] as String?,
        schoolId: json["schoolId"] as String?,
        date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
        issuesStatus: json["issuesStatus"] as String?,
        createdBy: json["createdBy"] as String?,
        v: json["__v"] as int?,
      );

  // Method to convert object to JSON
  Map<String, dynamic> toJson() => {
        "driverInfo": driverInfo?.toJson(),
        "vehicleInfo": vehicleInfo?.toJson(),
        "issues":
            issues == null ? [] : List<dynamic>.from(issues!.map((x) => x)),
        "issuesImages": issuesImages == null
            ? []
            : List<dynamic>.from(issuesImages!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "date": date?.toIso8601String(),
        "issuesStatus": issuesStatus,
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

  // Factory method to parse JSON
  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["_id"] as String?,
        name: json["name"] as String?,
      );

  // Method to convert object to JSON
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
