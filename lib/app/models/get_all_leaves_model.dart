class GetAllLeaveModel {
  String? status;
  String? msg;
  List<LeaveData>? data = [];

  GetAllLeaveModel({this.status, this.msg, this.data});

  GetAllLeaveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(LeaveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveData {
  String? id;
  String? name;
  String? email;
  String? reason;
  String? status;
  String? dateFrom;
  String? dateTo;

  LeaveData(
      {this.id,
      this.name,
      this.email,
      this.reason,
      this.status,
      this.dateFrom,
      this.dateTo});

  LeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    reason = json['reason'];
    status = json['status'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    return data;
  }
}
