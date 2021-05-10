class ListPatientRequest {
  final String? q;
  final int page;

  ListPatientRequest({this.q, required this.page});

  toMap() {
    return {"q": q, "page": page};
  }
}
