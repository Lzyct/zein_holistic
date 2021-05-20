class ListPatientRequest {
  final String? q;
  final int page;
  final bool isFirstPage;
  final String filterSelected;
  final String sexSelected;

  ListPatientRequest({
    this.q,
    required this.page,
    required this.isFirstPage,
    required this.filterSelected,
    required this.sexSelected,
  });

  toMap() {
    return {
      "q": q,
      "page": page,
      "filter": filterSelected,
      "sex": sexSelected,
    };
  }
}
