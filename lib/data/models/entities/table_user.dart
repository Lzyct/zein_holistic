class TableUser {
  String id;
  String name;
  String sex;
  String birthDay;
  String address;
  String phoneNumber;
  String createAt;
  String updateAt;

  TableUser(this.id, this.name, this.sex, this.birthDay, this.address,
      this.phoneNumber, this.createAt, this.updateAt);

  @override
  String toString() {
    return 'TableUser{id: $id, name: $name, sex: $sex, birthDay: $birthDay, address: $address, phoneNumber: $phoneNumber, createAt: $createAt, updateAt: $updateAt}';
  }
}
