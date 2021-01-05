class TableMedicalRecord {
  int id;
  String idUser;
  String mainComplaint;
  String additionalComplaint;
  String historyOfDisease;
  String checkUpResult;
  String conclusionDiagnosis;
  String suggestion;
  String examiner;
  String createAt;
  String updateAt;

  TableMedicalRecord(
      this.id,
      this.idUser,
      this.mainComplaint,
      this.additionalComplaint,
      this.historyOfDisease,
      this.checkUpResult,
      this.conclusionDiagnosis,
      this.suggestion,
      this.examiner,
      this.createAt,
      this.updateAt);

  @override
  String toString() {
    return 'TableMedicalRecord{id: $id, idUser: $idUser, mainComplaint: $mainComplaint, additionalComplaint: $additionalComplaint, historyOfDisease: $historyOfDisease, checkUpResult: $checkUpResult, conclusionDiagnosis: $conclusionDiagnosis, suggestion: $suggestion, examiner: $examiner, createAt: $createAt, updateAt: $updateAt}';
  }
}
