
class ContainerModel{
  final int containerId;
  late int containerTypeId;
  late String itemName;
  late String company;
  late String processorName;
  late String generation;
  late double baseSpeed;
  late int locationId;
  late int status;
  late int totalAmount;
  late String barcode;

  static const tblContainer='Container';
  static const colContainerId='c_id';
  static const colContainerTypeId= 'ct_id';
  static const colItemName= 'itrm_name';
  static const colCompany= 'company';
  static const colProcessorName= 'processor_name';
  static const colGeneration= 'generation';
  static const colBaseSpeed= 'base_speed';
  static const collocationId= 'l_id';
  static const colStatus= 'status';
  static const colTotalAmount= 'total_amount';
  static const colBarcode= 'barcode';

  ContainerModel({required this.containerId, required this.containerTypeId, required this.itemName
  , required this.company, required this.processorName, required this.generation,
  required this.baseSpeed, required this.locationId, required this.status, required this.totalAmount,
  required this.barcode});

  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    return ContainerModel(
      containerId: json[colContainerId],
      containerTypeId: json[colContainerTypeId],
      itemName: json[colItemName],
      company: json[colCompany],
      processorName: json[colProcessorName],
      generation: json[colGeneration],
      baseSpeed: json[colBaseSpeed],
      locationId: json[collocationId],
      status: json[colStatus],
      totalAmount: json[colTotalAmount],
      barcode: json[colBarcode],
    );
  }


  Map<String, dynamic> toRoleMap() {
    var map = <String, dynamic>{colContainerId: containerId, colContainerTypeId: containerTypeId,
    colItemName: itemName, colCompany: company, colProcessorName: processorName,
    colGeneration: generation, colBaseSpeed: baseSpeed, collocationId: locationId,
    colStatus: status, colTotalAmount: totalAmount, colBarcode: barcode};
    return map;
  }




}