class UserModel {
  late int userId;
  late String userName;
  late String userEmail;
  late String userPassword;
  late int roleId;

  static const tblProgram = 'User';
  static const colUserId = 'user_id';
  static const colUserName = 'user_name';
  static const colUserEmail = 'user_email';
  static const colUserPassword = 'user_password';
  static const colRoleId = 'role_id';

  UserModel(
      {required this.userId,
      required this.roleId,
      required this.userEmail,
      required this.userName,
      required this.userPassword});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json[colUserId],
      userName: json[colUserName],
      userEmail: json[colUserEmail],
      userPassword: json[colUserPassword],
      roleId: json[colRoleId],
    );
  }

  Map<String, dynamic> toUserMap() {
    var map = <String, dynamic>{
      colUserId: userId,
      colUserName: userName,
      colUserEmail: userEmail,
      colUserPassword: userPassword,
      colRoleId: roleId
    };
    return map;
  }
}
