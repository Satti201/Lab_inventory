
class LocationModel{
  final int lId;
  late String lName;
  late int lcId;

  static const tblProgram='Location';
  static const colLId='l_id';
  static const collName= 'l_name';
  static const colLcId='lc_id';
  LocationModel({required this.lId, required this.lName, required this.lcId});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lId: json[colLId],
      lName: json[collName],
      lcId: json[colLcId],
    );
  }

  Map<String, dynamic> toLocationCategoryMap() {
    var map = <String, dynamic>{colLId: lId,collName: lName, colLcId: lcId};
    return map;
  }




}