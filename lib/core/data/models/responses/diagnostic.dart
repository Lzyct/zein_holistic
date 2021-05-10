class Diagnostic {
  int? code;
  String? status;

  Diagnostic({this.status, this.code});

  Diagnostic.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}
