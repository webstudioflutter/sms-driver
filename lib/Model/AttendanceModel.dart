class AttendanceModel {
  int? count;
  List<Result>? result;
  String? error;

  AttendanceModel({this.count, this.result});
  AttendanceModel.withError(String errorValue) : error = errorValue;

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  User? user;
  Transporation? transporation;
  ClassName? className;
  String? attendaceType;
  String? createdAt;
  bool? isArchived;
  String? sId;
  String? schoolId;
  String? date;
  String? time;
  String? createdBy;
  bool? status;
  int? iV;

  Result({
    this.user,
    this.transporation,
    this.className,
    this.attendaceType,
    this.createdAt,
    this.isArchived,
    this.sId,
    this.schoolId,
    this.date,
    this.time,
    this.createdBy,
    this.status,
    this.iV,
  });

  Result.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    transporation = json['transporation'] != null
        ? new Transporation.fromJson(json['transporation'])
        : null;
    className =
        json['class'] != null ? new ClassName.fromJson(json['class']) : null;
    attendaceType = json['attendaceType'];
    createdAt = json['createdAt'];
    isArchived = json['isArchived'];
    sId = json['_id'];
    status=json['status'];
    schoolId = json['schoolId'];
    date = json['date'];
    time = json['time'];
    createdBy = json['createdBy'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.transporation != null) {
      data['transporation'] = this.transporation!.toJson();
    }
    if (this.className != null) {
      data['class'] = this.className!.toJson();
    }
    data['attendaceType'] = this.attendaceType;
    data['createdAt'] = this.createdAt;
    data['isArchived'] = this.isArchived;
    data['_id'] = this.sId;
    data['schoolId'] = this.schoolId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status']=this.status;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? profileImage;
  String? pickDropLocation;

  User({this.sId, this.name, this.profileImage, this.pickDropLocation});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    pickDropLocation = json['pickDropLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['pickDropLocation'] = this.pickDropLocation;
    return data;
  }
}

class Transporation {
  String? sId;
  String? name;

  Transporation({this.sId, this.name});

  Transporation.fromJson(Map<String, dynamic> json) {
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

class ClassName {
  String? sId;
  String? className;

  ClassName({this.sId, this.className});

  ClassName.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['className'] = this.className;
    return data;
  }
}
