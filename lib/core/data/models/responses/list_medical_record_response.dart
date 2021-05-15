import 'package:zein_holistic/core/data/models/responses/diagnostic.dart';

class ListMedicalRecordResponse {
  Diagnostic? diagnostic;
  List<Data>? data;
  Page? page;

  ListMedicalRecordResponse({this.diagnostic, this.data, this.page});

  ListMedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    diagnostic = json['diagnostic'] != null
        ? new Diagnostic.fromJson(json['diagnostic'])
        : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
      });
    }
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diagnostic != null) {
      data['diagnostic'] = this.diagnostic?.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    if (this.page != null) {
      data['page'] = this.page?.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? idPatient;
  String? mainComplaint;
  String? additionalComplaint;
  String? historyOfDisease;
  String? checkUpResult;
  String? conclusionDiagnosis;
  String? suggestion;
  String? examiner;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.idPatient,
      this.mainComplaint,
      this.additionalComplaint,
      this.historyOfDisease,
      this.checkUpResult,
      this.conclusionDiagnosis,
      this.suggestion,
      this.examiner,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPatient = json['idPatient'];
    mainComplaint = json['mainComplaint'];
    additionalComplaint = json['additionalComplaint'];
    historyOfDisease = json['historyOfDisease'];
    checkUpResult = json['checkUpResult'];
    conclusionDiagnosis = json['conclusionDiagnosis'];
    suggestion = json['suggestion'];
    examiner = json['examiner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idPatient'] = this.idPatient;
    data['mainComplaint'] = this.mainComplaint;
    data['additionalComplaint'] = this.additionalComplaint;
    data['historyOfDisease'] = this.historyOfDisease;
    data['checkUpResult'] = this.checkUpResult;
    data['conclusionDiagnosis'] = this.conclusionDiagnosis;
    data['suggestion'] = this.suggestion;
    data['examiner'] = this.examiner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Page {
  int? totalItems;
  int? currentPage;
  int? lastPage;

  Page({this.totalItems, this.currentPage, this.lastPage});

  Page.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['currentPage'] = this.currentPage;
    data['lastPage'] = this.lastPage;
    return data;
  }
}
