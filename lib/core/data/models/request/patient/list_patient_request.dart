class ListPatientRequest {
  final String? q;
  final int page;
  final bool isFirstPage;

  ListPatientRequest({this.q, required this.page, required this.isFirstPage});

  toMap() {
    return {"q": q, "page": page};
  }
}
