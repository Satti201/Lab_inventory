
class RolesModel{
  final int roleId;
  late String roleType;
  late bool addAccount;
  late bool viewAccount;
  late bool addStock;
  late bool cToUsedItem;
  late bool cToFaulty;
  late bool cToDiscard;
  late bool addDemand;
  late bool viewDemand;

  static const tblRole='Role';
  static const colRoleId='role_id';
  static const colRoleName= 'role_type';
  static const colAddAccount= 'add_account';
  static const colViewAccount= 'view_account';
  static const colAddStock= 'add_stock';
  static const colCToUsedItem= 'c_to_usedItem';
  static const colCToFaulty= 'c_to_faulty';
  static const colToDiscard= 'c_to_discard';
  static const colAddDemand= 'add_demand';
  static const colViewDemand= 'view_demand';
  RolesModel({required this.roleId, required this.roleType,
  required this.addAccount, required this.viewAccount, required this.addStock,
  required this.cToUsedItem, required this.cToFaulty, required this.cToDiscard,
  required this.viewDemand, required this.addDemand});

  factory RolesModel.fromJson(Map<String, dynamic> json) {
    return RolesModel(
      roleId: json[colRoleId],
      roleType: json[colRoleName],
      addAccount: json[colAddAccount],
      viewAccount: json[colViewAccount],
      addStock: json[colAddStock],
      cToUsedItem: json[colCToUsedItem],
      cToFaulty: json[colCToFaulty],
      cToDiscard: json[colToDiscard],
      addDemand: json[colAddDemand],
      viewDemand: json[colViewDemand],
    );
  }


  Map<String, dynamic> toRoleMap() {
    var map = <String, dynamic>{colRoleName: roleType, colRoleId: roleId, colAddAccount: addAccount,
    colViewAccount: viewAccount, colAddStock: addStock, colCToUsedItem: cToUsedItem,
    colCToFaulty: cToFaulty, colToDiscard: cToDiscard, colAddDemand: addDemand,
    colViewDemand: viewDemand};
    return map;
  }




}