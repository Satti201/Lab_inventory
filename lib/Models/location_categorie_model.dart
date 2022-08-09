
class LocationCategoryModel{
  final int lcId;
  late String lcName;

  static const tblProgram='LocationCategorie';
  static const colLcId='lc_id';
  static const collcName= 'lc_name';
  LocationCategoryModel({required this.lcId, required this.lcName});

  factory LocationCategoryModel.fromJson(Map<String, dynamic> json) {
    return LocationCategoryModel(
      lcId: json[colLcId],
      lcName: json[collcName],
    );
  }

  Map<String, dynamic> toLocationCategoryMap() {
    var map = <String, dynamic>{collcName: lcName, colLcId: lcId};
    return map;
  }




}