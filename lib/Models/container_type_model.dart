
class ContainerTypeModel{
  final int ctId;
  late String cTypeName;

  static const tblContainerType='ContainerType';
  static const colTypeId='ct_id';
  static const colTypeName= 'c_type_name';
  ContainerTypeModel({required this.ctId, required this.cTypeName});

  factory ContainerTypeModel.fromJson(Map<String, dynamic> json) {
    return ContainerTypeModel(
      ctId: json[colTypeId],
      cTypeName: json[colTypeName],
    );
  }

  Map<String, dynamic> toLocationCategoryMap() {
    var map = <String, dynamic>{colTypeId: ctId,colTypeName: cTypeName};
    return map;
  }




}