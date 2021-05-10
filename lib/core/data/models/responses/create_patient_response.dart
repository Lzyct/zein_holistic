import 'package:zein_holistic/core/data/models/responses/diagnostic.dart';

class CreatePatientResponse {
  Diagnostic? diagnostic;
  Data? data;

  CreatePatientResponse({this.data});

  CreatePatientResponse.fromJson(Map<String, dynamic> json) {
    diagnostic = json['diagnostic'] != null
        ? new Diagnostic.fromJson(json['diagnostic'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diagnostic != null) {
      data['diagnostic'] = this.diagnostic?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? sex;
  String? birthday;
  String? address;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.name,
      this.sex,
      this.birthday,
      this.address,
      this.phoneNumber,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sex = json['sex'];
    birthday = json['birthday'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
