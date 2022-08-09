
class DemandModel{
  late int demandId;
  late String demandName;
  late int qty;
  late int expenditure;
  late int total;

  static const tblDemand='Demand';
  static const colDemandId='demand_id';
  static const colDemandName='name';
  static const colQty='qty';
  static const colExpenditure='expendicture';
  static const colTotal='total';

  DemandModel({required this.demandId, required this.total, required this.qty, required this.demandName, required this.expenditure});

  factory DemandModel.fromJson(Map<String, dynamic> json) {
    return DemandModel(
      demandId: json[colDemandId],
      demandName: json[colDemandName],
      qty: json[colQty],
      expenditure: json[colExpenditure],
      total: json[colTotal],
    );
  }


  Map<String, dynamic> toUserMap() {
    var map = <String, dynamic>{colDemandId: demandId, colDemandName: demandName, colQty: qty, colExpenditure: expenditure, colTotal: total};
    return map;
  }




}