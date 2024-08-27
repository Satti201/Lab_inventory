class DeviceModel {
  final int deviceId;
  late String deviceName;
  late int deviceTypeId;
  late String company;
  late String deviceType;
  late String size;
  late String deviceBarcode;
  late String containerBarcode;
  late int deviceStatus;
  late int qty;
  late String locationId;

  static const tblDevice = 'Device';
  static const colDeviceId = 'device_id';
  static const colDeviceName = 'device_name';
  static const colDeviceTypeId = 'device_type_id';
  static const colCompany = 'company';
  static const colDeviceType = 'device_type';
  static const colSize = 'size';
  static const colDeviceBarcode = 'device_barcode';
  static const colContainerBarcode = 'containerBarcode';
  static const colDeviceStatus = 'device_deviceStatus';
  static const colQty = 'qty';
  static const collocationId = 'l_id';

  DeviceModel(
      {required this.deviceId,
      required this.deviceName,
      required this.deviceTypeId,
      required this.company,
      required this.deviceType,
      required this.size,
      required this.deviceBarcode,
      required this.containerBarcode,
      required this.deviceStatus,
      required this.qty,
      required this.locationId});

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceId: json[colDeviceId],
      deviceName: json[colDeviceName],
      deviceTypeId: json[colDeviceTypeId],
      company: json[colCompany],
      deviceType: json[colDeviceType],
      size: json[colSize],
      deviceBarcode: json[colDeviceBarcode],
      containerBarcode: json[colContainerBarcode],
      deviceStatus: json[colDeviceStatus],
      qty: json[colQty],
      locationId: json[collocationId],
    );
  }

  Map<String, dynamic> toRoleMap() {
    var map = <String, dynamic>{
      colDeviceId: deviceId,
      colDeviceName: deviceName,
      colDeviceTypeId: deviceTypeId,
      colCompany: company,
      colDeviceType: deviceType,
      colSize: size,
      colDeviceBarcode: deviceBarcode,
      colContainerBarcode: containerBarcode,
      colDeviceStatus: deviceStatus,
      colQty: qty,
      collocationId: locationId
    };
    return map;
  }
}
