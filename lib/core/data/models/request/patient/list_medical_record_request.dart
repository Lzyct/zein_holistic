class ListMedicalRecordRequest {
  final String? q;
  final int page;
  final String idPatient;

  ListMedicalRecordRequest(
      {this.q, required this.page, required this.idPatient});

  toMap() {
    return {"q": q, "page": page, "idPatient": idPatient};
  }
}
