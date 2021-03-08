class PatientEntity {
  String? id;
  String? name;
  String? sex;
  String? dateBirth;
  String? address;
  String? phoneNumber;
  String? createAt;
  String? updateAt;

  PatientEntity(
      {this.id,
      this.name,
      this.sex,
      this.dateBirth,
      this.address,
      this.phoneNumber,
      this.createAt,
      this.updateAt});

  @override
  String toString() {
    return 'TableUser{id: $id, name: $name, sex: $sex, dateBirth: $dateBirth, address: $address, phoneNumber: $phoneNumber, createAt: $createAt, updateAt: $updateAt}';
  }
}
