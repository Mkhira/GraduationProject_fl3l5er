class RegisterModel {
  String email;
  String firstName;
  String lastName;
  String nickName;
  String password;
  String cardId;
  String gender;
  String jop;
  String salary;
  String maritalStatus;
  String kidsNum;
  String address;
  String date;
  String phone;


  RegisterModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.nickName,
      this.password,
      this.cardId,
      this.address,
      this.date,
      this.phone,
      this.jop,
      this.gender,
      this.kidsNum,
      this.maritalStatus,
      this.salary});
  Map<String ,dynamic> tomap(){
    return{
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "nickName":nickName,
      "password":password,
      "cardId":cardId,
      "address":address,
      "date":date,
      "phone":phone,
      "jop":jop,
      "gender":gender,
      "kidsNum":kidsNum,
      "maritalStatus":maritalStatus,
      "salary":salary,
    };
  }
}
