class ClassListModel {
  int? count;
  List<Result>? result;
  String? error;
  
  ClassListModel.withError(String errorValue) : error = errorValue;

  ClassListModel({this.count, this.result});

  ClassListModel.fromJson(Map<String, dynamic> json) {
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
  bool? status;
  String? createdAt;
  bool? isArchived;
  String? sId;
  String? schoolId;
  String? className;
  String? description;
  String? section;
  String? floor;
  String? block;
  String? createdBy;
  int? iV;

  Result(
      {this.status,
      this.createdAt,
      this.isArchived,
      this.sId,
      this.schoolId,
      this.className,
      this.description,
      this.section,
      this.floor,
      this.block,
      this.createdBy,
      this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    createdAt = json['createdAt'];
    isArchived = json['isArchived'];
    sId = json['_id'];
    schoolId = json['schoolId'];
    className = json['className'];
    description = json['description'];
    section = json['section'];
    floor = json['floor'];
    block = json['block'];
    createdBy = json['createdBy'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['isArchived'] = this.isArchived;
    data['_id'] = this.sId;
    data['schoolId'] = this.schoolId;
    data['className'] = this.className;
    data['description'] = this.description;
    data['section'] = this.section;
    data['floor'] = this.floor;
    data['block'] = this.block;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    return data;
  }
}
