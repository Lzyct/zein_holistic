class MedicalRecordEntity {
  int id;
  String idPatient;
  String mainComplaint;
  String additionalComplaint;
  String historyOfDisease;
  String checkUpResult;
  String conclusionDiagnosis;
  String suggestion;
  String examiner;
  String createAt;
  String updateAt;

  MedicalRecordEntity(
      {this.id,
      this.idPatient,
      this.mainComplaint,
      this.additionalComplaint,
      this.historyOfDisease,
      this.checkUpResult,
      this.conclusionDiagnosis,
      this.suggestion,
      this.examiner,
      this.createAt,
      this.updateAt});

  @override
  String toString() {
    return 'TableMedicalRecord{id: $id, idPatient: $idPatient, mainComplaint: $mainComplaint, additionalComplaint: $additionalComplaint, historyOfDisease: $historyOfDisease, checkUpResult: $checkUpResult, conclusionDiagnosis: $conclusionDiagnosis, suggestion: $suggestion, examiner: $examiner, createAt: $createAt, updateAt: $updateAt}';
  }
}
