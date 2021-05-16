class ListMedicalRecordRequest {
  final String? q;
  final int page;
  final String idPatient;
  final bool isFirstPage;

  ListMedicalRecordRequest(
      {this.q,
      required this.page,
      required this.idPatient,
      required this.isFirstPage});

  toMap() {
    return {"q": q, "page": page, "idPatient": idPatient};
  }
}
