
class StatusModel{
  final int statusId;
  late String statusType;

  static const tblStatus='Status';
  static const colStatusTypeId='s_id';
  static const colStatusType= 's_type';
  StatusModel({required this.statusId, required this.statusType});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      statusId: json[colStatusTypeId],
      statusType: json[colStatusType],
    );
  }

  Map<String, dynamic> toLocationCategoryMap() {
    var map = <String, dynamic>{colStatusTypeId: statusId,colStatusType: statusType};
    return map;
  }




}