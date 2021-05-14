class PatientRequest {
  final String name;
  final String sex;
  final String birthday;
  final String address;
  final String phoneNumber;

  PatientRequest(
      {required this.name,
      required this.sex,
      required this.birthday,
      required this.address,
      required this.phoneNumber});

  toMap() {
    return {
      "name": name,
      "sex": sex,
      "birthday": birthday,
      "address": address,
      "phoneNumber": phoneNumber
    };
  }
}
