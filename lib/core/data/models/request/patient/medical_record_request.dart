class MedicalRecordRequest {
  final String idPatient;
  final String mainComplaint;
  final String? additionalComplaint;
  final String? historyOfDisease;
  final String? checkUpResult;
  final String? conclusionDiagnosis;
  final String? suggestion;
  final String? examiner;

  MedicalRecordRequest(
      {required this.idPatient,
      required this.mainComplaint,
      this.additionalComplaint,
      this.historyOfDisease,
      this.checkUpResult,
      this.conclusionDiagnosis,
      this.suggestion,
      this.examiner});

  toMap() {
    return {
      "idPatient": idPatient,
      "mainComplaint": mainComplaint,
      "additionalComplaint": additionalComplaint,
      "historyOfDisease": historyOfDisease,
      "checkUpResult": checkUpResult,
      "conclusionDiagnosis": conclusionDiagnosis,
      "suggestion": suggestion,
      "examiner": examiner,
    };
  }
}
