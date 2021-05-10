class CreatePatientRequest {
  final String name;
  final String sex;
  final String birthday;
  final String address;
  final String phoneNumber;

  CreatePatientRequest(
      {required this.name,
      required this.sex,
      required this.birthday,
      required this.address,
      required this.phoneNumber});
}
